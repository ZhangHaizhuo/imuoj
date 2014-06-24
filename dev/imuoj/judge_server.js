/**
 * Created by friskit on 14-6-13.
 */

var async = require('async');
var uuid = require('node-uuid');
var fs = require('fs');
var exec = require('child_process').exec;

var log4js = require('./logger_helper').log4js;
var judge_logger = log4js.getLogger('judge');

var gs = require('./global_setting');
var dbHelper = require('./db_helper');



//start judge server
module.exports.run = function(){
    judge_logger.info('Judge Server has started!');
    //reset CJ solutions //////////////////////////////////////////////

    //set async queue
    judge_logger.debug('Creating async queue....');
    var queue = async.queue(judgeClient, gs.judge_setting.concurrency);
    judge_logger.debug('Creating async queue.... Done');


    //Polling latest work in pending queue
    setInterval(function(queue){
        return function(){
            polling(queue);
        }
    }(queue),gs.judge_setting.poll_time);
}

/**
 * Polling
 * */
function polling(queue){
    var querySQL = 'SELECT * FROM imuoj_solution WHERE run_state=?';
    var queryData = [gs.run_states.PD.id];
    dbHelper.getPool().query(querySQL, queryData, function(err, solution_rows, fields){
        if (err) throw err;
        for(var item in solution_rows){
            //update run_state to 'compile and judge'
            var updateSQL = 'UPDATE imuoj_solution SET run_state=? where solution_id=?';
            var updateData = [gs.run_states.CJ.id, solution_rows[item].solution_id];
            dbHelper.getPool().query(updateSQL,updateData,doEachSolution(item));
        }

        function doEachSolution(item){
            return function(err, rows, fields){
                if (err) throw err;
                queue.push(solution_rows[item]);
            }
        }
    });
}



/**
 * judgeClient
 * @param solutionID
 * */
function judgeClient(solution_row, callback){
    var solution_id = solution_row.solution_id;
    var run_state = 'CJ';   //current run_state is 'compile and judge'
    judge_logger.info('['+solution_id+'] Starting Judge client of solution '+solution_id);

    //get source code;
    var queryStr = 'select source from imuoj_source where solution_id=?';
    var queryData = [solution_id];
    dbHelper.getPool().query(queryStr, queryData, function(err, rows, field){
        if (err) {
            judge_logger.error('['+solution_id+'] Judge client got a database error: '+err);
            callback(err)
        };
        if(rows[0]){
            judge_logger.debug('['+solution_id+'] Judge client got source of solution '+solution_id);
            //make run dir
            var client_uuid = uuid.v4();
            var client_dir = gs.dirs.run_dir+'/'+client_uuid;
            try{
                fs.mkdirSync(client_dir,0777);  //may need to change;
                judge_logger.debug('['+solution_id+'] Judge client chang pwd to: '+process.cwd());
            }catch(err){
                judge_logger.error('['+solution_id+'] An error occurred when mkdir: '+err);
                callback(err);
                return;
            }
            judge_logger.debug('['+solution_id+'] Judge client mkdir: '+client_dir);
            //change dir to data
            process.chdir(client_dir);
            //save source code
            var sourceFile = client_dir+'/Main'+gs.program_language_type[solution_row.submit_language].extension;
            fs.writeFileSync(sourceFile, rows[0].source);

            //compile source file
            var compileExec = exec(gs.program_language_type[solution_row.submit_language].compile_str,
                function(error, stdout, stderr){
                    if(stderr.length!=0){//got compile error;
                        judge_logger.info('['+solution_id+'] An compile error occurred when compile');
                        run_state = 'CE';
                    }else{//no CE occurred
                        //run and judge
                        //get '*.in's
                        var data_dir = gs.dirs.data_dir+'/'+solution_row.problem_id;
                        var inFiles = fs.readdirSync(data_dir).filter(function(element){
                            return element.lastIndexOf('.in')!=-1;
                        });
                        var problemQueue = async.queue(judgeProblemQueue,1);    //concurrency=1
                        var problemQuerySQL = 'SELECT * FROM imuoj_problem WHERE problem_id=?';
                        var problemQueryData = [solution_row.problem_id];
                        dbHelper.getPool().query(problemQuerySQL,problemQueryData,function(err, problem_rows, fields){
                            if(err) {
                                judge_logger.error('[' + solution_id + '] An error occurred when query problem from db: ' + err);
                                return;
                            }
                            if(problem_rows[0]==null) {
                                judge_logger.warn('[' + solution_id + '] judge client did not find problem');
                                return;
                            }
                            for(var inFileName in inFiles){
                                var inFilePath = data_dir+'/'+inFiles[inFileName];
                                var outFileName = inFiles[inFileName].split('.in')[0]+'.out';
                                var outFilePath = data_dir+'/'+outFileName;
                                var options = {
                                    problemId: solution_row.problem_id,
                                    inFileName: inFiles[inFileName],
                                    inFilePath: inFilePath,
                                    outFilePath: outFilePath,
                                    runFilePath: client_dir + '/Main',
                                    quotaWallClock: gs.judge_setting.quota_wall_clock,
                                    quotaDiskSpace: gs.judge_setting.quota_disk_space,
                                    quotaCPUClock: problem_rows[0].quota_time,
                                    quotaMemory: problem_rows[0].quota_memory
                                }
                                problemQueue.push(options);
                            }
                        })
                    }
                    if(error!=null)
                        judge_logger.error('['+solution_id+'] An error occurred when compile: '+err);
            });
            //rm dir
            try{
                //fs.rmdirSync(client_dir);
                judge_logger.debug('['+solution_id+'] Judge client rmdir: '+client_dir);
            }catch(err){
                judge_logger.error('['+solution_id+'] An error occurred when rmdir: '+err);
                callback(err);
                return;
            }
        }else{
            judge_logger.warn('Judge client got a job but cannot find source: solution_id='+solution_id);
        }
        judge_logger.debug('['+solution_id+'] Judge client finished all works! ');
        callback();
    });
}

function judgeProblemQueue(options, callback){
    var run_str = ['sandbox','s','d'].join(' ');
    console.log(run_str);
    callback();
}

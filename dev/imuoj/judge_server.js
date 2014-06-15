/**
 * Created by friskit on 14-6-13.
 */

var async = require('async');

var gs = require('./global_setting');
var dbHelper = require('./db_helper');



//start judge server
module.exports.run = function(){
    //reset CJ solutions

    //set async queue
    var queue = async.queue(judgeClient, gs.judge_setting.concurrency);

    //Polling latest work in pending queue
    setInterval(function(queue){
        return function(){
            polling(queue);
        }
    }(queue),gs.judge_setting.poll_time);

    //for test
    //polling();
}

/**
 * Polling
 * */
function polling(queue){

    //queue.push();

    var querySQL = 'SELECT * FROM imuoj_solution WHERE run_state=?';
    var queryData = [gs.run_states.PD.id];
    dbHelper.getPool().query(querySQL, queryData, function(err, solution_rows, fields){
        if (err) throw err;
        for(var item in solution_rows){
            var updateSQL = 'UPDATE imuoj_solution SET run_state=? where solution_id=?';
            var updateData = [gs.run_states.CJ.id, solution_rows[item].solution_id];
            dbHelper.getPool().query(updateSQL,updateData,doEachSolution(item));
        }

        function doEachSolution(item){
            return function(err, rows, fields){
                if (err) throw err;
                queue.push(solution_rows[item].solution_id);
            }
        }
    });
}



/**
 * judgeClient
 * @param solutionID
 * */
function judgeClient(solutionID, callback){
    console.log(solutionID);
    callback();
}


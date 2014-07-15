/**
 * Created by friskit on 14-6-13.
 */
module.exports = {
    web_port:8888,
    dirs:{
        oj_dir:  '/home/friskit/judge_online',      // /home/friskit/judge_online
        log_dir: '/home/friskit/judge_online/log',  // /home/friskit/judge_online/log
        data_dir:'/home/friskit/judge_online/data', // /home/friskit/judge_online/data
        run_dir: '/home/friskit/judge_online/run'
    },
    database_conf:{
        'host':'localhost',
        'username':'root',
        'password':'root',
        'database':'judge_online'
    },
    judge_setting:{
        poll_time:1000,                 //Polling time for Judge Server. (ms)
        client_concurrency:2,           //Concurrency of Judge Client. Depend on CPUs
        quota_wall_clock:10*1000,       //max wall clock (ms)
        quota_disk_space:10*1024*1024   //max disk space (b)
    },
    program_language_type:[
        {
            name:'C',
            compile_str:'gcc Main.c -o Main -Wall -lm --static -std=c99',
            extension:'.c'
        },
        {
            name:'C++',
            compile_str:'g++ Main.cc -o Main -Wall -lm --static -std=c++0x',
            extension:'.cc'
        },
        {
            name:'Java',
            compile_str:'javac -J-Xms32m -J-Xms256m Main.java',
            extension:'.java'
        }
    ],
    show_language_type:[
        {name:'English',language_code:'en_us',native_name:'English'},
        {name:'Simplified Chinese',language_code:'zh_cn',native_name:'简体中文'},
        {name:'Traditional Chinese', language_code:'zh_tw', native_name:'繁体中文'}
    ],
    run_states:{
        'PD':{id:0, state_description:{en_us:'Pending'}},
        'OK':{id:1, state_description:{en_us:'Okay'}},
        'RF':{id:2, state_description:{en_us:'Restricted Function'}},
        'ML':{id:3, state_description:{en_us:'Memory Limit Exceed'}},
        'OL':{id:4, state_description:{en_us:'Output Limit Exceed'}},
        'TL':{id:5, state_description:{en_us:'Time Limit Exceed'}},
        'RT':{id:6, state_description:{en_us:'Run Time Error (SIGSEGV, SIGFPE, ...)'}},
        'AT':{id:7, state_description:{en_us:'Abnormal Termination'}},
        'IE':{id:8, state_description:{en_us:'Internal Error (of sandbox executor)'}},
        'BP':{id:9, state_description:{en_us:'Bad Policy'}},
        'R0':{id:10,state_description:{en_us:'Reserved result type 0'}},
        'R1':{id:11,state_description:{en_us:'Reserved result type 1'}},
        'R2':{id:12,state_description:{en_us:'Reserved result type 2'}},
        'R3':{id:13,state_description:{en_us:'Reserved result type 3'}},
        'R4':{id:14,state_description:{en_us:'Reserved result type 4'}},
        'R5':{id:15,state_description:{en_us:'Reserved result type 5'}},
        'CJ':{id:16,state_description:{en_us:'Compiling and Judging'}},
        'WA':{id:17,state_description:{en_us:'Wrong Answer'}},
        'AC':{id:18,state_description:{en_us:'Accept'}},
        'CE':{id:10,state_description:{en_us:'Compile Error'}}
        //S_RESULT_PD        =  0,    /*!< Pending */
        //S_RESULT_OK        =  1,    /*!< Okay */
        //S_RESULT_RF        =  2,    /*!< Restricted Function */
        //S_RESULT_ML        =  3,    /*!< Memory Limit Exceed */
        //S_RESULT_OL        =  4,    /*!< Output Limit Exceed */
        //S_RESULT_TL        =  5,    /*!< Time Limit Exceed */
        //S_RESULT_RT        =  6,    /*!< Run Time Error (SIGSEGV, SIGFPE, ...) */
        //S_RESULT_AT        =  7,    /*!< Abnormal Termination */
        //S_RESULT_IE        =  8,    /*!< Internal Error (of sandbox executor) */
        //S_RESULT_BP        =  9,    /*!< Bad Policy (since 0.3.3) */
        //S_RESULT_R0        = 10,    /*!< Reserved result type 0 (since 0.3.2) */
        //S_RESULT_R1        = 11,    /*!< Reserved result type 1 (since 0.3.2) */
        //S_RESULT_R2        = 12,    /*!< Reserved result type 2 (since 0.3.2) */
        //S_RESULT_R3        = 13,    /*!< Reserved result type 3 (since 0.3.2) */
        //S_RESULT_R4        = 14,    /*!< Reserved result type 4 (since 0.3.2) */
        //S_RESULT_R5        = 15,    /*!< Reserved result type 5 (since 0.3.2) */
    }
}

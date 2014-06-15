/**
 * Created by friskit on 14-6-13.
 */
module.exports = {
    web_port:8888,
    database_conf:{
        'host':'localhost',
        'username':'root',
        'password':'root',
        'database':'judge_online'
    },
    judge_setting:{
        poll_time:1000,         //Polling time for Judge Server. (ms)
        client_concurrency:2    //Concurrency of Judge Client. Depend on CPUs
    },
    program_language_type:{
        'C':    {id:0, name:'C'},
        'CPP':  {id:1, name:'C++'},
        'PY':   {id:2, name:'Python'}
    },
    show_language_type:[
        {name:'English',native_name:'English'},
        {name:'Chinese',native_name:'汉语'}
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
        'AC':{id:18,state_description:{en_us:'Accept'}}
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

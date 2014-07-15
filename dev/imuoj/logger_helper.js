/**
 * Created by friskit on 14-6-16.
 */
var log4js = require('log4js');

var gs = require('./global_setting');

//init log
log4js.configure({
    appenders: [
        { type: 'console' },
        {
            type: 'dateFile',
            filename: gs.dirs.log_dir+'/web.log',
            category: 'web',
            pattern: '_yyyy-MM-dd',
            alwaysIncludePattern: true,
            maxLogSize: 20480,
            backups: 3
        },
        {
            type: 'dateFile',
            filename: gs.dirs.log_dir+'/judge.log',
            category: 'judge',
            pattern: '_yyyy-MM-dd',
            alwaysIncludePattern: true,
            maxLogsize: 20480,
            backups: 3
        }
    ]
});

module.exports.log4js = log4js;
module.exports.logger = log4js.getLogger('oj');
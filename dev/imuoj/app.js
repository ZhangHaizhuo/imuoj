var express = require('express');
var path = require('path');
var favicon = require('static-favicon');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var async = require('async');

var routes = require('./routes/index');
var users = require('./routes/users');

//global setting
var gs = require('./global_setting');

//logger helper
var log4js = require('./logger_helper').log4js;
var web_logger = log4js.getLogger('web');

//judge server
var judgeServer = require('./judge_server');

//init web
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon());
//app.use(logger('dev'));
app.use(log4js.connectLogger(web_logger,{level:log4js.levels.INFO, format:':method :url'}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);

/// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});


module.exports = app;
app.listen(gs.web_port);
web_logger.info('Web server has started!');

//开启judgeServer
judgeServer.run();




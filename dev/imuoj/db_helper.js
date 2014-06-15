/**
 * Created by friskit on 14-6-15.
 */
var mysql = require('mysql');
var gs = require('./global_setting');

var pool = undefined;

module.exports.getPool  = function(){
    if (pool == undefined){
        pool = mysql.createPool({
            connectionLimit : 10,
            host     : gs.database_conf.host,
            user     : gs.database_conf.username,
            password : gs.database_conf.password,
            database : gs.database_conf.database
        });
    }
    return pool;
}

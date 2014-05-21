set names utf8;
create database judge_online;
use judge_online;

-- 问题表(problem)
DROP TABLE IF EXISTS `imuoj_problem`;
CREATE TABLE IF NOT EXISTS `imuoj_problem`(
    `problem_id` INTEGER(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '题目ID，主键',
    `title` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '题目名称',
    `description` TEXT NOT NULL COMMENT '题目描述',
    `category_id` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '分类ID，外键到category',
    `difficulty` CHAR(1) NOT NULL DEFAULT '' COMMENT '难度评级',
    `input_desc` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输入描述',
    `output_desc` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输出描述',
    `input_sample` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输入样例',
    `output_sample` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输出样例',
    `hint` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '提示',
    `problem_source` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '题目来源',
    `ac_source` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT 'AC推荐代码ID，外键到solution',
    `add_user` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '添加者ID，外键到user',
    `_add_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '添加时间，Unix时间戳',
    `_is_private` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '私有标记',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`problem_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

-- 用户表(user)
DROP TABLE IF EXISTS `imuoj_user`;
CREATE TABLE IF NOT EXISTS `imuoj_user`(
    `user_id` INTEGER(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `nick_name` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '用户昵称',
    `student_number` VARCHAR(15) NOT NULL DEFAULT '' COMMENT '学号（实名认证用）',
    `real_name` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户真实姓名（实名认证用）',
    `class_id` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '所属班级ID，外键到class',
    `password` CHAR(40) NOT NULL DEFAULT '' COMMENT '密码（加密存储）',
    `email` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '电子邮箱（作为登陆用户名）',
    `group_id` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '所属用户组',
    `submit_count` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '提交问题数量',
    `solved_count` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '解决问题数量',
    `reg_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '注册日期（Unix时间戳）',
    `login_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '上次登陆日期（Unix时间戳）',
    `login_ip` CHAR(20) NOT NULL DEFAULT '' COMMENT '上次登陆IP',
    `show_language` CHAR(5) NOT NULL DEFAULT 'zh-CN' COMMENT '界面显示语言',
    `pm_count` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '接收站内信',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

-- 解决方案表(solution)
DROP TABLE IF EXISTS `imuoj_solution`;
CREATE TABLE IF NOT EXISTS `imuoj_solution`(
    `solution_id` INTEGER(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '解决方案ID',
    `problem_id` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '问题ID，外键到problem',
    `user_id` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '提交用户ID，外键到user',
    `contest_id` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '比赛ID，外键到contest',
    `submit_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '提交时间，unix时间戳',
    `submit_ip` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '提交IP',
    `submit_language` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '代码语言，硬编码到配置文件',
    `submit_code_length` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '提交代码的长度（以字节计）',
    `run_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '代码运行时间（以毫秒计）',
    `run_state` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '代码运行状态，硬编码到配置文件',
    `extra_info` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '编译过程中的额外信息（警告、错误等）',
    PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

-- 源代码表（source）
DROP TABLE IF EXISTS `imuoj_source`;
CREATE TABLE IF NOT EXISTS `imu_source`(
    `solution_id` INTEGER(10) unsigned NOT NULL COMMENT '对应解决方案的ID',
    `source` MEDIUMTEXT NOT NULL COMMENT '源代码内容',
    PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 竞赛表(contest)
DROP TABLE IF EXISTS `imuoj_contest`;
CREATE TABLE IF NOT EXISTS `imuoj_contest`(
    `contest_id` INTEGER(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '竞赛ID',
    `contest_name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '竞赛名称',
    `problems` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '问题（json）',
    `password` VARCHAR(40) NOT NULL DEFAULT '' COMMENT '竞赛密码',
    `contestant` TEXT NOT NULL COMMENT '参赛选手（user_id,json）',
    `start_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '开始时间（Unix时间戳）',
    `end_time` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '结束时间（Unix时间戳）',
    `description` TEXT NOT NULL COMMENT '竞赛描述',
    `ac_count` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT 'AC数量',
    `submit_count` INTEGER(10) unsigned NOT NULL DEFAULT 0 COMMENT '提交数量',
    `_is_del` ENUM('Y','N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    `_is_disable` ENUM('Y','N') NOT NULL DEFAULT 'Y' COMMENT '显示标记',
    `_is_private` ENUM('Y','N') NOT NULL DEFAULT 'Y' COMMENT '公开标记（即便私有，外界也可见到名字，参赛者为竞赛JSON）',
    PRIMARY KEY (`contest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;



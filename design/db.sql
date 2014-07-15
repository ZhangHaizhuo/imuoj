set names utf8;
DROP DATABASE IF EXISTS `judge_online`;
CREATE DATABASE IF NOT EXISTS judge_online;
use judge_online;

-- 问题表(problem)
DROP TABLE IF EXISTS `imuoj_problem`;
CREATE TABLE IF NOT EXISTS `imuoj_problem`(
    `problem_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '题目ID，主键',
    `title` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '题目名称',
    `description` TEXT NOT NULL COMMENT '题目描述',
    `category_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类ID，外键到category',
    `difficulty` CHAR(1) NOT NULL DEFAULT '' COMMENT '难度评级',
    `input_desc` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输入描述',
    `output_desc` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输出描述',
    `input_sample` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输入样例',
    `output_sample` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '输出样例',
    `quota_time` INTEGER(10) NOT NULL DEFAULT 10000 COMMENT '时间配额',
    `quota_memory` INTEGER(10) NOT NULL DEFAULT 33554432 COMMENT '内存配额',
    `hint` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '提示',
    `problem_source` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '题目来源',
    `ac_source` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'AC推荐代码ID，外键到solution',
    `add_user` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加者ID，外键到user',
    `_add_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间，Unix时间戳',
    `_is_private` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '私有标记',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`problem_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

-- 问题分类表(prob_category)
DROP TABLE IF EXISTS `imuoj_prob_category`;
CREATE TABLE IF NOT EXISTS `imuoj_prob_category`(
    `category_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    `category_name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '分类名称',
    `_is_del` ENUM('Y','N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

-- 用户表(user)
DROP TABLE IF EXISTS `imuoj_user`;
CREATE TABLE IF NOT EXISTS `imuoj_user`(
    `user_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `nick_name` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '用户昵称',
    `student_number` VARCHAR(15) NOT NULL DEFAULT '' COMMENT '学号（实名认证用）',
    `real_name` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '用户真实姓名（实名认证用）',
    `class_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属班级ID，外键到class',
    `password` CHAR(40) NOT NULL DEFAULT '' COMMENT '密码（加密存储）',
    `email` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '电子邮箱（作为登陆用户名）',
    `group_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属用户组',
    `submit_count` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提交问题数量',
    `solved_count` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '解决问题数量',
    `reg_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '注册日期（Unix时间戳）',
    `login_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上次登陆日期（Unix时间戳）',
    `login_ip` CHAR(20) NOT NULL DEFAULT '' COMMENT '上次登陆IP',
    `show_language` CHAR(5) NOT NULL DEFAULT 'zh-CN' COMMENT '界面显示语言',
    `pm_count` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收站内信',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

-- 用户组表(user_group)
DROP TABLE IF EXISTS `imuoj_user_group`;
CREATE TABLE IF NOT EXISTS `imuoj_user_group`(
    `group_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '组ID',
    `group_name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '组名称',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

-- 日志表(log)
DROP TABLE IF EXISTS `imuoj_log`;
CREATE TABLE IF NOT EXISTS `imuoj_log`(
    `log_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
    `time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '时间',
    `user_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID，外键到user',
    `action` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '日志操作',
    `extra_info` TEXT NOT NULL COMMENT '附加信息',
    PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

-- 解决方案表(solution)
DROP TABLE IF EXISTS `imuoj_solution`;
CREATE TABLE IF NOT EXISTS `imuoj_solution`(
    `solution_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '解决方案ID',
    `problem_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '问题ID，外键到problem',
    `user_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提交用户ID，外键到user',
    `contest_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '比赛ID，外键到contest',
    `submit_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提交时间，unix时间戳',
    `submit_ip` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '提交IP',
    `submit_language` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '代码语言，硬编码到配置文件',
    `submit_code_length` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提交代码的长度（以字节计）',
    `run_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '代码运行时间（以毫秒计）',
    `run_state` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '代码运行状态，硬编码到配置文件',
    `extra_info` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '编译过程中的额外信息（警告、错误等）',
    PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

-- 源代码表（source）
DROP TABLE IF EXISTS `imuoj_source`;
CREATE TABLE IF NOT EXISTS `imuoj_source`(
    `solution_id` INTEGER(10) UNSIGNED NOT NULL COMMENT '对应解决方案的ID',
    `source` MEDIUMTEXT NOT NULL COMMENT '源代码内容',
    PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 竞赛表(contest)
DROP TABLE IF EXISTS `imuoj_contest`;
CREATE TABLE IF NOT EXISTS `imuoj_contest`(
    `contest_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '竞赛ID',
    `contest_name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '竞赛名称',
    `problems` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '问题（json）',
    `password` VARCHAR(40) NOT NULL DEFAULT '' COMMENT '竞赛密码',
    `contestant` TEXT NOT NULL COMMENT '参赛选手（user_id,json）',
    `start_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '开始时间（Unix时间戳）',
    `end_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '结束时间（Unix时间戳）',
    `description` TEXT NOT NULL COMMENT '竞赛描述',
    `ac_count` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'AC数量',
    `submit_count` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提交数量',
    `_is_del` ENUM('Y','N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    `_is_disable` ENUM('Y','N') NOT NULL DEFAULT 'Y' COMMENT '显示标记',
    `_is_private` ENUM('Y','N') NOT NULL DEFAULT 'Y' COMMENT '公开标记（即便私有，外界也可见到名字，参赛者为竞赛JSON）',
    PRIMARY KEY (`contest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;
 
/*
-- 话题表(topic)   (暂时不管了。。。)
DROP TABLE IF EXISTS `imuoj_topic`;
CREATE TABLE IF NOT EXISTS `imuoj_topic`(
    `topic_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '话题ID',
    `problem_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '话题所属题目ID',
    `user_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '话题发起人ID',
    `content` TEXT NOT NULL COMMENT '话题内容',
    `_add_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '话题发起时间',
    `_is_del` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标记',
    PRIMARY KEY (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;
*/

-- 新闻表(news)
DROP TABLE IF EXISTS `imuoj_news`;
CREATE TABLE IF NOT EXISTS `imuoj_news`(
    `news_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '新闻ID',
    `news_title` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '新闻标题',
    `news_content` TEXT NOT NULL COMMENT '新闻内容',
    `user_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加用户ID',
    `_add_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    `_is_private` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '私有标记',
    PRIMARY KEY (`news_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;

/*
-- 站内信表(pm)
DROP TABLE IF EXISTS `imuoj_pm`;
CREATE TABLE IF NOT EXISTS `imuoj_pm`(
    `pm_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '站内信ID',
    `time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '时间',
    `sender_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发送者ID',
    `receiver_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收者ID',
    `_is_sender_del` ENUM('Y', 'N') DEFAULT 'N' COMMENT '发送者是否删除',
    `_is_receiver_del` ENUM('Y', 'N') DEFAULT 'N' COMMENT '接收者是否删除',
    `_is_sender_read` ENUM('Y', 'N') DEFAULT 'Y' COMMENT '发送者是否已读',
    `_is_receiver_read` ENUM('Y', 'N') DEFAULT 'N' COMMENT '接收者是否已读',
    PRIMARY KEY (`pm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000;
*/

-- 班级表(class)
DROP TABLE IF EXISTS `imuoj_class`;
CREATE TABLE IF NOT EXISTS `imuoj_class`(
    `class_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '班级ID',
    `class_name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '班级名称',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
    PRIMARY KEY (`class_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

-- 图片表(pic)
DROP TABLE IF EXISTS `imuoj_pic`;
CREATE TABLE IF NOT EXISTS `imuoj_pic`(
    `pic_id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '图片ID',
    `pic_desc` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '图片说明',
    `_add_time` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
    `_is_del` ENUM('Y', 'N') NOT NULL DEFAULT 'N' COMMENT '删除标记',
    PRIMARY KEY (`pic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1000; 



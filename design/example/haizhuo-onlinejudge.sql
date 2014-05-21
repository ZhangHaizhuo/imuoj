-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 04 月 24 日 04:43
-- 服务器版本: 5.5.8
-- PHP 版本: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `onlinejudge`
--

-- --------------------------------------------------------

--
-- 表的结构 `common_members`
--

CREATE TABLE IF NOT EXISTS `common_members` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID，唯一标识',
  `email` varchar(40) NOT NULL COMMENT '用户Email',
  `password` char(32) NOT NULL COMMENT '用户登录密码',
  `emailstatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Email验证状态',
  `regtime` datetime NOT NULL COMMENT '用户注册时间',
  `regip` varchar(23) NOT NULL COMMENT '用户注册IP地址',
  `lastloginip` varchar(23) NOT NULL COMMENT '最后登录IP',
  `lastlogintime` datetime NOT NULL COMMENT '最后登录时间',
  `salt` char(6) NOT NULL COMMENT '密码验证字符串',
  `nickname` varchar(255) NOT NULL COMMENT '昵称',
  `avater` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT '提交次数',
  `accepted` int(11) NOT NULL DEFAULT '0' COMMENT 'AC题目',
  `token` varchar(32) DEFAULT NULL COMMENT 'token标识。',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- 转存表中的数据 `common_members`
--

INSERT INTO `common_members` (`uid`, `email`, `password`, `emailstatus`, `regtime`, `regip`, `lastloginip`, `lastlogintime`, `salt`, `nickname`, `avater`, `submitted`, `accepted`, `token`) VALUES
(23, 'zhz.china@qq.com', '370444d3e7665c33f854c8228b8e22dd', 1, '2013-06-17 00:02:17', '127.0.0.1', '127.0.0.1', '2013-06-17 00:02:17', '24B6HL', 'Hello World!', 'Data/Avatar/avatar_23_s.png', 6, 0, ''),
(24, 'zhz@qq.com', 'cf224c4378ddbd9ca1ca153bfb0bbac5', 0, '2013-06-19 10:15:57', '127.0.0.1', '127.0.0.1', '2013-06-19 10:15:57', '6282N4', '123456', 'Data/Avatar/noavatar_small.gif', 0, 0, '04ecac6d2f09b4d0611448fee9451a64'),
(30, '381340862@qq.com', '2fe98ce42fe7d39126aafe05966326f2', 1, '2013-06-29 09:10:44', '127.0.0.1', '127.0.0.1', '2013-06-29 09:10:44', '06484T', '你好1', 'Data/Avatar/avatar_30_s.png', 1, 0, ''),
(29, '374437808@qq.com', '9160ceeeaa9d5723eceb727aa8823b28', 1, '2013-06-29 07:36:18', '127.0.0.1', '127.0.0.1', '2013-06-29 07:36:18', '662TF0', '测试', 'Data/Avatar/noavatar_small.gif', 0, 0, ''),
(31, 'haizhuo@126.com', 'e764bf26fbb472ffd98658c0742e2166', 0, '2013-08-09 17:53:30', '127.0.0.1', '127.0.0.1', '2013-08-09 17:53:30', 'NV6ZBN', '嗖嗖嗖', 'Data/Avatar/noavatar_small.gif', 0, 0, 'ebfe3b3efa0cf7cc738ad65532ceafbe');

-- --------------------------------------------------------

--
-- 表的结构 `common_members_action`
--

CREATE TABLE IF NOT EXISTS `common_members_action` (
  `actionid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动增长',
  `actionname` varchar(64) NOT NULL COMMENT '动作名称',
  `actioncolumnid` int(11) NOT NULL COMMENT '动作分栏号（映射到actioncolmun表）',
  `action` varchar(64) NOT NULL COMMENT '动作字符串',
  `viewmode` tinyint(4) NOT NULL COMMENT '是否显示',
  PRIMARY KEY (`actionid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `common_members_action`
--


-- --------------------------------------------------------

--
-- 表的结构 `common_members_actioncolumn`
--

CREATE TABLE IF NOT EXISTS `common_members_actioncolumn` (
  `actioncolumnid` int(11) NOT NULL AUTO_INCREMENT COMMENT '动作分栏自增id',
  `actioncolumnname` varchar(64) NOT NULL COMMENT '动作分栏名称',
  PRIMARY KEY (`actioncolumnid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `common_members_actioncolumn`
--

INSERT INTO `common_members_actioncolumn` (`actioncolumnid`, `actioncolumnname`) VALUES
(1, '问题管理'),
(2, '比赛管理');

-- --------------------------------------------------------

--
-- 表的结构 `common_members_groupaction`
--

CREATE TABLE IF NOT EXISTS `common_members_groupaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `action` varchar(64) NOT NULL COMMENT '动作名称（映射到Role表）',
  `groupid` int(11) NOT NULL COMMENT '管理组ID（映射到managegroups）',
  `createuid` int(11) NOT NULL COMMENT '创建用户ID',
  `createdate` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理组和权限映射表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `common_members_groupaction`
--


-- --------------------------------------------------------

--
-- 表的结构 `common_members_groups`
--

CREATE TABLE IF NOT EXISTS `common_members_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) NOT NULL COMMENT '用户id（映射到members表）',
  `groupid` int(11) NOT NULL COMMENT '管理组ID（映射到managegroup表）',
  `createuid` int(11) NOT NULL COMMENT '创建者ID',
  `createdate` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='权限组和用户之间的映射表' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `common_members_groups`
--

INSERT INTO `common_members_groups` (`id`, `uid`, `groupid`, `createuid`, `createdate`) VALUES
(1, 23, 1, 23, '0000-00-00');

-- --------------------------------------------------------

--
-- 表的结构 `common_members_info`
--

CREATE TABLE IF NOT EXISTS `common_members_info` (
  `uid` mediumint(8) unsigned NOT NULL COMMENT '用户ID，唯一标识',
  `realname` varchar(255) NOT NULL COMMENT '用户真实姓名',
  `gender` varchar(4) DEFAULT NULL COMMENT '性别',
  `birthyear` smallint(6) unsigned DEFAULT NULL COMMENT '出生年份',
  `birthmonth` tinyint(3) unsigned DEFAULT NULL COMMENT '出生月份',
  `birthday` tinyint(3) unsigned DEFAULT NULL COMMENT '生日',
  `constellation` varchar(255) DEFAULT NULL COMMENT '星座(根据生日自动计算)',
  `zodiac` varchar(255) DEFAULT NULL COMMENT '生肖(根据生日自动计算)',
  `telephone` char(12) DEFAULT NULL COMMENT '固定电话',
  `mobile` char(11) DEFAULT NULL COMMENT '手机',
  `address` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `nationality` varchar(255) DEFAULT NULL COMMENT '国籍',
  `birthprovince` varchar(255) DEFAULT NULL COMMENT '出生省份',
  `birthcity` varchar(255) DEFAULT NULL COMMENT '出生地',
  `birthdist` varchar(255) DEFAULT NULL COMMENT '出生县',
  `birthcommunity` varchar(255) DEFAULT NULL COMMENT '出生小区',
  `resideprovince` varchar(255) DEFAULT NULL COMMENT '居住省份',
  `residecity` varchar(255) DEFAULT NULL COMMENT '居住地',
  `residedist` varchar(255) DEFAULT NULL COMMENT '居住县',
  `residecommunity` varchar(255) DEFAULT NULL COMMENT '居住小区',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `common_members_info`
--


-- --------------------------------------------------------

--
-- 表的结构 `common_members_managegroups`
--

CREATE TABLE IF NOT EXISTS `common_members_managegroups` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `groupname` varchar(64) NOT NULL COMMENT '管理组名称',
  `groupinfo` varchar(255) NOT NULL COMMENT '管理组描述',
  `createid` int(11) NOT NULL COMMENT '创建者ID',
  `createdate` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`groupid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `common_members_managegroups`
--

INSERT INTO `common_members_managegroups` (`groupid`, `groupname`, `groupinfo`, `createid`, `createdate`) VALUES
(1, '超级管理员', '超级管理员', 23, '0000-00-00');

-- --------------------------------------------------------

--
-- 表的结构 `oj_contests`
--

CREATE TABLE IF NOT EXISTS `oj_contests` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识id,自增',
  `name` varchar(64) NOT NULL COMMENT '竞赛名称',
  `starttime` datetime NOT NULL COMMENT '开始时间',
  `endtime` datetime NOT NULL COMMENT '结束时间',
  `compiler` varchar(64) NOT NULL COMMENT '编译环境',
  `type` tinyint(2) NOT NULL COMMENT '类型：0：public 1：private 2：属于小组',
  `password` varchar(64) DEFAULT NULL COMMENT 'private密码',
  `uid` int(11) NOT NULL COMMENT '创建人uid',
  `groupid` int(11) DEFAULT NULL COMMENT '隶属于某个组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='竞赛表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `oj_contests`
--

INSERT INTO `oj_contests` (`id`, `name`, `starttime`, `endtime`, `compiler`, `type`, `password`, `uid`, `groupid`) VALUES
(1, '寂寞的比赛', '2013-06-27 00:00:00', '2013-06-28 00:00:00', 'c++,c', 1, '123456', 23, NULL),
(2, '比赛的寂寞', '2013-06-28 00:00:00', '2013-06-29 00:00:00', 'c,c++', 0, NULL, 23, NULL),
(3, '比寂寞还寂寞', '2013-06-27 00:00:00', '2013-06-28 00:00:00', 'c,c++', 1, '12346', 23, NULL),
(4, '这厮个测试', '2013-06-28 00:00:00', '2013-06-28 00:00:00', 'c,c++', 0, '', 23, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `oj_contests_problem`
--

CREATE TABLE IF NOT EXISTS `oj_contests_problem` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '题目自增',
  `pid` int(11) NOT NULL COMMENT '题目id',
  `contestpid` int(11) NOT NULL COMMENT '竞赛中的id：如1001',
  `accepted` int(11) NOT NULL DEFAULT '0' COMMENT 'AC次数',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT '提交次数',
  `contestid` int(11) NOT NULL COMMENT '比赛ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='竞赛和题目的映射表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `oj_contests_problem`
--

INSERT INTO `oj_contests_problem` (`id`, `pid`, `contestpid`, `accepted`, `submitted`, `contestid`) VALUES
(1, 1000, 1001, 0, 0, 2),
(2, 1000, 1002, 0, 0, 2),
(3, 1003, 1000, 0, 0, 2),
(4, 1000, 1001, 0, 0, 4),
(5, 1001, 1002, 0, 0, 4);

-- --------------------------------------------------------

--
-- 表的结构 `oj_problem`
--

CREATE TABLE IF NOT EXISTS `oj_problem` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '问题编号',
  `title` varchar(64) NOT NULL COMMENT '标题',
  `time_limit` int(11) unsigned NOT NULL COMMENT '时间限制',
  `memory_limit` int(11) unsigned NOT NULL COMMENT '内存限制',
  `source` varchar(64) DEFAULT NULL COMMENT '题目来源',
  `description` text COMMENT '描述',
  `input` text COMMENT '问题输入',
  `output` text COMMENT '问题输出',
  `sample_input` text COMMENT '样例输入',
  `sample_output` text COMMENT '样例输出',
  `hint` text COMMENT '提示',
  `time` datetime NOT NULL COMMENT '上传时间',
  `accepted` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通过数量',
  `submitted` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '提交数量',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '题目状态：0：不显示1：显示',
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1003 ;

--
-- 转存表中的数据 `oj_problem`
--

INSERT INTO `oj_problem` (`pid`, `title`, `time_limit`, `memory_limit`, `source`, `description`, `input`, `output`, `sample_input`, `sample_output`, `hint`, `time`, `accepted`, `submitted`, `status`) VALUES
(1000, 'A + B Problem', 1000, 1000, '', 'Calculate A + B.', 'Each line will contain two integers A and B. Process to end of file.\r\n', 'For each case, output A + B in one line.', '1 1', '2', '', '2013-06-08 00:09:53', 1, 8, 1),
(1001, 'A + B Problem II', 2000, 65536, 'Ignatius.L', 'I have a very simple problem for you. Given two integers A and B, your job is to calculate the Sum of A + B.', 'The first line of the input contains an integer T(1<=T<=20) which means the number of test cases. Then T lines follow, each line consists of two positive integers, A and B. Notice that the integers are very large, that means you should not process them by using 32-bit integer. You may assume the length of each integer will not exceed 1000.', 'For each test case, you should output two lines. The first line is "Case #:", # means the number of the test case. The second line is the an equation "A + B = Sum", Sum means the result of A + B. Note there are some spaces int the equation. Output a blank line between two test cases.', '2\r\n1 2\r\n112233445566778899 998877665544332211', 'Case 1:\r\n1 + 2 = 3\r\n\r\nCase 2:\r\n112233445566778899 + 998877665544332211 = 1111111111111111110', '', '2013-06-28 17:07:49', 0, 1, 1),
(1002, 'A + B Problem 2', 1000, 1000, 'IMUOJ2', 'ViewBag.description', 'Each line will contain two integers A and B. Process to end of file.', 'For each case, output A + B in one line.', '1 1', '2', '', '2013-06-28 18:28:55', 0, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `oj_run`
--

CREATE TABLE IF NOT EXISTS `oj_run` (
  `run_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '运行id',
  `submit_time` datetime NOT NULL COMMENT '提交时间',
  `uid` int(10) unsigned NOT NULL COMMENT '提交用户id',
  `problem_id` int(10) unsigned NOT NULL COMMENT '问题ID',
  `status` varchar(255) NOT NULL DEFAULT '1' COMMENT 'judge状态',
  `run_time` int(11) DEFAULT NULL COMMENT '运行时间',
  `run_memory` int(11) DEFAULT NULL COMMENT '运行内存',
  `code_length` int(11) DEFAULT NULL COMMENT '代码长度',
  `language` varchar(12) DEFAULT NULL COMMENT '代码语言',
  `source_code` text NOT NULL COMMENT '源码',
  `status_description` text COMMENT '状态描述，错误信息内容',
  PRIMARY KEY (`run_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- 转存表中的数据 `oj_run`
--

INSERT INTO `oj_run` (`run_id`, `submit_time`, `uid`, `problem_id`, `status`, `run_time`, `run_memory`, `code_length`, `language`, `source_code`, `status_description`) VALUES
(23, '2013-06-21 14:16:55', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'sssssssss', NULL),
(22, '2013-06-21 14:11:53', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'ssssss', NULL),
(21, '2013-06-19 11:56:43', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', '#include "stdio.h"\r\nint main()\r\n{\r\n    printf("Hello World!");\r\n}', NULL),
(20, '2013-06-19 11:41:01', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', '#include "stdio.h"\r\nint main()\r\n{\r\n    printf("Hello World!");\r\n}', NULL),
(19, '2013-06-19 00:38:38', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'dfsdfsdfs', NULL),
(18, '2013-06-19 00:33:09', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'sssssssssss', NULL),
(17, '2013-06-19 00:30:46', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'iiiiii', NULL),
(15, '2013-06-17 08:06:56', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'include "stdio.h"\r\nint main(){\r\n    printf("Hello world!");\r\n}', NULL),
(16, '2013-06-19 00:27:36', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'include "stdio.h"\r\nint main(){\r\n    printf("hello world!");\r\n}', NULL),
(14, '2013-06-17 00:21:53', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'include "stdio.h"\r\nint main(){\r\n    printf("Hello World!");\r\n}', NULL),
(24, '2013-06-21 14:22:55', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'index', NULL),
(25, '2013-06-21 14:24:05', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'index.php', NULL),
(26, '2013-06-27 10:54:26', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'sss', NULL),
(27, '2013-06-27 16:10:31', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'qqqq', NULL),
(28, '2013-06-27 16:10:55', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', '222', NULL),
(29, '2013-06-29 08:07:39', 23, 1001, 'Queuing', NULL, NULL, NULL, 'c++', 'ssss', NULL),
(30, '2013-06-29 09:14:15', 30, 1000, 'Queuing', NULL, NULL, NULL, 'c++', '#include "stdio.h"\r\nint main()\r\n{\r\n    printf("Hello World!");\r\n}', NULL),
(31, '2013-07-11 18:12:03', 23, 1000, 'Queuing', NULL, NULL, NULL, 'c++', 'ssss', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `oj_run_contests`
--

CREATE TABLE IF NOT EXISTS `oj_run_contests` (
  `run_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '运行id',
  `submit_time` datetime NOT NULL COMMENT '提交时间',
  `uid` int(10) unsigned NOT NULL COMMENT '提交用户id',
  `status` varchar(255) NOT NULL DEFAULT '1' COMMENT 'judge状态',
  `run_time` int(11) DEFAULT NULL COMMENT '运行时间',
  `run_memory` int(11) DEFAULT NULL COMMENT '运行内存',
  `code_length` int(11) DEFAULT NULL COMMENT '代码长度',
  `language` varchar(12) DEFAULT NULL COMMENT '代码语言',
  `source_code` text NOT NULL COMMENT '源码',
  `status_description` text COMMENT '状态描述，错误信息内容',
  `contest_id` int(11) NOT NULL COMMENT '比赛ID',
  `problem_id` int(11) NOT NULL COMMENT '问题ID',
  PRIMARY KEY (`run_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `oj_run_contests`
--

INSERT INTO `oj_run_contests` (`run_id`, `submit_time`, `uid`, `status`, `run_time`, `run_memory`, `code_length`, `language`, `source_code`, `status_description`, `contest_id`, `problem_id`) VALUES
(1, '2013-06-27 16:15:14', 23, 'Queuing', NULL, NULL, NULL, 'c++', 'ssss', NULL, 2, 1000),
(2, '2013-06-27 17:20:54', 23, 'Queuing', NULL, NULL, NULL, 'c++', 'sssss', NULL, 2, 1000),
(3, '2013-06-27 17:22:12', 23, 'Queuing', NULL, NULL, NULL, 'c++', 'asda', NULL, 2, 1000),
(4, '2013-06-29 08:08:26', 23, 'Queuing', NULL, NULL, NULL, 'c++', 'sssss', NULL, 2, 1000),
(5, '2013-07-11 18:15:09', 23, 'Queuing', NULL, NULL, NULL, 'c++', 'ssss', NULL, 4, 1000);

-- --------------------------------------------------------

--
-- 表的结构 `oj_run_contests_queue`
--

CREATE TABLE IF NOT EXISTS `oj_run_contests_queue` (
  `run_id` int(11) NOT NULL COMMENT '运行ID',
  `problem_id` int(11) NOT NULL COMMENT '问题ID',
  `source` text NOT NULL COMMENT '提交源码',
  `language` varchar(12) NOT NULL,
  PRIMARY KEY (`run_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `oj_run_contests_queue`
--

INSERT INTO `oj_run_contests_queue` (`run_id`, `problem_id`, `source`, `language`) VALUES
(1, 1000, 'ssss', 'c++'),
(2, 1000, 'sssss', 'c++'),
(3, 1000, 'asda', 'c++'),
(4, 1000, 'sssss', 'c++'),
(5, 1000, 'ssss', 'c++');

-- --------------------------------------------------------

--
-- 表的结构 `oj_run_queue`
--

CREATE TABLE IF NOT EXISTS `oj_run_queue` (
  `run_id` int(11) NOT NULL COMMENT '运行ID',
  `problem_id` int(11) NOT NULL COMMENT '问题ID',
  `source` text NOT NULL COMMENT '提交源码',
  `language` varchar(12) NOT NULL,
  PRIMARY KEY (`run_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `oj_run_queue`
--

INSERT INTO `oj_run_queue` (`run_id`, `problem_id`, `source`, `language`) VALUES
(18, 1000, 'sssssssssss', 'c++'),
(17, 1000, 'iiiiii', 'c++'),
(16, 1000, 'include "stdio.h"\r\nint main(){\r\n    printf("hello world!");\r\n}', 'c++'),
(15, 1000, 'include "stdio.h"\r\nint main(){\r\n    printf("Hello world!");\r\n}', 'c++'),
(14, 1000, 'include "stdio.h"\r\nint main(){\r\n    printf("Hello World!");\r\n}', 'c++'),
(19, 1000, 'dfsdfsdfs', 'c++'),
(20, 1000, '#include "stdio.h"\r\nint main()\r\n{\r\n    printf("Hello World!");\r\n}', 'c++'),
(21, 1000, '#include "stdio.h"\r\nint main()\r\n{\r\n    printf("Hello World!");\r\n}', 'c++'),
(22, 1000, 'ssssss', 'c++'),
(23, 1000, 'sssssssss', 'c++'),
(24, 1000, 'index', 'c++'),
(25, 1000, 'index.php', 'c++'),
(26, 1000, 'sss', 'c++'),
(27, 1000, 'qqqq', 'c++'),
(28, 1000, '222', 'c++'),
(29, 1001, 'ssss', 'c++'),
(30, 1000, '#include "stdio.h"\r\nint main()\r\n{\r\n    printf("Hello World!");\r\n}', 'c++'),
(31, 1000, 'ssss', 'c++');

-- --------------------------------------------------------

--
-- 表的结构 `oj_run_status`
--

CREATE TABLE IF NOT EXISTS `oj_run_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '状态id',
  `name` varchar(255) NOT NULL COMMENT '状态名称',
  `description` varchar(255) NOT NULL COMMENT '状态描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `oj_run_status`
--

INSERT INTO `oj_run_status` (`id`, `name`, `description`) VALUES
(1, 'Queuing', '提交太多了，OJ无法在第一时间给所有提交以评判结果，后面提交的程序将暂时处于排队状态等待OJ的评判。不过这个过程一般不会很长。'),
(2, 'Compiling', '您提交的代码正在被编译。'),
(3, 'Running', '您的程序正在OJ上运行。'),
(4, 'Judging', 'OJ正在检查您程序的输出是否正确。'),
(5, 'Accepted(AC)', '您的程序是正确的，恭喜！'),
(6, 'Presentation Error (PE)', '虽然您的程序貌似输出了正确的结果，但是这个结果的格式有点问题。请检查程序的输出是否多了或者少了空格（'' ''）、制表符（''\\t''）或者换行符（''\\n''）。'),
(7, 'Wrong Answer(WA)', ' 输出结果错，这个一般认为是算法有问题。'),
(8, 'Runtime Error (RE)', '运行时错误，这个一般是程序在运行期间执行了非法的操作造成的'),
(9, 'Time Limit Exceeded (TLE)', '您的程序运行的时间已经超出了这个题目的时间限制。'),
(10, 'Memory Limit Exceeded (MLE)', '您的程序运行的内存已经超出了这个题目的内存限制。'),
(11, 'Output Limit Exceeded (OLE)', '您的程序输出内容太多，超过了这个题目的输出限制。'),
(12, 'Compilation Error (CE)', '您的程序语法有问题，编译器无法编译。具体的出错信息可以点击链接察看'),
(13, 'System Error (SE) ', 'OJ内部出现错误。由于我们的OJ可能存在一些小问题，所以出现这个信息请原谅，同时请及时与管理员联系'),
(14, 'Out Of Contest Time ', '超出比赛时间，这个信息只有在比赛的时候才会出现。');

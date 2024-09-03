/*
 Navicat Premium Data Transfer

 Source Server         : dsh
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 8.153.16.66:3306
 Source Schema         : dsh

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 02/09/2024 09:38:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `phoneNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `slat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐值',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `classification_id` int NULL DEFAULT NULL COMMENT '分类',
  `publisher_id` int NOT NULL,
  `translator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '译者  、数组',
  `writer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者、数组',
  `price` double(255, 2) NULL DEFAULT NULL,
  `page_number` int NULL DEFAULT NULL,
  `book_style` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `publish_date` timestamp(0) NULL DEFAULT NULL,
  `author_introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '作者简介',
  `book_introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图书简介',
  `forum_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '论坛链接',
  `book_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (4, '一个人的旅行', '9787108044075', 9, 4, '李丽', '李丽', 23.00, 44, '平装', '2024-08-01 08:00:00', '从小爱看爱画漫画。曾想过当漫画家却没有认真实践。大学选读艺术，毕业后负笈英国修读多媒体设计，当过小学教师、大学导师以及设计师，却发现对漫画仍念念不忘，最终重拾曾经放弃的漫画事业，关心时事政治，强迫自己相信漫画终有一天能改变世界。', '如果在漫长的人生旅程中，有一段假期，你会做什么？\n在本书中主人公“明天不用上班”的梦想，某天竟然实现了！被公司裁掉的阿拔，成为失业大军的一员，他深感这是公司的损失，决定放一个长假到他方旅行，却又不慎跌断了脚狼狈回港，暂时不想另谋高就，阿拔决心休息之余，做尽一切无聊的事－－在网上组织不“不工作小组”、拿着相机四处拍、随心规划自己心目中的城市、以陌生人打不打招呼去决定自己散步的方向……这些小练习虽看似无意义，却令他对生活产生了新的观点、感想和反思……\n天天上班的你，或者会有兴趣知道，阿拔在他的悠长假期里，究竟发现了什么。', 'http://www.flobby.top/dsh-client-uniapp/#/pages/forum/forum?id=11', 'http://8.153.16.66:9000/dsh/9cca820e61ae40a688f6ee73e25eca13.jpg', 0, '2024-08-15 19:43:58', '2024-08-15 19:45:37');
INSERT INTO `book` VALUES (5, '中国青花瓷纹饰图典', '9787564106249', 8, 3, '江苏省古陶瓷研究会', '江苏省古陶瓷研究会', 75.00, 274, '平装', '2024-03-13 08:00:00', '江苏省古陶瓷研究会', '中国文化遗产蕴藏着中华民族独有的精神价值与思维方式，体现着中华民族的生命力和创造力，是华夏各民族智慧的结晶，也是全人类文明的瑰宝。保护文化遗产是连结民族情感的纽带，是增强民族团结和维护国家统一、社会和谐的重要文化基础。作为传承中华文化重要载体的瓷器乃是一项多姿多彩的文化遗产。人们常说，瓷器是中国人的名片。大凡中国人，对自己国粹的瓷器，总是情有独钟。 《中国青花瓷纹饰图典》的问世，为我们全面了解中国古代青花瓷绘文化，提供了生动真实的第一手资料，它填补了中国古代绘画中的空白，在中华美术研究方面具有很重要的价值和意义。与此同时，该书的出版亦为古瓷爱好者、收藏家鉴赏与研究青花瓷提供了一部有用的工具书，可以使人得到启和和教益。', 'http://www.flobby.top/dsh-client-uniapp/#/pages/forum/forum?id=12', 'http://8.153.16.66:9000/dsh/6f3a4be31af04cf4b1de898bceab5133.jpg', 0, '2024-08-15 20:11:43', '2024-08-15 20:13:11');
INSERT INTO `book` VALUES (6, '深入理解LINUX内核', '9787564102760', 7, 3, '碧落', 'Daniel P·Bovet', 92.00, 342, '平装', '2024-04-17 08:00:00', '博韦，计算机科学专业博士，意大利罗马大学Tor vergata分校全职教授。\n切萨蒂 数学和计算机科学博士，罗马大学Tor vergata分校工程学院计算机科学系助理研究员。', '为了彻底理解是什么使得Linux能正常运行以及其为何能在各种不同的系统中运行良好，你需要深入研究内核最本质的部分。内核处理CPU与外界间的所有交互，并且决定哪些程序将以什么顺序共享处理器时间。它如此有效地管理有限的内存，以至成百上千的进程能高效地共享系统。它熟练地统筹数据传输，这样CPU不用为等待速度相对较慢的硬盘而消耗比正常耗时更长的时间。\n《深入理解Linux内核，第三版》指导你对内核中使用的最重要的数据结构、算法和程序设计诀窍进行一次遍历。通过对表面特性的探究，作者给那些想知道自己机器工作原理的人提供了颇有价值的见解。书中讨论了Intel特有的重要性质。相关的代码片段被逐行剖析。然而，本书涵盖的不仅仅是代码的功能，它解释了Linux以自己的方式工作的理论基础。\n本书将使你了解Linux的所有内部工作，它不仅仅是一个理论上的练习。你将学习到哪些情况下Linux性能最佳，并且你将看到，在大量的不同环境里进行进程调度、文件存取和内存管理时，它如何满足提供良好的系统响应的需要。这本书将帮助你充分利用Linux系统。', 'http://www.flobby.top/dsh-client-uniapp/#/pages/forum/forum?id=13', 'http://8.153.16.66:9000/dsh/c1a011ec6c3b4740ba59f1c472c4618b.jpeg', 0, '2024-08-15 20:38:09', '2024-08-15 20:42:57');

-- ----------------------------
-- Table structure for book_exchange
-- ----------------------------
DROP TABLE IF EXISTS `book_exchange`;
CREATE TABLE `book_exchange`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NULL DEFAULT NULL COMMENT '书本id',
  `user_flag` varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `book_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `verify_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL COMMENT '0-未使用，1-已使用',
  `exchange_time` timestamp(0) NULL DEFAULT NULL COMMENT '兑换时间',
  `delete_flag` tinyint NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 227 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_exchange
-- ----------------------------

-- ----------------------------
-- Table structure for book_resource
-- ----------------------------
DROP TABLE IF EXISTS `book_resource`;
CREATE TABLE `book_resource`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '二维码 后台生成',
  `book_id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '上传人id',
  `enabled` int NOT NULL DEFAULT 0,
  `valid_status` int NOT NULL DEFAULT 0,
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_resource
-- ----------------------------
INSERT INTO `book_resource` VALUES (3, 'P3-1', 'https://123.crhj.cn/vedio.html', NULL, 6, 1, 0, 0, 0, '2024-08-22 22:39:16', '2024-08-22 22:39:16');
INSERT INTO `book_resource` VALUES (4, 'P3-2', 'https://123.crhj.cn/luntan.html', NULL, 6, 1, 0, 0, 0, '2024-08-22 22:39:16', '2024-08-22 22:39:16');
INSERT INTO `book_resource` VALUES (5, 'P3-3', 'http://www.baidu.com', NULL, 6, 1, 0, 0, 0, '2024-08-22 22:39:16', '2024-08-22 22:39:16');
INSERT INTO `book_resource` VALUES (6, 'P4-1', 'http://news.sina.com.cn', NULL, 6, 1, 0, 0, 0, '2024-08-22 22:39:16', '2024-08-22 22:39:16');
INSERT INTO `book_resource` VALUES (7, 'P4-2', 'http://www.126.com', NULL, 6, 1, 0, 0, 0, '2024-08-22 22:39:16', '2024-08-22 22:39:16');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `delete_flag` tinyint NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (4, '文学', '文学类图书包括小说、诗歌、戏剧等。这类图书主要关注语言文字的艺术表现，通过故事情节、人物塑造和语言表达来反映生活、表达思想感情。', 0, '2024-08-14 19:41:25', '2024-08-14 19:41:48');
INSERT INTO `category` VALUES (5, '科技', '科技类图书涵盖了科学技术各个领域的知识。包括物理、化学、生物、计算机、医学等学科的专著和科普读物。这类图书主要传递科学知识，介绍最新的科研成果和技术进展。', 0, '2024-08-14 19:41:43', '2024-08-14 19:41:43');
INSERT INTO `category` VALUES (6, '社科', '社科类图书主要包括社会科学领域的著作。如历史、哲学、政治、经济、社会学等。这类图书主要研究社会现象、社会关系以及人类行为，提供对社会的深入理解和分析。', 0, '2024-08-14 19:42:03', '2024-08-14 19:42:03');
INSERT INTO `category` VALUES (7, '教育', '教育类图书涵盖了各类教材和教辅书籍，以及针对不同年龄层次和学科的学习辅导书。还包括一些教育理论和教育方法的著作。', 0, '2024-08-14 19:42:18', '2024-08-14 19:42:18');
INSERT INTO `category` VALUES (8, '艺术', '艺术类图书主要涉及音乐、美术、舞蹈、戏剧等艺术形式的相关书籍。包括艺术理论、艺术作品赏析以及艺术技巧教程等。', 0, '2024-08-14 19:42:36', '2024-08-14 19:42:36');
INSERT INTO `category` VALUES (9, '生活', '生活类图书涉及日常生活的各个方面，如烹饪、养生、旅游、育儿等。这类图书主要提供生活指导和建议，帮助人们更好地生活。', 0, '2024-08-14 19:42:48', '2024-08-14 19:42:48');
INSERT INTO `category` VALUES (10, '22', '33', 1, '2024-08-14 19:42:59', '2024-08-14 19:42:59');
INSERT INTO `category` VALUES (11, '12', '12', 1, '2024-08-14 20:05:50', '2024-08-14 20:05:50');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `forum_id` int NULL DEFAULT NULL,
  `parent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级id',
  `user_id` int NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL COMMENT '帖子类型，取值 0： \'question\' 或1 ： \'answer\'',
  `file_type` int NULL DEFAULT 0 COMMENT '0-图片，1-语音',
  `files` json NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `enabled` int NULL DEFAULT 0,
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (20, 11, NULL, 1, 1, 0, '[]', '这本书写得太棒了！', 0, 0, '2024-08-15 19:50:58', '2024-08-15 19:50:58');
INSERT INTO `comment` VALUES (21, 11, '20', 1, 1, 0, '[]', '此书精彩绝伦，情节跌宕，令人沉浸，堪称佳作！', 0, 0, '2024-08-15 20:32:36', '2024-08-27 16:52:08');
INSERT INTO `comment` VALUES (22, 12, NULL, 1, 1, 0, '[]', '青花瓷之美，典雅韵致，传承千年文化魅力。', 0, 0, '2024-08-15 20:33:35', '2024-08-27 16:18:36');
INSERT INTO `comment` VALUES (23, 13, NULL, 1, 1, 0, '[\"http://8.153.16.66:9000/dsh/27d810502df64f29aac668d56c2765d9.jpg\", \"http://8.153.16.66:9000/dsh/137804f5d00e4c62acb476176d0974a2.jpg\"]', 'ok', 0, 0, '2024-08-20 19:36:45', '2024-08-27 15:48:52');
INSERT INTO `comment` VALUES (24, 13, NULL, 1, 1, 0, '[]', 'OK', 0, 1, '2024-08-20 19:37:13', '2024-08-27 16:36:43');
INSERT INTO `comment` VALUES (25, 13, NULL, 1, 1, 0, '[\"http://8.153.16.66:9000/dsh/137804f5d00e4c62acb476176d0974a2.jpg\"]', '牛啊', 0, 0, '2024-08-27 10:37:41', '2024-08-27 16:52:01');
INSERT INTO `comment` VALUES (26, 13, '25', 1, 1, 0, '[]', '你好', 0, 0, '2024-08-27 10:38:25', '2024-08-27 16:52:06');
INSERT INTO `comment` VALUES (27, 13, '25', 1, 1, 0, '[]', '你好', 0, 0, '2024-08-27 10:38:26', '2024-08-27 16:52:05');
INSERT INTO `comment` VALUES (28, 13, '25', 1, 1, 0, '[]', '111', 0, 0, '2024-08-27 10:42:30', '2024-08-27 16:52:05');
INSERT INTO `comment` VALUES (29, 12, NULL, 12, 1, 0, '[]', '写的好', 0, 0, '2024-08-27 10:51:06', '2024-08-27 10:51:06');
INSERT INTO `comment` VALUES (30, 12, '22', 12, 1, 0, '[]', '好有文化', 0, 0, '2024-08-27 10:51:15', '2024-08-27 16:52:04');
INSERT INTO `comment` VALUES (31, 13, NULL, 12, 1, 0, '[]', '看个书', 0, 1, '2024-08-27 10:53:24', '2024-08-27 16:39:19');
INSERT INTO `comment` VALUES (32, 12, NULL, 12, 1, 0, '[\"http://8.153.16.66:9000/dsh/1df9ef92bff041ffbdee4a48b3ab2a56.png\"]', '111', 0, 0, '2024-09-01 17:16:02', '2024-09-01 17:16:02');
INSERT INTO `comment` VALUES (37, 13, NULL, 12, 1, 1, '[\"http://8.153.16.66:9000/dsh/21e9fec5e53844ccbcd254e4c680a163.file-1725187820376\"]', '语音消息', 0, 0, '2024-09-01 18:50:18', '2024-09-01 20:41:42');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `user_id` int NOT NULL COMMENT '用户id',
  `delete_flag` tinyint NOT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------

-- ----------------------------
-- Table structure for forum
-- ----------------------------
DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `course_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `book_id` int NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '作者答缺省价',
  `writer_introduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `voice_introduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES (11, 1, '一个人的旅行', NULL, 4, 0.00, '从小爱看爱画漫画。曾想过当漫画家却没有认真实践。大学选读艺术，毕业后负笈英国修读多媒体设计，当过小学教师、大学导师以及设计师，却发现对漫画仍念念不忘，最终重拾曾经放弃的漫画事业，关心时事政治，强迫自己相信漫画终有一天能改变世界。', NULL, 'http://8.153.16.66:9000/dsh/27d810502df64f29aac668d56c2765d9.jpg', 'http://8.153.16.66:9000/dsh/137804f5d00e4c62acb476176d0974a2.jpg', 0, '2024-08-15 19:45:38', '2024-08-15 19:54:42');
INSERT INTO `forum` VALUES (12, 1, '中国青花瓷纹饰图典', NULL, 5, 0.00, '江苏省古陶瓷研究会', NULL, 'http://8.153.16.66:9000/dsh/04e5d495354b479d8665d4d1a3a50515.jpg', NULL, 0, '2024-08-15 20:13:12', '2024-08-15 20:13:12');
INSERT INTO `forum` VALUES (13, 1, '深入理解LINUX内核', NULL, 6, 0.10, '博韦，计算机科学专业博士，意大利罗马大学Tor vergata分校全职教授。\n切萨蒂 数学和计算机科学博士，罗马大学Tor vergata分校工程学院计算机科学系助理研究员。', NULL, 'http://8.153.16.66:9000/dsh/acc0c67a5a5b4ba3bcbb7d5e0870e66a.jpeg', NULL, 0, '2024-08-15 20:42:57', '2024-08-15 20:42:57');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `forum_id` int NULL DEFAULT NULL,
  `admin_id` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `valid_time` timestamp(0) NULL DEFAULT NULL COMMENT '生效日期',
  `is_top` tinyint NULL DEFAULT NULL COMMENT '0-不置顶，1,-置顶',
  `delete_flag` tinyint NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (6, 11, 6, '欢迎', '欢迎大家！', '2024-08-15 00:00:00', 0, 0, '2024-08-15 20:13:52', '2024-08-15 20:13:52');
INSERT INTO `notice` VALUES (7, 11, 6, '欢迎', '欢迎大家积极讨论', '2024-08-14 08:00:00', 1, 0, '2024-08-15 20:14:26', '2024-08-15 20:31:16');
INSERT INTO `notice` VALUES (8, 11, 6, '233', '22', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:14:35', '2024-08-15 20:14:35');
INSERT INTO `notice` VALUES (9, 11, 6, '22', '22', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:14:41', '2024-08-15 20:14:41');
INSERT INTO `notice` VALUES (10, 11, 6, '22', '22', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:14:47', '2024-08-15 20:14:47');
INSERT INTO `notice` VALUES (11, 11, 6, '8i', '887', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:30:17', '2024-08-15 20:30:17');
INSERT INTO `notice` VALUES (12, 11, 6, '88', '8888', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:30:24', '2024-08-15 20:30:24');
INSERT INTO `notice` VALUES (13, 11, 6, '88', '88', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:30:33', '2024-08-15 20:30:33');
INSERT INTO `notice` VALUES (14, 11, 6, '88', '888', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:30:39', '2024-08-15 20:30:39');
INSERT INTO `notice` VALUES (15, 11, 6, '88', '88', '2024-08-15 00:00:00', 0, 1, '2024-08-15 20:30:44', '2024-08-15 20:30:44');
INSERT INTO `notice` VALUES (16, 11, 6, '888', '8888', '2024-08-16 00:00:00', 0, 1, '2024-08-15 20:30:50', '2024-08-15 20:31:08');

-- ----------------------------
-- Table structure for publisher
-- ----------------------------
DROP TABLE IF EXISTS `publisher`;
CREATE TABLE `publisher`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `delete_flag` tinyint NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of publisher
-- ----------------------------
INSERT INTO `publisher` VALUES (3, '东南大学出版社', '东南大学出版社', 0, '2024-08-14 19:39:26', '2024-08-14 19:39:26');
INSERT INTO `publisher` VALUES (4, '南京师范大学出版社', '南京师范大学出版社', 0, '2024-08-14 19:39:43', '2024-08-14 19:39:43');
INSERT INTO `publisher` VALUES (5, '什么2', '12', 1, '2024-08-14 19:39:57', '2024-08-14 19:39:51');

-- ----------------------------
-- Table structure for suggestion
-- ----------------------------
DROP TABLE IF EXISTS `suggestion`;
CREATE TABLE `suggestion`  (
  `id` int NOT NULL,
  `user_id` int NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of suggestion
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT '主键唯一字段',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '编号',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '0:未删除  1:已删除',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, '性别', 'gender', 'gender', 0, '2024-03-08 09:37:55', '2024-03-08 09:37:55');
INSERT INTO `sys_dict` VALUES (2, '分类类型', 'categoryType', 'categoryType', 1, '2024-03-08 09:38:53', '2024-06-17 10:16:35');
INSERT INTO `sys_dict` VALUES (3, '是否置顶', 'isTop', 'isTop', 1, '2024-03-08 09:39:41', '2024-06-17 10:16:38');
INSERT INTO `sys_dict` VALUES (4, '审核状态', 'status', 'status', 1, '2024-03-08 09:40:29', '2024-06-17 10:16:40');
INSERT INTO `sys_dict` VALUES (5, '是否热门', 'isHot', 'isHot', 1, '2024-03-08 09:41:15', '2024-06-17 10:16:42');
INSERT INTO `sys_dict` VALUES (6, '是否轮播', 'isSwiper', 'isSwiper', 1, '2024-03-08 09:43:44', '2024-06-17 10:16:44');

-- ----------------------------
-- Table structure for sys_dict_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_config`;
CREATE TABLE `sys_dict_config`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT '主键唯一字段',
  `dict_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据值',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '0:未删除  1:已删除',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_config
-- ----------------------------
INSERT INTO `sys_dict_config` VALUES (1, 'gender', '男', '0', 0, '2024-03-08 09:38:06', '2024-03-08 09:38:06');
INSERT INTO `sys_dict_config` VALUES (2, 'gender', '女', '1', 0, '2024-03-08 09:38:11', '2024-03-08 09:38:11');
INSERT INTO `sys_dict_config` VALUES (3, 'categoryType', '网盘类型', '0', 1, '2024-03-08 09:39:04', '2024-06-17 02:16:29');
INSERT INTO `sys_dict_config` VALUES (4, 'categoryType', '资源类型', '1', 1, '2024-03-08 09:39:11', '2024-06-17 02:16:29');
INSERT INTO `sys_dict_config` VALUES (5, 'isTop', '是', '1', 1, '2024-03-08 09:39:52', '2024-06-17 02:16:32');
INSERT INTO `sys_dict_config` VALUES (6, 'isTop', '否', '0', 1, '2024-03-08 09:39:57', '2024-06-17 02:16:32');
INSERT INTO `sys_dict_config` VALUES (7, 'status', '待审核', '0', 1, '2024-03-08 09:40:45', '2024-06-17 02:16:34');
INSERT INTO `sys_dict_config` VALUES (8, 'status', '审核通过', '1', 1, '2024-03-08 09:40:52', '2024-06-17 02:16:34');
INSERT INTO `sys_dict_config` VALUES (9, 'status', '审核不通过', '2', 1, '2024-03-08 09:40:58', '2024-06-17 02:16:34');
INSERT INTO `sys_dict_config` VALUES (10, 'isHot', '是', '1', 1, '2024-03-08 09:41:26', '2024-06-17 02:16:36');
INSERT INTO `sys_dict_config` VALUES (11, 'isHot', '否', '0', 1, '2024-03-08 09:41:32', '2024-06-17 02:16:36');
INSERT INTO `sys_dict_config` VALUES (12, 'isSwiper', '是', '1', 1, '2024-03-08 09:43:56', '2024-06-17 02:16:38');
INSERT INTO `sys_dict_config` VALUES (13, 'isSwiper', '否', '0', 1, '2024-03-08 09:44:00', '2024-06-17 02:16:38');

-- ----------------------------
-- Table structure for sys_manager
-- ----------------------------
DROP TABLE IF EXISTS `sys_manager`;
CREATE TABLE `sys_manager`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `super_admin` tinyint NOT NULL DEFAULT 0 COMMENT '超级管理员   0：否   1：是',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态  0：停用   1：正常',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '删除标识  0：正常   1：已删除',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_manager
-- ----------------------------
INSERT INTO `sys_manager` VALUES (1, 'admin', '{bcrypt}$2a$10$mW/yJPHjyueQ1g26WNBz0uxVPa0GQdJO1fFZmqdkqgMTGnyszlXxu', 'https://cdn.maku.net/images/avatar.png', 1, 1, 0, '2023-05-18 18:18:55', '2024-02-28 09:27:51');
INSERT INTO `sys_manager` VALUES (2, 'user', '{bcrypt}$2a$10$IPBm/F3E7NUeX/I1xfr0iO5ZzghwCQp/kc4NDGmRf.rVYuApWWvzC', '', 0, 1, 1, '2024-03-08 12:23:28', '2024-03-13 10:52:38');
INSERT INTO `sys_manager` VALUES (3, '北京大学出版社管理员', '{bcrypt}$2a$10$qAxwKywaR28fubM84dfOKuOHiPGYCGRtVsA/Sfe2BUrFBp6m5aRiy', '', 0, 1, 1, '2024-06-30 14:35:55', '2024-08-09 14:10:56');
INSERT INTO `sys_manager` VALUES (4, '清华大学出版社管理员', '{bcrypt}$2a$10$it4Kw8uv0itJ91TQ8sxfv.Vf.hpaiCylD4zh.7eC72viypvRYkERm', '', 0, 1, 1, '2024-06-30 14:39:11', '2024-08-09 14:10:52');
INSERT INTO `sys_manager` VALUES (5, '北京出版社管理员', '{bcrypt}$2a$10$wjhWROdHrsz7AHruZ1n/a.YzopeUfg3lDU8FEGSbktaW/qZK1kRk.', '', 0, 1, 1, '2024-06-30 14:40:13', '2024-08-09 14:10:50');
INSERT INTO `sys_manager` VALUES (6, 'tinna', '{bcrypt}$2a$10$EVSAB68wBkSMQP/hLzXJsuoJrDir38jBfDRqM5Wby1aDBdscK5w.m', 'http://8.153.16.66:9000/dsh/9010ef2735814c3fbec355534e4f4e23.jpeg', 0, 1, 0, '2024-08-14 20:12:54', '2024-08-15 20:08:48');
INSERT INTO `sys_manager` VALUES (7, '1233', '{bcrypt}$2a$10$G5U4p78lUSxLg7kXl4fucuSQT1ExKW.BobPHo2XpXs3C6E67oVi1.', '', 0, 1, 1, '2024-08-14 20:13:31', '2024-08-14 20:13:56');
INSERT INTO `sys_manager` VALUES (8, '灵灵', '{bcrypt}$2a$10$NGCxiKdsvzRmaa/JluIL.O.7Wwo9URxvTfRB3BuSRpTm1T5TR6RD2', '', 0, 1, 0, '2024-08-14 20:14:24', '2024-08-14 20:15:31');
INSERT INTO `sys_manager` VALUES (9, '东南大学出版社', '{bcrypt}$2a$10$pz5DrFBZMc5KBQRG3kKfF.uyYSgyPgQOKtI0dxDOY48AHhvsTtvzK', '', 0, 1, 0, '2024-08-14 20:15:03', '2024-08-14 20:15:03');

-- ----------------------------
-- Table structure for sys_manager_publisher
-- ----------------------------
DROP TABLE IF EXISTS `sys_manager_publisher`;
CREATE TABLE `sys_manager_publisher`  (
  `manager_id` int NOT NULL,
  `publisher_id` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_manager_publisher
-- ----------------------------
INSERT INTO `sys_manager_publisher` VALUES (9, 3);

-- ----------------------------
-- Table structure for sys_manager_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_manager_role`;
CREATE TABLE `sys_manager_role`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int NOT NULL COMMENT '角色ID',
  `manager_id` int NOT NULL COMMENT '用户ID',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '删除标识  0：正常   1：已删除',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_manager_role
-- ----------------------------
INSERT INTO `sys_manager_role` VALUES (1, 1, 1, 0, '2024-02-28 10:17:32', '2024-02-28 10:17:32');
INSERT INTO `sys_manager_role` VALUES (2, 2, 2, 1, '2024-03-08 12:23:28', '2024-03-13 10:52:46');
INSERT INTO `sys_manager_role` VALUES (3, 2, 3, 1, '2024-06-30 14:35:55', '2024-08-09 14:10:55');
INSERT INTO `sys_manager_role` VALUES (4, 2, 4, 1, '2024-06-30 14:39:11', '2024-08-09 14:10:52');
INSERT INTO `sys_manager_role` VALUES (5, 2, 5, 1, '2024-06-30 14:40:13', '2024-08-09 14:10:49');
INSERT INTO `sys_manager_role` VALUES (6, 1, 6, 0, '2024-08-14 20:12:54', '2024-08-14 20:12:54');
INSERT INTO `sys_manager_role` VALUES (7, 2, 7, 1, '2024-08-14 20:13:31', '2024-08-14 20:13:56');
INSERT INTO `sys_manager_role` VALUES (8, 4, 8, 0, '2024-08-14 20:14:24', '2024-08-14 20:14:24');
INSERT INTO `sys_manager_role` VALUES (9, 2, 9, 0, '2024-08-14 20:15:03', '2024-08-14 20:15:03');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `parent_id` int NOT NULL DEFAULT 0 COMMENT '父级id',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '路径',
  `component` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单类型 menu: 菜单 button: 按钮',
  `open_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '打开类型 tab: 选项卡 url: 外链',
  `url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '外链地址',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单图标',
  `auth` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '授权标识(多个用逗号分隔，如：sys:menu:list,sys:menu:save)',
  `keep_alive` tinyint NOT NULL DEFAULT 0 COMMENT '是否缓存 0:true 1:false',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `hide` tinyint NOT NULL DEFAULT 1 COMMENT '是否隐藏（0:true,1fasle）',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 193 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, 'system', '系统管理', '/system', '', 'MENU_DIR', '', '', 'Tools', '', 0, 10, 0, '2023-07-11 07:36:12', '2024-06-17 10:57:14', 1);
INSERT INTO `sys_menu` VALUES (2, 1, 'Manager', '管理员管理', '/system/manager', '/System/Manager', 'MENU', 'TAB', '', 'Avatar', 'sys:manager:list', 0, 1, 0, '2023-07-11 07:37:01', '2024-06-17 10:35:59', 1);
INSERT INTO `sys_menu` VALUES (3, 1, 'Role', '角色管理', '/system/role', '/System/Role', 'MENU', 'TAB', '', 'BellFilled', 'sys:role:list', 0, 2, 0, '2023-07-11 07:37:01', '2023-07-27 01:35:51', 1);
INSERT INTO `sys_menu` VALUES (4, 1, 'Menu', '菜单管理', '/system/menu', '/System/Menu', 'MENU', 'TAB', '', 'Menu', 'sys:menu:list', 0, 3, 0, '2023-07-11 07:37:01', '2024-06-17 10:35:33', 1);
INSERT INTO `sys_menu` VALUES (5, 4, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:menu:view', 1, 0, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:05', 1);
INSERT INTO `sys_menu` VALUES (6, 4, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:menu:add', 1, 1, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:07', 1);
INSERT INTO `sys_menu` VALUES (7, 4, 'edit', '编辑', '', '', 'BUTTON', '', '', '', 'sys:menu:edit', 1, 2, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:09', 1);
INSERT INTO `sys_menu` VALUES (8, 4, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:menu:remove', 1, 3, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:12', 1);
INSERT INTO `sys_menu` VALUES (9, 3, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:role:view', 1, 0, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:15', 1);
INSERT INTO `sys_menu` VALUES (10, 3, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:role:add', 1, 1, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:18', 1);
INSERT INTO `sys_menu` VALUES (11, 3, 'edit', '编辑', '', '', 'BUTTON', '', '', '', 'sys:role:edit', 1, 2, 0, '2023-07-11 07:37:19', '2024-02-28 10:25:20', 1);
INSERT INTO `sys_menu` VALUES (12, 3, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:role:remove', 1, 3, 0, '2023-07-11 07:37:19', '2024-06-17 02:32:44', 1);
INSERT INTO `sys_menu` VALUES (13, 2, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:manager:add', 1, 0, 0, '2023-07-26 09:01:40', '2024-02-28 10:25:31', 1);
INSERT INTO `sys_menu` VALUES (14, 2, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:manager:view', 1, 1, 0, '2023-07-26 09:02:05', '2024-02-28 10:25:36', 1);
INSERT INTO `sys_menu` VALUES (16, 2, 'reset-psw', '重置密码', '', '', 'BUTTON', '', '', '', 'sys:manager:reset-psw', 1, 3, 0, '2023-07-26 09:03:16', '2024-02-28 10:25:42', 1);
INSERT INTO `sys_menu` VALUES (17, 2, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:manager:remove', 1, 4, 0, '2023-07-26 09:03:33', '2024-02-28 10:25:45', 1);
INSERT INTO `sys_menu` VALUES (18, 0, 'home', '首页', '/home', '/Home/Home', 'MENU', 'TAB', '', 'HomeFilled', 'none', 1, 0, 0, '2023-11-01 03:38:01', '2024-02-28 10:25:49', 1);
INSERT INTO `sys_menu` VALUES (19, 2, 'edit', '编辑', '', '', 'BUTTON', '', '', '', 'sys:manager:edit', 1, 0, 0, '2023-12-02 01:56:23', '2024-02-28 10:25:53', 1);
INSERT INTO `sys_menu` VALUES (20, 1, 'Dict', '字典管理', '/system/dict', '/System/Dict/index', 'MENU', 'TAB', '', 'Memo', 'sys:dict:list', 1, 4, 0, '2024-02-27 08:16:57', '2024-08-31 13:12:59', 0);
INSERT INTO `sys_menu` VALUES (145, 20, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:dict:view', 1, 0, 0, '2024-06-17 02:33:25', '2024-06-17 02:33:25', 1);
INSERT INTO `sys_menu` VALUES (146, 20, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:dict:add', 0, 1, 0, '2024-06-17 10:34:08', '2024-06-17 10:34:08', 1);
INSERT INTO `sys_menu` VALUES (147, 20, 'edit', '编辑', '', '', 'BUTTON', '', '', '', 'sys:dict:edit', 0, 2, 0, '2024-06-17 10:34:40', '2024-06-17 10:34:40', 1);
INSERT INTO `sys_menu` VALUES (148, 20, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:dict:remove', 0, 3, 0, '2024-06-17 10:35:04', '2024-06-17 10:35:04', 1);
INSERT INTO `sys_menu` VALUES (149, 0, 'feedback', '意见反馈', '/feedback', '/Feedback/Feedback', 'MENU', 'TAB', '', 'PhoneFilled', '', 0, 7, 0, '2024-06-17 10:49:01', '2024-06-17 11:06:09', 1);
INSERT INTO `sys_menu` VALUES (150, 170, 'user', '用户管理', '/user', '/User/UserManage', 'MENU', 'TAB', '', 'Avatar', '', 0, 0, 0, '2024-06-17 10:51:24', '2024-06-17 11:59:56', 1);
INSERT INTO `sys_menu` VALUES (151, 0, 'business', '业务管理', '/business', '', 'MENU_DIR', '', '', 'GoodsFilled', '', 0, 1, 0, '2024-06-17 10:52:44', '2024-06-17 10:52:44', 1);
INSERT INTO `sys_menu` VALUES (152, 151, 'book', '图书管理', '/business/book', '/Book/Book', 'MENU', 'TAB', '', 'Notebook', '', 0, 0, 0, '2024-06-17 10:54:10', '2024-06-19 15:24:10', 1);
INSERT INTO `sys_menu` VALUES (153, 151, 'mixed', '融合管理', '/business/mixed', '/Mixed/Mixed', 'MENU', 'TAB', '', 'HelpFilled', '', 0, 1, 0, '2024-06-17 10:55:35', '2024-06-19 15:31:14', 1);
INSERT INTO `sys_menu` VALUES (154, 0, 'audit', '内容审核', '/audit', '', 'MENU_DIR', '', '', 'EditPen', '', 0, 6, 0, '2024-06-17 10:56:56', '2024-06-19 14:20:50', 1);
INSERT INTO `sys_menu` VALUES (155, 149, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:feedback:view', 0, 0, 0, '2024-06-17 10:58:25', '2024-06-17 10:58:25', 1);
INSERT INTO `sys_menu` VALUES (156, 149, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:feedback:remove', 0, 1, 0, '2024-06-17 10:58:50', '2024-06-17 10:58:50', 1);
INSERT INTO `sys_menu` VALUES (157, 150, 'freeze', '冻结', '', '', 'BUTTON', '', '', '', 'sys:user:freeze', 0, 0, 0, '2024-06-17 10:59:22', '2024-06-17 10:59:22', 1);
INSERT INTO `sys_menu` VALUES (158, 150, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:user:view', 0, 0, 0, '2024-06-17 10:59:41', '2024-06-17 10:59:41', 1);
INSERT INTO `sys_menu` VALUES (159, 150, 'edit', '编辑', '', '', 'BUTTON', '', '', '', 'sys:user:edit', 0, 0, 0, '2024-06-17 11:00:04', '2024-06-17 11:00:04', 1);
INSERT INTO `sys_menu` VALUES (160, 150, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:user:remove', 0, 0, 0, '2024-06-17 11:00:28', '2024-06-17 11:00:28', 1);
INSERT INTO `sys_menu` VALUES (161, 150, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:user:add', 0, 0, 0, '2024-06-17 11:00:53', '2024-06-17 11:00:53', 1);
INSERT INTO `sys_menu` VALUES (162, 152, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:book:add', 0, 0, 0, '2024-06-17 11:01:22', '2024-06-17 11:01:22', 1);
INSERT INTO `sys_menu` VALUES (163, 152, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:book:remove', 0, 0, 0, '2024-06-17 11:01:43', '2024-06-17 11:01:43', 1);
INSERT INTO `sys_menu` VALUES (164, 152, 'edit', '修改', '', '', 'BUTTON', '', '', '', 'sys:book:edit', 0, 0, 0, '2024-06-17 11:01:59', '2024-06-17 11:01:59', 1);
INSERT INTO `sys_menu` VALUES (165, 152, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:book:view', 0, 0, 0, '2024-06-17 11:02:14', '2024-06-17 11:02:14', 1);
INSERT INTO `sys_menu` VALUES (166, 153, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:forum:view', 0, 0, 0, '2024-06-17 11:03:14', '2024-06-19 07:17:06', 1);
INSERT INTO `sys_menu` VALUES (167, 153, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:forum:add', 0, 0, 0, '2024-06-17 11:03:42', '2024-06-19 07:17:11', 1);
INSERT INTO `sys_menu` VALUES (168, 153, 'edit', '修改', '', '', 'BUTTON', '', '', '', 'sys:forum:edit', 0, 0, 0, '2024-06-17 11:04:08', '2024-06-19 07:17:14', 1);
INSERT INTO `sys_menu` VALUES (169, 153, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:forum:remove', 0, 0, 0, '2024-06-17 11:04:30', '2024-06-19 07:17:17', 1);
INSERT INTO `sys_menu` VALUES (170, 0, 'base', '基础管理', '/base', '', 'MENU_DIR', '', '', 'Coin', '', 0, 2, 0, '2024-06-17 11:05:42', '2024-06-17 11:05:42', 1);
INSERT INTO `sys_menu` VALUES (171, 170, 'notice', '公告管理', '/notice', '/Notice/Notice', 'MENU', 'TAB', '', 'Document', '', 0, 1, 0, '2024-06-17 11:07:35', '2024-06-17 11:07:35', 1);
INSERT INTO `sys_menu` VALUES (172, 170, 'category', '分类管理', '/category', '/Category/Category', 'MENU', 'TAB', '', 'Grid', '', 0, 5, 0, '2024-06-17 11:08:29', '2024-06-17 11:08:29', 1);
INSERT INTO `sys_menu` VALUES (173, 171, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:notice:view', 0, 0, 0, '2024-06-17 11:08:54', '2024-06-17 11:08:54', 1);
INSERT INTO `sys_menu` VALUES (174, 171, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:notice:add', 0, 0, 0, '2024-06-17 11:09:17', '2024-06-17 11:09:17', 1);
INSERT INTO `sys_menu` VALUES (175, 171, 'edit', '修改', '', '', 'BUTTON', '', '', '', 'sys:notice:edit', 0, 0, 0, '2024-06-17 11:09:34', '2024-06-17 11:09:34', 1);
INSERT INTO `sys_menu` VALUES (176, 171, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:notice:remove', 0, 0, 0, '2024-06-17 11:09:53', '2024-06-17 11:09:53', 1);
INSERT INTO `sys_menu` VALUES (177, 172, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:category:add', 0, 0, 0, '2024-06-17 11:10:12', '2024-06-17 11:10:12', 1);
INSERT INTO `sys_menu` VALUES (178, 172, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:category:view', 0, 0, 0, '2024-06-17 11:10:37', '2024-06-17 11:10:37', 1);
INSERT INTO `sys_menu` VALUES (179, 172, 'edit', '修改', '', '', 'BUTTON', '', '', '', 'sys:category:edit', 0, 0, 0, '2024-06-17 11:11:04', '2024-06-17 11:11:04', 1);
INSERT INTO `sys_menu` VALUES (180, 172, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:category:remove', 0, 0, 0, '2024-06-17 11:11:27', '2024-06-17 11:11:27', 1);
INSERT INTO `sys_menu` VALUES (181, 154, 'forum', '书圈论坛', '/audit/forum', '/Audit/Forum', 'MENU', 'TAB', '', 'Medal', '', 0, 5, 0, '2024-06-19 14:35:22', '2024-08-20 11:15:20', 0);
INSERT INTO `sys_menu` VALUES (182, 154, 'web', '网站审核', '/audit/web', '/Audit/Web', 'MENU', 'TAB', '', 'CreditCard', '', 0, 0, 0, '2024-06-19 14:36:06', '2024-06-19 15:00:11', 1);
INSERT INTO `sys_menu` VALUES (183, 154, 'shortVideo', '短视频', '/audit/shortVideo', '/Audit/ShortVideo', 'MENU', 'TAB', '', 'Camera', '', 0, 1, 0, '2024-06-19 14:36:52', '2024-06-19 15:00:25', 1);
INSERT INTO `sys_menu` VALUES (184, 154, 'offlineVideo', '离线视频', '/audit/offlineVideo', '/Audit/OfflineVideo', 'MENU', 'TAB', '', 'VideoCamera', '', 0, 2, 0, '2024-06-19 14:38:14', '2024-06-19 15:00:33', 1);
INSERT INTO `sys_menu` VALUES (185, 154, 'word', '图书文字', '/audit/word', '/Audit/Word', 'MENU', 'TAB', '', 'Document', '', 0, 3, 0, '2024-06-19 14:39:12', '2024-06-19 15:00:39', 1);
INSERT INTO `sys_menu` VALUES (186, 154, 'picture', '图书插图', '/audit/picture', '/Audit/Picture', 'MENU', 'TAB', '', 'Picture', '', 0, 4, 0, '2024-06-19 14:39:56', '2024-06-19 15:00:44', 1);
INSERT INTO `sys_menu` VALUES (187, 170, 'publisher', '出版社管理', '/publisher', '/Publisher/Publisher', 'MENU', 'TAB', '', 'OfficeBuilding', '', 0, 5, 0, '2024-06-30 12:56:18', '2024-06-30 12:56:36', 1);
INSERT INTO `sys_menu` VALUES (188, 187, 'add', '新增', '', '', 'BUTTON', '', '', '', 'sys:publisher:add', 0, 0, 0, '2024-06-30 12:57:16', '2024-06-30 12:57:16', 1);
INSERT INTO `sys_menu` VALUES (189, 187, 'view', '查看', '', '', 'BUTTON', '', '', '', 'sys:publisher:view', 0, 0, 0, '2024-06-30 12:57:50', '2024-06-30 12:57:50', 1);
INSERT INTO `sys_menu` VALUES (190, 187, 'edit', '编辑', '', '', 'BUTTON', '', '', '', 'sys:publisher:edit', 0, 0, 0, '2024-06-30 12:58:19', '2024-06-30 12:58:19', 1);
INSERT INTO `sys_menu` VALUES (191, 187, 'remove', '删除', '', '', 'BUTTON', '', '', '', 'sys:publisher:remove', 0, 0, 0, '2024-06-30 12:58:39', '2024-06-30 12:58:39', 1);
INSERT INTO `sys_menu` VALUES (192, 154, 'qrCode', '二维码审核', '/aduit/qrcode', '/Audit/QrCode', 'MENU', 'TAB', '', 'FullScreen', '', 0, 6, 0, '2024-08-09 14:09:56', '2024-08-09 14:09:56', 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '删除标识  0：正常   1：已删除',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员', 0, '2024-02-28 10:18:26', '2024-08-09 14:10:05');
INSERT INTO `sys_role` VALUES (2, '出版社管理员', '出版社管理员', 0, '2024-06-30 13:15:58', '2024-06-30 22:21:45');
INSERT INTO `sys_role` VALUES (4, '普通用户', '普通用户', 0, '2024-06-30 13:17:08', '2024-06-30 13:17:08');
INSERT INTO `sys_role` VALUES (5, '2332', '23333', 1, '2024-08-14 20:15:57', '2024-08-14 20:16:05');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `pk_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int NOT NULL COMMENT '角色ID',
  `menu_id` int NOT NULL COMMENT '菜单ID',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '删除标识  0：正常   1：已删除',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`pk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 168 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (49, 1, 18, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (67, 1, 1, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (68, 1, 2, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (69, 1, 19, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (70, 1, 13, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (71, 1, 14, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (72, 1, 16, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (73, 1, 17, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (74, 1, 3, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (75, 1, 9, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (76, 1, 10, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (77, 1, 11, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (78, 1, 12, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (79, 1, 20, 0, '2024-03-08 12:09:11', '2024-03-08 12:09:11');
INSERT INTO `sys_role_menu` VALUES (86, 1, 151, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (87, 1, 152, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (88, 1, 162, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (89, 1, 163, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (90, 1, 164, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (91, 1, 165, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (92, 1, 153, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (93, 1, 166, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (94, 1, 167, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (95, 1, 168, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (96, 1, 169, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (97, 1, 170, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (98, 1, 150, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (99, 1, 158, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (100, 1, 157, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (101, 1, 159, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (102, 1, 160, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (103, 1, 161, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (104, 1, 171, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (105, 1, 173, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (106, 1, 174, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (107, 1, 175, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (108, 1, 176, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (109, 1, 172, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (110, 1, 177, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (111, 1, 178, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (112, 1, 179, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (113, 1, 180, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (114, 1, 154, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (115, 1, 149, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (116, 1, 155, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (117, 1, 156, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (118, 1, 145, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (119, 1, 146, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (120, 1, 147, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (121, 1, 148, 0, '2024-06-17 11:13:05', '2024-06-17 11:13:05');
INSERT INTO `sys_role_menu` VALUES (122, 1, 182, 0, '2024-06-19 14:40:24', '2024-06-19 14:40:24');
INSERT INTO `sys_role_menu` VALUES (123, 1, 183, 0, '2024-06-19 14:40:24', '2024-06-19 14:40:24');
INSERT INTO `sys_role_menu` VALUES (124, 1, 184, 0, '2024-06-19 14:40:24', '2024-06-19 14:40:24');
INSERT INTO `sys_role_menu` VALUES (125, 1, 185, 0, '2024-06-19 14:40:24', '2024-06-19 14:40:24');
INSERT INTO `sys_role_menu` VALUES (126, 1, 186, 0, '2024-06-19 14:40:24', '2024-06-19 14:40:24');
INSERT INTO `sys_role_menu` VALUES (127, 1, 181, 0, '2024-06-19 14:40:24', '2024-06-19 14:40:24');
INSERT INTO `sys_role_menu` VALUES (128, 1, 187, 0, '2024-06-30 12:58:55', '2024-06-30 12:58:55');
INSERT INTO `sys_role_menu` VALUES (129, 1, 188, 0, '2024-06-30 12:58:55', '2024-06-30 12:58:55');
INSERT INTO `sys_role_menu` VALUES (130, 1, 189, 0, '2024-06-30 12:58:55', '2024-06-30 12:58:55');
INSERT INTO `sys_role_menu` VALUES (131, 1, 190, 0, '2024-06-30 12:58:55', '2024-06-30 12:58:55');
INSERT INTO `sys_role_menu` VALUES (132, 1, 191, 0, '2024-06-30 12:58:55', '2024-06-30 12:58:55');
INSERT INTO `sys_role_menu` VALUES (133, 2, 18, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (134, 2, 152, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (135, 2, 162, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (136, 2, 163, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (137, 2, 164, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (138, 2, 165, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (139, 2, 166, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (140, 2, 188, 1, '2024-06-30 13:15:58', '2024-06-30 14:21:43');
INSERT INTO `sys_role_menu` VALUES (141, 2, 189, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (142, 2, 190, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (143, 2, 172, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (144, 2, 177, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (145, 2, 178, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (146, 2, 179, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (147, 2, 180, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (148, 2, 154, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (149, 2, 182, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (150, 2, 183, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (151, 2, 184, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (152, 2, 185, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (153, 2, 186, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (154, 2, 181, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (155, 2, 149, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (156, 2, 155, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (157, 2, 156, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (158, 2, 151, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (159, 2, 153, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (160, 2, 170, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (161, 2, 187, 0, '2024-06-30 13:15:58', '2024-06-30 07:02:22');
INSERT INTO `sys_role_menu` VALUES (162, 4, 18, 0, '2024-06-30 13:17:08', '2024-06-30 13:17:08');
INSERT INTO `sys_role_menu` VALUES (163, 1, 192, 0, '2024-08-09 14:10:05', '2024-08-09 14:10:05');
INSERT INTO `sys_role_menu` VALUES (164, 5, 18, 1, '2024-08-14 20:15:57', '2024-08-14 20:16:05');
INSERT INTO `sys_role_menu` VALUES (165, 5, 158, 1, '2024-08-14 20:16:02', '2024-08-14 20:16:05');
INSERT INTO `sys_role_menu` VALUES (166, 5, 170, 1, '2024-08-14 20:16:02', '2024-08-14 20:16:05');
INSERT INTO `sys_role_menu` VALUES (167, 5, 150, 1, '2024-08-14 20:16:02', '2024-08-14 20:16:05');

-- ----------------------------
-- Table structure for user_action
-- ----------------------------
DROP TABLE IF EXISTS `user_action`;
CREATE TABLE `user_action`  (
  `user_id` int NOT NULL,
  `action_type` int NULL DEFAULT NULL COMMENT '0-关注论坛，1-点赞评论，2-收藏评论',
  `source_id` int NULL DEFAULT NULL COMMENT 'action为0时对应forumId，其他对应commentId',
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `delete_flag` tinyint NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_action
-- ----------------------------
INSERT INTO `user_action` VALUES (1, 1, 20, '2024-08-15 19:51:22', 1, '2024-08-15 19:51:22');
INSERT INTO `user_action` VALUES (1, 2, 20, '2024-08-15 19:51:24', 1, '2024-08-15 19:51:24');
INSERT INTO `user_action` VALUES (1, 1, 20, '2024-08-15 19:51:28', 1, '2024-08-15 19:51:28');
INSERT INTO `user_action` VALUES (1, 0, 11, '2024-08-15 19:52:15', 1, '2024-08-15 19:52:15');
INSERT INTO `user_action` VALUES (1, 0, 11, '2024-08-15 19:52:21', 0, '2024-08-15 19:52:21');
INSERT INTO `user_action` VALUES (1, 2, 21, '2024-08-15 20:32:40', 0, '2024-08-15 20:32:40');
INSERT INTO `user_action` VALUES (1, 1, 21, '2024-08-15 20:32:42', 0, '2024-08-15 20:32:42');
INSERT INTO `user_action` VALUES (1, 0, 12, '2024-08-15 20:33:45', 0, '2024-08-15 20:33:45');
INSERT INTO `user_action` VALUES (1, 0, 13, '2024-08-20 09:01:19', 1, '2024-08-20 09:01:19');
INSERT INTO `user_action` VALUES (1, 0, 13, '2024-08-20 19:36:41', 1, '2024-08-20 19:36:41');
INSERT INTO `user_action` VALUES (1, 1, 20, '2024-08-26 22:16:11', 1, '2024-08-26 22:16:11');
INSERT INTO `user_action` VALUES (1, 2, 20, '2024-08-26 22:16:13', 0, '2024-08-26 22:16:13');
INSERT INTO `user_action` VALUES (1, 1, 23, '2024-08-27 10:37:21', 0, '2024-08-27 10:37:21');
INSERT INTO `user_action` VALUES (12, 1, 22, '2024-08-27 10:51:08', 0, '2024-08-27 10:51:08');
INSERT INTO `user_action` VALUES (1, 0, 13, '2024-09-01 20:42:58', 0, '2024-09-01 20:42:58');

-- ----------------------------
-- Table structure for wuser
-- ----------------------------
DROP TABLE IF EXISTS `wuser`;
CREATE TABLE `wuser`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `wx_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信id',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `wx_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信昵称',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wuser
-- ----------------------------
INSERT INTO `wuser` VALUES (1, 'oXh4A6wO60N1DnYalVKpGgMTpLuA', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q3auHgzwzM6qfzDSRtycXNxNNQibQZdRiaNKFKEHicaWMTDcD58A53nG3WVY0bRue2rRZ0hEibVdKicj6rguiag24exQ/132', '神经蛙', 0, '2024-08-09 14:11:23', '2024-08-09 14:11:23');
INSERT INTO `wuser` VALUES (11, 'oXh4A6zLVdzWiDVKPAWN_-YqEnUA', 'https://thirdwx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEIewoAbBia2AD2zNIX03fM9THLdcNIk8hmNmZ1TFvtwPdfbMhJcSic04Mbex9bI97j9zEF2YoJFfEKggW8mXWJPQWG5vVM4BOtqTgs73byHjDJA/132', '存款为 林先生', 0, '2024-08-27 10:36:53', '2024-08-27 10:36:53');
INSERT INTO `wuser` VALUES (12, 'oXh4A67ztKGUhZMXFYdA3q-tbLg4', 'https://thirdwx.qlogo.cn/mmopen/vi_32/D6st0BNTjibZzVFIVOvt4HqavymmPxtBQmoDiaJZ61DsomqeiaxJVHIDh0sCDAvl2tmm7aZbiaAjeAFrszcTtN1cBw/132', '旺仔牛奶糖🍬', 0, '2024-08-27 10:42:18', '2024-08-27 10:42:18');
INSERT INTO `wuser` VALUES (13, 'oXh4A61oeK4HecwJ8HC5Tb_YYFVI', 'https://thirdwx.qlogo.cn/mmopen/vi_32/PpXjMygdcWSqWZLt5LDyRC10GBnBxyBfwTvRx1vykMHicTU5SVrwR6couTiaRcAicOM9SeicgVT2BGLgmIgc3nt45Q/132', '会动🏀 刘教练', 0, '2024-08-28 21:57:03', '2024-08-28 21:57:03');

SET FOREIGN_KEY_CHECKS = 1;

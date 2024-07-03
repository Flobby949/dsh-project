/*
 Navicat Premium Data Transfer

 Source Server         : AliECS
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 106.15.104.19:8000
 Source Schema         : dsh

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 02/07/2024 17:35:39
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, 'Integer', 'update', 1, 1, 'String', 'String', 0.10, 1, 'String', '2024-06-26 08:00:00', 'String', 'String', 'https://element-plus.org/zh-CN/component/dialog.html', 'http://106.15.104.19:9000/dsh/3e5a6ddf23324abdbbbe3d4e7324b52c.jpg', 0, '2024-06-17 13:34:31', '2024-06-29 08:31:49');
INSERT INTO `book` VALUES (2, 'String', 'String', 2, 1, 'String', 'String', 1.30, 2, 'String', '2024-06-17 08:00:00', 'String', 'String', 'https://element-plus.org/zh-CN/component/image.html#image-api', 'http://106.15.104.19:9000/dsh/a7b86910699442f79429a8cae6dac380.jpg', 0, '2024-06-17 15:04:32', '2024-06-29 08:31:49');
INSERT INTO `book` VALUES (3, '新增书籍', '1111', 1, 1, '译者', '作者,作者,作者,作者,作者作者，作者，作者作者，作者', 0.80, 4, '精装', '2024-06-28 08:00:00', '作者简介', '书本简介', 'https://www.baidu.com/s?ie=UTF-8&wd=forum', 'http://106.15.104.19:9000/dsh/9604fd1f12814a15a5ec18eed2679770.jpg', 0, '2024-06-20 10:55:08', '2024-06-29 08:31:49');

-- ----------------------------
-- Table structure for book_exchange
-- ----------------------------
DROP TABLE IF EXISTS `book_exchange`;
CREATE TABLE `book_exchange`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NULL DEFAULT NULL COMMENT '书本id',
  `user_id` int NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL COMMENT '0-未使用，1-已使用',
  `exchange_time` timestamp(0) NULL DEFAULT NULL COMMENT '兑换时间',
  `delete_flag` tinyint NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_exchange
-- ----------------------------
INSERT INTO `book_exchange` VALUES (1, 3, NULL, 1, NULL, 0, '2024-06-30 16:38:07', '2024-06-30 16:38:07');
INSERT INTO `book_exchange` VALUES (2, 3, NULL, 0, NULL, 0, '2024-06-30 16:38:07', '2024-06-30 16:38:07');
INSERT INTO `book_exchange` VALUES (3, 3, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (4, 3, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (5, 3, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (6, 3, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (7, 3, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (8, 3, NULL, 0, NULL, 0, '2024-06-30 16:48:41', '2024-06-30 16:48:41');
INSERT INTO `book_exchange` VALUES (9, 3, NULL, 0, NULL, 0, '2024-06-30 16:49:00', '2024-06-30 16:49:00');
INSERT INTO `book_exchange` VALUES (10, 3, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (11, 3, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (12, 3, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (13, 3, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (14, 3, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (15, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:06', '2024-06-30 17:03:06');
INSERT INTO `book_exchange` VALUES (16, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:06', '2024-06-30 17:03:06');
INSERT INTO `book_exchange` VALUES (17, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:06', '2024-06-30 17:03:06');
INSERT INTO `book_exchange` VALUES (18, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (19, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (20, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (21, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (22, 2, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (23, 1, NULL, 0, NULL, 0, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (24, 1, NULL, 0, NULL, 0, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (25, 1, NULL, 0, NULL, 0, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (26, 1, NULL, 0, NULL, 0, '2024-06-30 17:03:27', '2024-06-30 17:03:27');

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
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_resource
-- ----------------------------
INSERT INTO `book_resource` VALUES (1, '修改资源', '777', NULL, 2, 1, 0, '2024-06-18 14:41:03', '2024-06-18 14:52:09');
INSERT INTO `book_resource` VALUES (2, '新增', '111', NULL, 2, 1, 0, '2024-06-18 16:58:11', '2024-06-18 16:58:11');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '字符串', '字符串', 0, '2024-06-17 14:54:29', '2024-06-17 15:36:28');
INSERT INTO `category` VALUES (2, 'Integer', 'Integer', 0, '2024-06-17 14:54:43', '2024-06-17 14:54:43');
INSERT INTO `category` VALUES (3, 'Float', 'Float', 0, '2024-06-17 14:54:49', '2024-06-17 15:17:27');

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
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, NULL, 1, 0, NULL, '这是第一条评论', 0, '2024-07-02 16:11:15', '2024-07-02 16:11:15');
INSERT INTO `comment` VALUES (2, 1, NULL, 1, 0, NULL, '这是第二条评论', 0, '2024-07-02 16:11:27', '2024-07-02 16:11:27');
INSERT INTO `comment` VALUES (3, 1, '1', 1, 0, NULL, '这是第一条评论的第一条回复', 0, '2024-07-02 16:12:58', '2024-07-02 16:12:58');
INSERT INTO `comment` VALUES (4, 1, '3', 1, 0, NULL, '这是第一条评论第一条回复的回复', 0, '2024-07-02 16:13:23', '2024-07-02 16:13:23');
INSERT INTO `comment` VALUES (5, 1, '4', 1, 0, NULL, '这是第一条评论第一条回复的回复的回复', 0, '2024-07-02 16:37:57', '2024-07-02 16:37:57');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, '书多一点', NULL, 1, 0, '2024-06-19 10:12:22', '2024-06-19 10:12:25');
INSERT INTO `feedback` VALUES (2, '书不够多', NULL, 1, 0, '2024-06-19 10:45:58', '2024-06-19 10:46:01');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES (1, 1, '论坛', '课程链接', 1, 1.01, '作者简介', 'http://106.15.104.19:9000/dsh/f734978f5e8645e1b6555a9b3e217266.mp3', 'http://106.15.104.19:9000/dsh/b7d20d5d268b43629438d09b7a1a9851.jpg', 'http://106.15.104.19:9000/dsh/9db84c088d7a441cb1aee743c0d0358f.jpg', 0, '2024-06-20 02:18:19', '2024-06-20 16:09:42');
INSERT INTO `forum` VALUES (2, 1, '新的论坛', NULL, 3, NULL, NULL, NULL, NULL, NULL, 0, '2024-06-20 15:09:54', '2024-06-20 15:09:54');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, 1, 1, '公告', '公告内容', '2024-06-22 09:32:36', 1, 1, '2024-06-21 09:32:47', '2024-06-21 09:32:50');
INSERT INTO `notice` VALUES (2, 2, 1, '新的公告', '新的公告内容', '2024-06-21 10:41:43', 0, 1, '2024-06-21 10:37:59', '2024-06-21 10:37:59');
INSERT INTO `notice` VALUES (3, 1, 1, '标题', '内容', '2024-06-28 00:00:00', 1, 1, '2024-06-21 10:47:26', '2024-06-21 10:47:26');
INSERT INTO `notice` VALUES (4, 2, 1, 'hhh', 'hhhhh', '2024-06-28 00:00:00', 1, 1, '2024-06-21 10:51:43', '2024-06-21 10:51:43');
INSERT INTO `notice` VALUES (5, 2, 1, '555', '123132', '2024-06-23 00:00:00', 1, 1, '2024-06-21 10:53:46', '2024-06-21 10:53:46');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of publisher
-- ----------------------------
INSERT INTO `publisher` VALUES (1, '北京大学出版社', '北京大学出版社描述', 0, '2024-06-30 13:08:48', '2024-06-30 13:05:49');
INSERT INTO `publisher` VALUES (2, '清华大学出版社', '清华大学出版社', 0, '2024-06-30 14:39:38', '2024-06-30 14:39:38');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_manager
-- ----------------------------
INSERT INTO `sys_manager` VALUES (1, 'admin', '{bcrypt}$2a$10$mW/yJPHjyueQ1g26WNBz0uxVPa0GQdJO1fFZmqdkqgMTGnyszlXxu', 'https://cdn.maku.net/images/avatar.png', 1, 1, 0, '2023-05-18 18:18:55', '2024-02-28 09:27:51');
INSERT INTO `sys_manager` VALUES (2, 'user', '{bcrypt}$2a$10$IPBm/F3E7NUeX/I1xfr0iO5ZzghwCQp/kc4NDGmRf.rVYuApWWvzC', '', 0, 1, 1, '2024-03-08 12:23:28', '2024-03-13 10:52:38');
INSERT INTO `sys_manager` VALUES (3, '北京大学出版社管理员', '{bcrypt}$2a$10$qAxwKywaR28fubM84dfOKuOHiPGYCGRtVsA/Sfe2BUrFBp6m5aRiy', '', 0, 1, 0, '2024-06-30 14:35:55', '2024-06-30 15:31:27');
INSERT INTO `sys_manager` VALUES (4, '清华大学出版社管理员', '{bcrypt}$2a$10$it4Kw8uv0itJ91TQ8sxfv.Vf.hpaiCylD4zh.7eC72viypvRYkERm', '', 0, 1, 0, '2024-06-30 14:39:11', '2024-06-30 15:24:38');
INSERT INTO `sys_manager` VALUES (5, '北京出版社管理员', '{bcrypt}$2a$10$wjhWROdHrsz7AHruZ1n/a.YzopeUfg3lDU8FEGSbktaW/qZK1kRk.', '', 0, 1, 0, '2024-06-30 14:40:13', '2024-06-30 14:40:13');

-- ----------------------------
-- Table structure for sys_manager_publisher
-- ----------------------------
DROP TABLE IF EXISTS `sys_manager_publisher`;
CREATE TABLE `sys_manager_publisher`  (
  `manager_id` int NOT NULL,
  `publisher_id` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_manager_publisher
-- ----------------------------
INSERT INTO `sys_manager_publisher` VALUES (5, 1);
INSERT INTO `sys_manager_publisher` VALUES (5, 2);
INSERT INTO `sys_manager_publisher` VALUES (4, 2);
INSERT INTO `sys_manager_publisher` VALUES (3, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_manager_role
-- ----------------------------
INSERT INTO `sys_manager_role` VALUES (1, 1, 1, 0, '2024-02-28 10:17:32', '2024-02-28 10:17:32');
INSERT INTO `sys_manager_role` VALUES (2, 2, 2, 1, '2024-03-08 12:23:28', '2024-03-13 10:52:46');
INSERT INTO `sys_manager_role` VALUES (3, 2, 3, 0, '2024-06-30 14:35:55', '2024-06-30 14:35:55');
INSERT INTO `sys_manager_role` VALUES (4, 2, 4, 0, '2024-06-30 14:39:11', '2024-06-30 14:39:11');
INSERT INTO `sys_manager_role` VALUES (5, 2, 5, 0, '2024-06-30 14:40:13', '2024-06-30 14:40:13');

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
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_menu` VALUES (20, 1, 'Dict', '字典管理', '/system/dict', '/System/Dict/index', 'MENU', 'TAB', '', 'Memo', 'sys:dict:list', 1, 4, 0, '2024-02-27 08:16:57', '2024-06-17 02:32:30', 1);
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
INSERT INTO `sys_menu` VALUES (181, 154, 'forum', '书圈论坛', '/audit/forum', '/Audit/Forum', 'MENU', 'TAB', '', 'Medal', '', 0, 5, 0, '2024-06-19 14:35:22', '2024-06-19 15:00:49', 1);
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员', 0, '2024-02-28 10:18:26', '2024-06-30 13:20:36');
INSERT INTO `sys_role` VALUES (2, '出版社管理员', '出版社管理员', 0, '2024-06-30 13:15:58', '2024-06-30 22:21:45');
INSERT INTO `sys_role` VALUES (4, '普通用户', '普通用户', 0, '2024-06-30 13:17:08', '2024-06-30 13:17:08');

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
) ENGINE = InnoDB AUTO_INCREMENT = 163 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_action
-- ----------------------------
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-02 16:05:10', 1, '2024-07-02 16:05:10');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-02 16:29:39', 1, '2024-07-02 16:29:39');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-02 16:29:59', 1, '2024-07-02 16:29:59');
INSERT INTO `user_action` VALUES (1, 1, 1, '2024-07-02 16:30:05', 0, '2024-07-02 16:30:05');
INSERT INTO `user_action` VALUES (1, 1, 3, '2024-07-02 16:30:12', 0, '2024-07-02 16:30:12');
INSERT INTO `user_action` VALUES (1, 2, 3, '2024-07-02 16:32:26', 0, '2024-07-02 16:32:26');

-- ----------------------------
-- Table structure for wuser
-- ----------------------------
DROP TABLE IF EXISTS `wuser`;
CREATE TABLE `wuser`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `wx_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信id',
  `wx_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信昵称',
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wuser
-- ----------------------------
INSERT INTO `wuser` VALUES (1, 'wxwxwx', 'nickname', 0, '2024-06-19 02:11:51', '2024-06-19 02:11:51');

SET FOREIGN_KEY_CHECKS = 1;

/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : dsh

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 31/07/2024 10:42:12
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `user_flag` varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `book_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `verify_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL COMMENT '0-未使用，1-已使用',
  `exchange_time` timestamp(0) NULL DEFAULT NULL COMMENT '兑换时间',
  `delete_flag` tinyint NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_exchange
-- ----------------------------
INSERT INTO `book_exchange` VALUES (1, 3, NULL, NULL, NULL, 1, NULL, 0, '2024-06-30 16:38:07', '2024-06-30 16:38:07');
INSERT INTO `book_exchange` VALUES (2, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:38:07', '2024-06-30 16:38:07');
INSERT INTO `book_exchange` VALUES (3, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (4, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (5, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (6, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (7, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:48:08', '2024-06-30 16:48:08');
INSERT INTO `book_exchange` VALUES (8, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:48:41', '2024-06-30 16:48:41');
INSERT INTO `book_exchange` VALUES (9, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 16:49:00', '2024-06-30 16:49:00');
INSERT INTO `book_exchange` VALUES (10, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (11, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (12, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (13, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (14, 3, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:02:44', '2024-06-30 17:02:44');
INSERT INTO `book_exchange` VALUES (15, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:06', '2024-06-30 17:03:06');
INSERT INTO `book_exchange` VALUES (16, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:06', '2024-06-30 17:03:06');
INSERT INTO `book_exchange` VALUES (17, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:06', '2024-06-30 17:03:06');
INSERT INTO `book_exchange` VALUES (18, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (19, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (20, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (21, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (22, 2, NULL, NULL, NULL, 0, NULL, 0, '2024-06-30 17:03:07', '2024-06-30 17:03:07');
INSERT INTO `book_exchange` VALUES (23, 1, NULL, NULL, NULL, 0, NULL, 1, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (24, 1, NULL, NULL, NULL, 0, NULL, 1, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (25, 1, NULL, NULL, NULL, 0, NULL, 1, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (26, 1, NULL, NULL, NULL, 0, NULL, 1, '2024-06-30 17:03:27', '2024-06-30 17:03:27');
INSERT INTO `book_exchange` VALUES (27, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY2D0F.q', '253UGMRTPD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (28, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY322E.q', '253UGMRUEZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (29, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY4A90.q', '253UGMRV2X', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (30, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY50ED.q', '253UGMRWNT', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (31, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY6388.q', '253UGMRXWB', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (32, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY738F.q', '253UGMRYA7', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (33, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY8C86.q', '253UGMRZ2S', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (34, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VY9D8F.q', '253UGMS2HK', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (35, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYAEEC.q', '253UGMS3GF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (36, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYBCB3.q', '253UGMS4UP', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (37, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYCD9D.q', '253UGMS5V4', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (38, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYDD74.q', '253UGMS6XU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (39, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYE806.q', '253UGMS7E4', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (40, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYF8DF.q', '253UGMS8Y3', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (41, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYGDFD.q', '253UGMS9ZM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (42, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYH35E.q', '253UGMSAXM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (43, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYI02F.q', '253UGMSBTG', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (44, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYJ6E1.q', '253UGMSCQS', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (45, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYK2E2.q', '253UGMSDNZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (46, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYLF5F.q', '253UGMSEVA', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (47, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYMB37.q', '253UGMSFNR', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (48, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYN39E.q', '253UGMSGR5', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (49, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYOFCA.q', '253UGMSHZB', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (50, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYP79B.q', '253UGMSJCQ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (51, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYQ37E.q', '253UGMSKA3', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (52, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYRD52.q', '253UGMSM5B', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (53, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYS7D7.q', '253UGMSNZN', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (54, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYT5C7.q', '253UGMSPY6', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (55, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYUC20.q', '253UGMSQUF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (56, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYV4C6.q', '253UGMSR6P', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (57, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYW385.q', '253UGMSSS9', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (58, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYX5EC.q', '253UGMSTR8', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (59, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYYEC0.q', '253UGMSUTD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (60, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VYZ999.q', '253UGMSV4D', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (61, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ05B3.q', '253UGMSWE2', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (62, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ16E7.q', '253UGMSX8E', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (63, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ29E7.q', '253UGMSYVN', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (64, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ3C41.q', '253UGMSZ3G', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (65, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ42C5.q', '253UGMT222', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (66, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ5787.q', '253UGMT39F', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (67, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ65C0.q', '253UGMT436', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (68, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ7C3A.q', '253UGMT5RT', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (69, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ8508.q', '253UGMT6VD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (70, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZ9E50.q', '253UGMT7BM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (71, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZA7D1.q', '253UGMT8ST', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (72, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZB443.q', '253UGMT9V6', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (73, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZCDC9.q', '253UGMTA44', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (74, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZD327.q', '253UGMTBTP', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (75, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZEFD3.q', '253UGMTCHD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (76, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZF302.q', '253UGMTDF8', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (77, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZGE0B.q', '253UGMTEJG', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (78, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZH120.q', '253UGMTFSC', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (79, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZI942.q', '253UGMTGU2', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (80, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZJF80.q', '253UGMTH6P', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (81, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZK810.q', '253UGMTJHM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (82, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZLCEF.q', '253UGMTK2J', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (83, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZMEE6.q', '253UGMTMXX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (84, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZN00E.q', '253UGMTNVF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (85, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZOF6A.q', '253UGMTPAT', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (86, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZP9A0.q', '253UGMTQVC', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (87, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZQ0D6.q', '253UGMTRQN', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (88, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZRFAE.q', '253UGMTSHM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (89, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZSEA5.q', '253UGMTTS2', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (90, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZT549.q', '253UGMTU5K', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (91, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZU3FD.q', '253UGMTV7A', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (92, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZVD67.q', '253UGMTW52', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (93, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZW226.q', '253UGMTXXX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (94, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZXDCF.q', '253UGMTYWU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (95, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZYC5B.q', '253UGMTZUA', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (96, 1, NULL, 'https://mp.bookln.cn/b/dj/12116VZZF62.q', '253UGMU2CN', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (97, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W00657.q', '253UGMU33U', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (98, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W01BD6.q', '253UGMU4G3', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (99, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0254A.q', '253UGMU5U6', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (100, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0393D.q', '253UGMU6JU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (101, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W048DF.q', '253UGMU7WZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (102, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W05A5C.q', '253UGMU8YH', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (103, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W06A6A.q', '253UGMU9DD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (104, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W07AE7.q', '253UGMUAJY', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (105, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W08636.q', '253UGMUB62', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (106, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W09471.q', '253UGMUCSJ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (107, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0A8A7.q', '253UGMUD9A', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (108, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0B711.q', '253UGMUESE', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (109, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0C6CE.q', '253UGMUFNY', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (110, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0DB94.q', '253UGMUGSZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (111, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0E061.q', '253UGMUHZF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (112, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0F0FC.q', '253UGMUJN7', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (113, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0G89F.q', '253UGMUKUE', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (114, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0HFF8.q', '253UGMUMAX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (115, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0I465.q', '253UGMUN4A', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (116, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0JBFE.q', '253UGMUPNW', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (117, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0K180.q', '253UGMUQS7', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (118, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0LA91.q', '253UGMURFY', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (119, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0M52F.q', '253UGMUSVM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (120, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0N25E.q', '253UGMUT2U', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (121, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0O28D.q', '253UGMUUZA', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (122, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0PDC9.q', '253UGMUVND', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (123, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0Q5A3.q', '253UGMUWS9', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (124, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0RB7A.q', '253UGMUXKY', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (125, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0S145.q', '253UGMUYZ7', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (126, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0TA39.q', '253UGMUZ7U', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (127, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0U5C6.q', '253UGMV222', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (128, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0V9A7.q', '253UGMV3PP', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (129, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0W212.q', '253UGMV4PG', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (130, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0X428.q', '253UGMV5MY', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (131, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0YA33.q', '253UGMV6SX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (132, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W0ZC32.q', '253UGMV72E', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (133, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W105E1.q', '253UGMV8MK', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (134, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W11D23.q', '253UGMV97F', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (135, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W123CD.q', '253UGMVAEP', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (136, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W135B3.q', '253UGMVBME', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (137, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W148FF.q', '253UGMVCRE', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (138, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W15AA3.q', '253UGMVDTB', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (139, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W165E6.q', '253UGMVE7B', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (140, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W17EC1.q', '253UGMVF2K', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (141, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1811D.q', '253UGMVGCK', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (142, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W19B15.q', '253UGMVH7K', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (143, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1A047.q', '253UGMVJCF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (144, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1B189.q', '253UGMVKY3', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (145, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1CE1F.q', '253UGMVMEU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (146, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1D136.q', '253UGMVNX9', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (147, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1E49C.q', '253UGMVPR9', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (148, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1F816.q', '253UGMVQ8Z', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (149, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1GD5E.q', '253UGMVRAH', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (150, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1H466.q', '253UGMVSA4', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (151, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1I050.q', '253UGMVTJU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (152, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1JFCC.q', '253UGMVU39', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (153, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1KFA9.q', '253UGMVVB3', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (154, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1L734.q', '253UGMVWPU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (155, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1MC01.q', '253UGMVXKZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (156, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1N3F7.q', '253UGMVY2V', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (157, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1O5FC.q', '253UGMVZCP', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (158, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1P38A.q', '253UGMW2E8', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (159, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1Q3F2.q', '253UGMW35F', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (160, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1REDB.q', '253UGMW4WZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (161, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1S2AE.q', '253UGMW5TD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (162, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1T669.q', '253UGMW6R5', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (163, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1U0FD.q', '253UGMW79N', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (164, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1VC2D.q', '253UGMW8RA', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (165, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1WC12.q', '253UGMW9RN', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (166, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1X863.q', '253UGMWAH7', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (167, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1Y365.q', '253UGMWBFM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (168, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W1Z7BF.q', '253UGMWCBC', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (169, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W20FF9.q', '253UGMWDQU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (170, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2108C.q', '253UGMWE8D', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (171, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W22C32.q', '253UGMWF9K', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (172, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W23444.q', '253UGMWG3Y', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (173, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W246C4.q', '253UGMWHQW', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (174, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2515C.q', '253UGMWJGM', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (175, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W26E5B.q', '253UGMWKDE', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (176, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W27A26.q', '253UGMWMW8', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (177, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2878D.q', '253UGMWN49', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (178, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W29CAF.q', '253UGMWPCD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (179, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2AD32.q', '253UGMWQSD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (180, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2B6E6.q', '253UGMWRF2', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (181, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2CD15.q', '253UGMWSXT', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (182, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2DD05.q', '253UGMWTTY', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (183, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2E076.q', '253UGMWUFT', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (184, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2F531.q', '253UGMWVMG', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (185, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2GB21.q', '253UGMWW8J', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (186, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2H2D8.q', '253UGMWX37', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (187, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2I401.q', '253UGMWYVJ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (188, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2J236.q', '253UGMWZGV', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (189, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2KBB8.q', '253UGMX2FS', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (190, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2L805.q', '253UGMX36J', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (191, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2M371.q', '253UGMX4PX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (192, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2NC3B.q', '253UGMX58E', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (193, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2O8D2.q', '253UGMX6GD', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (194, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2PD3E.q', '253UGMX78J', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (195, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2Q84C.q', '253UGMX8NX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (196, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2R690.q', '253UGMX992', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (197, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2S9FB.q', '253UGMXAEW', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (198, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2T203.q', '253UGMXBRV', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (199, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2UD84.q', '253UGMXCBA', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (200, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2V290.q', '253UGMXDK4', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (201, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2W2C5.q', '253UGMXE3T', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (202, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2XD6C.q', '253UGMXF6B', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (203, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2YEA4.q', '253UGMXGHF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (204, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W2ZA68.q', '253UGMXH6V', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (205, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W30E65.q', '253UGMXJH4', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (206, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W31E4F.q', '253UGMXKBZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (207, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W323A1.q', '253UGMXMCS', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (208, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W33696.q', '253UGMXNSU', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (209, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3461E.q', '253UGMXPUG', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (210, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W35A51.q', '253UGMXQNW', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (211, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W367C3.q', '253UGMXRK7', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (212, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W37912.q', '253UGMXSQX', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (213, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W38EC0.q', '253UGMXTJ9', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (214, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W39830.q', '253UGMXUNP', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (215, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3A7AC.q', '253UGMXVYV', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (216, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3BAF3.q', '253UGMXW7K', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (217, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3CCB0.q', '253UGMXXE8', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (218, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3D488.q', '253UGMXYN4', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (219, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3E474.q', '253UGMXZBR', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (220, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3FCF7.q', '253UGMY2FF', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (221, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3G179.q', '253UGMY382', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (222, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3H02F.q', '253UGMY4NZ', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (223, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3I092.q', '253UGMY52G', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (224, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3JA7D.q', '253UGMY65K', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (225, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3K422.q', '253UGMY7VT', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');
INSERT INTO `book_exchange` VALUES (226, 1, NULL, 'https://mp.bookln.cn/b/dj/12116W3L778.q', '253UGMY8R8', NULL, NULL, 0, '2024-07-30 16:50:26', '2024-07-30 16:50:26');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
  `file_type` int NULL DEFAULT NULL COMMENT '0-图片，1-语音',
  `files` json NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `delete_flag` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除(0-未删除，1-删除)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, NULL, 1, 0, NULL, NULL, '这是第一条评论', 0, '2024-07-02 16:11:15', '2024-07-02 16:11:15');
INSERT INTO `comment` VALUES (2, 1, NULL, 1, 0, NULL, NULL, '这是第二条评论', 0, '2024-07-02 16:11:27', '2024-07-02 16:11:27');
INSERT INTO `comment` VALUES (3, 1, '1', 1, 0, NULL, NULL, '这是第一条评论的第一条回复', 0, '2024-07-02 16:12:58', '2024-07-02 16:12:58');
INSERT INTO `comment` VALUES (4, 1, '3', 1, 0, NULL, NULL, '这是第一条评论第一条回复的回复', 0, '2024-07-02 16:13:23', '2024-07-02 16:13:23');
INSERT INTO `comment` VALUES (5, 1, '4', 1, 0, NULL, NULL, '这是第一条评论第一条回复的回复的回复', 0, '2024-07-02 16:37:57', '2024-07-02 16:37:57');
INSERT INTO `comment` VALUES (6, 1, NULL, 1, 0, NULL, NULL, '第三条评论', 0, '2024-07-03 07:41:04', '2024-07-03 07:41:04');
INSERT INTO `comment` VALUES (7, 1, NULL, 1, 0, NULL, NULL, '第四条评论', 0, '2024-07-03 07:41:21', '2024-07-03 07:41:21');
INSERT INTO `comment` VALUES (8, 1, '1', 1, 1, NULL, NULL, 'hei', 0, '2024-07-04 18:00:57', '2024-07-04 18:00:57');
INSERT INTO `comment` VALUES (9, 1, '1', 1, 1, NULL, NULL, 'ballo', 0, '2024-07-04 18:02:29', '2024-07-04 18:02:29');
INSERT INTO `comment` VALUES (10, 1, '9', 1, 1, NULL, NULL, 'okok', 0, '2024-07-04 18:03:09', '2024-07-04 18:03:09');
INSERT INTO `comment` VALUES (11, 1, '4', 1, 1, NULL, NULL, '嵌套回复', 0, '2024-07-04 18:04:38', '2024-07-04 18:04:38');
INSERT INTO `comment` VALUES (12, 1, '7', 1, 1, NULL, NULL, '评论一下', 0, '2024-07-04 18:05:35', '2024-07-04 18:05:35');
INSERT INTO `comment` VALUES (13, 1, NULL, 1, 1, NULL, NULL, NULL, 0, '2024-07-04 22:43:52', '2024-07-04 22:43:52');
INSERT INTO `comment` VALUES (14, 1, NULL, 1, 1, NULL, NULL, '评论评论', 0, '2024-07-04 22:45:37', '2024-07-04 22:45:38');
INSERT INTO `comment` VALUES (15, 1, NULL, 1, 1, NULL, NULL, 'gogogo', 0, '2024-07-04 22:46:30', '2024-07-04 22:46:30');
INSERT INTO `comment` VALUES (16, 1, NULL, 1, 1, 0, '[\"http://106.15.104.19:9000/dsh/ca9f18f3d99e4352877d71b33a807217.jpg\", \"http://106.15.104.19:9000/dsh/0d542ba91e624902931c614495635f5d.jpg\"]', '图片评论', 0, '2024-07-05 10:39:41', '2024-07-05 10:39:41');
INSERT INTO `comment` VALUES (17, 1, '1', 2, 1, NULL, NULL, '哈哈哈', 0, '2024-07-07 16:49:30', '2024-07-07 16:49:30');
INSERT INTO `comment` VALUES (18, 1, NULL, 3, 1, 0, '[]', '第四条评论', 0, '2024-07-07 17:21:37', '2024-07-07 17:21:37');
INSERT INTO `comment` VALUES (19, 1, NULL, 3, 1, 0, '[]', '阿巴巴', 0, '2024-07-07 17:22:10', '2024-07-07 17:22:10');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES (1, 1, '论坛', '课程链接', 1, 1.01, '作者简介', 'http://106.15.104.19:9000/dsh/f734978f5e8645e1b6555a9b3e217266.mp3', 'http://106.15.104.19:9000/dsh/b7d20d5d268b43629438d09b7a1a9851.jpg', 'http://106.15.104.19:9000/dsh/9db84c088d7a441cb1aee743c0d0358f.jpg', 0, '2024-06-20 02:18:19', '2024-06-20 16:09:42');
INSERT INTO `forum` VALUES (2, 1, '新的论坛', NULL, 3, NULL, NULL, NULL, NULL, NULL, 0, '2024-06-20 15:09:54', '2024-06-20 15:09:54');
INSERT INTO `forum` VALUES (3, 1, '论坛一', NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:45:50', '2024-07-04 09:45:50');
INSERT INTO `forum` VALUES (4, 1, '论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二论坛二', NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:46:03', '2024-07-04 09:46:03');
INSERT INTO `forum` VALUES (5, 1, '论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三论坛三', NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:46:16', '2024-07-04 09:46:16');
INSERT INTO `forum` VALUES (6, 1, '论坛四', NULL, 3, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:46:27', '2024-07-04 09:46:27');
INSERT INTO `forum` VALUES (7, 1, '论坛五', NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:46:36', '2024-07-04 09:46:36');
INSERT INTO `forum` VALUES (8, 1, '论坛六', NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:46:47', '2024-07-04 09:46:47');
INSERT INTO `forum` VALUES (9, 1, '论坛七', NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:47:00', '2024-07-04 09:47:00');
INSERT INTO `forum` VALUES (10, 1, '伦塔吧', NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, '2024-07-04 09:47:17', '2024-07-04 09:47:17');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户管理' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色关系' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色管理' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_action
-- ----------------------------
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-02 16:05:10', 1, '2024-07-02 16:05:10');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-02 16:29:39', 1, '2024-07-02 16:29:39');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-02 16:29:59', 1, '2024-07-02 16:29:59');
INSERT INTO `user_action` VALUES (1, 1, 1, '2024-07-02 16:30:05', 1, '2024-07-02 16:30:05');
INSERT INTO `user_action` VALUES (1, 1, 3, '2024-07-02 16:30:12', 0, '2024-07-02 16:30:12');
INSERT INTO `user_action` VALUES (1, 2, 7, '2024-07-02 16:32:26', 0, '2024-07-02 16:32:26');
INSERT INTO `user_action` VALUES (1, 1, 2, '2024-07-03 17:25:04', 1, '2024-07-03 17:25:04');
INSERT INTO `user_action` VALUES (1, 1, 1, '2024-07-03 17:27:31', 1, '2024-07-03 17:27:31');
INSERT INTO `user_action` VALUES (1, 2, 2, '2024-07-03 17:27:32', 1, '2024-07-03 17:27:32');
INSERT INTO `user_action` VALUES (1, 2, 2, '2024-07-03 17:27:57', 1, '2024-07-03 17:27:57');
INSERT INTO `user_action` VALUES (1, 2, 1, '2024-07-03 17:27:58', 1, '2024-07-03 17:27:58');
INSERT INTO `user_action` VALUES (1, 2, 6, '2024-07-03 17:28:10', 1, '2024-07-03 17:28:10');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:41:14', 1, '2024-07-03 17:41:14');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:41:46', 1, '2024-07-03 17:41:46');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:41:50', 1, '2024-07-03 17:41:50');
INSERT INTO `user_action` VALUES (1, 2, 1, '2024-07-03 17:42:49', 1, '2024-07-03 17:42:49');
INSERT INTO `user_action` VALUES (1, 2, 1, '2024-07-03 17:43:25', 1, '2024-07-03 17:43:25');
INSERT INTO `user_action` VALUES (1, 2, 1, '2024-07-03 17:43:49', 1, '2024-07-03 17:43:49');
INSERT INTO `user_action` VALUES (1, 2, 2, '2024-07-03 17:45:21', 1, '2024-07-03 17:45:21');
INSERT INTO `user_action` VALUES (1, 2, 6, '2024-07-03 17:45:21', 0, '2024-07-03 17:45:21');
INSERT INTO `user_action` VALUES (1, 1, 6, '2024-07-03 17:45:22', 1, '2024-07-03 17:45:22');
INSERT INTO `user_action` VALUES (1, 2, 1, '2024-07-03 17:45:23', 1, '2024-07-03 17:45:23');
INSERT INTO `user_action` VALUES (1, 1, 2, '2024-07-03 17:45:25', 0, '2024-07-03 17:45:25');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:45:49', 1, '2024-07-03 17:45:49');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:46:40', 1, '2024-07-03 17:46:40');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:47:46', 1, '2024-07-03 17:47:46');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:47:48', 1, '2024-07-03 17:47:48');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-03 17:48:41', 1, '2024-07-03 17:48:41');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-04 15:00:18', 1, '2024-07-04 15:00:18');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-04 15:00:47', 1, '2024-07-04 15:00:47');
INSERT INTO `user_action` VALUES (1, 2, 5, '2024-07-04 16:20:01', 1, '2024-07-04 16:20:01');
INSERT INTO `user_action` VALUES (1, 1, 4, '2024-07-04 16:20:04', 0, '2024-07-04 16:20:04');
INSERT INTO `user_action` VALUES (1, 1, 11, '2024-07-04 18:05:00', 0, '2024-07-04 18:05:00');
INSERT INTO `user_action` VALUES (1, 2, 1, '2024-07-04 22:14:14', 1, '2024-07-04 22:14:14');
INSERT INTO `user_action` VALUES (1, 0, 1, '2024-07-04 22:46:40', 0, '2024-07-04 22:46:40');
INSERT INTO `user_action` VALUES (2, 0, 1, '2024-07-07 16:49:23', 0, '2024-07-07 16:49:23');
INSERT INTO `user_action` VALUES (2, 1, 1, '2024-07-07 16:49:26', 0, '2024-07-07 16:49:26');
INSERT INTO `user_action` VALUES (2, 2, 3, '2024-07-12 16:58:45', 0, '2024-07-12 16:58:45');
INSERT INTO `user_action` VALUES (1, 0, 10, '2024-07-28 14:06:01', 1, '2024-07-28 14:06:01');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wuser
-- ----------------------------
INSERT INTO `wuser` VALUES (1, 'wxwxwx', 'https://pica.zhimg.com/v2-9ef139b3a1f11a59f6a768334b06a813_l.jpg?source=32738c0c', 'nickname', 0, '2024-06-19 02:11:51', '2024-07-03 07:36:01');
INSERT INTO `wuser` VALUES (2, 'ohi8-69oedLZ1YPywFitl2uX7YLw', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKYqaSBaoxlXLP9OwB0bNvpVX3drRjHiav5jDJvzVwt817fTBc4QIsvITqsedADTZgFdLW6M4tYYhg/132', 'FlobbYð', 0, '2024-07-07 16:05:15', '2024-07-07 16:05:15');
INSERT INTO `wuser` VALUES (3, 'ohi8-65EgQzgeKn-OzFWOI5Fq1Zc', 'https://thirdwx.qlogo.cn/mmopen/vi_32/0MBuP1Zkbt6v4YI5AibzMprTzD1doUUyWthJbJOicnYqkcEJ9PpAP82HGn0U63Yy3VbwjY7XLZ5nY6dlswt1M1UggmttM1Gas4NNTb0l5R7Lc/132', 'æ¥æ ä¸', 1, '2024-07-07 17:21:22', '2024-07-08 01:51:49');
INSERT INTO `wuser` VALUES (7, 'ohi8-65EgQzgeKn-OzFWOI5Fq1Zc', 'https://thirdwx.qlogo.cn/mmopen/vi_32/0MBuP1Zkbt6v4YI5AibzMprTzD1doUUyWthJbJOicnYqkcEJ9PpAP82HGn0U63Yy3VbwjY7XLZ5nY6dlswt1M1UggmttM1Gas4NNTb0l5R7Lc/132', 'æ¥æ ä¸', 1, '2024-07-08 12:11:42', '2024-07-08 04:13:40');
INSERT INTO `wuser` VALUES (9, 'ohi8-65EgQzgeKn-OzFWOI5Fq1Zc', 'https://thirdwx.qlogo.cn/mmopen/vi_32/0MBuP1Zkbt6v4YI5AibzMprTzD1doUUyWthJbJOicnYqkcEJ9PpAP82HGn0U63Yy3VbwjY7XLZ5nY6dlswt1M1UggmttM1Gas4NNTb0l5R7Lc/132', 'æ¥æ ä¸', 1, '2024-07-08 12:23:03', '2024-07-09 14:58:49');
INSERT INTO `wuser` VALUES (10, 'ohi8-65EgQzgeKn-OzFWOI5Fq1Zc', 'https://thirdwx.qlogo.cn/mmopen/vi_32/0MBuP1Zkbt6v4YI5AibzMprTzD1doUUyWthJbJOicnYqkcEJ9PpAP82HGn0U63Yy3VbwjY7XLZ5nY6dlswt1M1UggmttM1Gas4NNTb0l5R7Lc/132', '来树下', 0, '2024-07-09 23:04:45', '2024-07-09 23:04:45');

SET FOREIGN_KEY_CHECKS = 1;

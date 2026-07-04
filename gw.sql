/*
 Navicat Premium Data Transfer

 Source Server         : 121.40.51.170gw
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : 121.40.51.170:3306
 Source Schema         : gw

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 03/10/2022 12:17:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for jz_admin
-- ----------------------------
DROP TABLE IF EXISTS `jz_admin`;
CREATE TABLE `jz_admin`  (
  `a_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆账号',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `group_id` tinyint(3) UNSIGNED NOT NULL COMMENT '组ID',
  `ctime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `utime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  `last_login_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `last_login_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最后登录IP',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态 0正常 9删除',
  `error_num` int(10) NOT NULL DEFAULT 0 COMMENT '错误次数',
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_admin
-- ----------------------------
INSERT INTO `jz_admin` VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 0, 1602162890, 1602162890, 1647676408, '123.52.18.91', 0, 0);

-- ----------------------------
-- Table structure for jz_admin_action
-- ----------------------------
DROP TABLE IF EXISTS `jz_admin_action`;
CREATE TABLE `jz_admin_action`  (
  `action_id` smallint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `model` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `method` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法',
  `action_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  PRIMARY KEY (`action_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_admin_action
-- ----------------------------
INSERT INTO `jz_admin_action` VALUES (14, 'User', 'userList', '会员列表');
INSERT INTO `jz_admin_action` VALUES (13, 'User', 'editUser', '编辑会员信息');
INSERT INTO `jz_admin_action` VALUES (12, 'User', 'deleteUser', '删除会员');
INSERT INTO `jz_admin_action` VALUES (11, 'Money', 'moneyList', '财务列表');
INSERT INTO `jz_admin_action` VALUES (10, 'Money', 'sureMoney', '确认提现');
INSERT INTO `jz_admin_action` VALUES (9, 'Order', 'orderList', '订单列表');
INSERT INTO `jz_admin_action` VALUES (8, 'Order', 'addOrder', '添加订单');
INSERT INTO `jz_admin_action` VALUES (7, 'Order', 'sureOrder', '确认订单');
INSERT INTO `jz_admin_action` VALUES (6, 'Order', 'deleteOrder', '删除订单');
INSERT INTO `jz_admin_action` VALUES (5, 'Admin', 'adminList', '管理员列表');
INSERT INTO `jz_admin_action` VALUES (4, 'Admin', 'addAdmin', '添加管理员');
INSERT INTO `jz_admin_action` VALUES (3, 'Admin', 'editAdmin', '修改管理员信息');
INSERT INTO `jz_admin_action` VALUES (2, 'Admin', 'deleteAdmin', '删除管理员');
INSERT INTO `jz_admin_action` VALUES (1, 'Admin', 'editPass', '修改密码');

-- ----------------------------
-- Table structure for jz_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `jz_admin_group`;
CREATE TABLE `jz_admin_group`  (
  `group_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `group_name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组名',
  `permission` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限 序列化',
  `ctime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `utime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态 0正常 9删除',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_admin_group
-- ----------------------------
INSERT INTO `jz_admin_group` VALUES (10, '1', 'a:4:{i:0;s:1:\"9\";i:1;s:1:\"8\";i:2;s:1:\"7\";i:3;s:1:\"6\";}', 1602162890, 0, 0);
INSERT INTO `jz_admin_group` VALUES (9, '2', 'a:4:{i:0;s:1:\"9\";i:1;s:1:\"8\";i:2;s:1:\"7\";i:3;s:1:\"6\";}', 1602162890, 1602162890, 9);
INSERT INTO `jz_admin_group` VALUES (11, '3', 'a:3:{i:0;s:2:\"11\";i:1;s:2:\"10\";i:2;s:1:\"9\";}', 1602162890, 0, 0);

-- ----------------------------
-- Table structure for jz_assets
-- ----------------------------
DROP TABLE IF EXISTS `jz_assets`;
CREATE TABLE `jz_assets`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `file_path` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `size` int(11) NULL DEFAULT 0,
  `sort` int(2) NULL DEFAULT 0,
  `format_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `relateable_id` int(11) NULL DEFAULT NULL,
  `relateable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_assets
-- ----------------------------
INSERT INTO `jz_assets` VALUES (46, 'logo.png', 'Post/2022-03/', '622b1bb4844b1.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (47, 'logo.png', 'Post/2022-03/', '622b1f40503b4.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (48, 'logo.png', 'Post/2022-03/', '622b1f64aeb97.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (49, '微信图片_20211015093939.jpg', 'Post/2022-03/', '622b1fc493ba5.jpg', 134177, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (50, 'logo.png', 'Post/2022-03/', '622b204121b52.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (51, 'logo.png', 'Post/2022-03/', '622b205cc0945.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (52, 'logo.png', 'Post/2022-03/', '622b20b8a8301.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (53, 'logo.png', 'Post/2022-03/', '622b20e64876c.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (54, 'logo.png', 'Post/2022-03/', '622b212d6d7f0.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (55, 'logo.png', 'Post/2022-03/', '622b21433d9bc.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (56, 'logo.png', 'Post/2022-03/', '622b215a7ff6e.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (57, 'logo.png', 'Post/2022-03/', '622b2167d0731.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (58, '微信图片_20211015093939.jpg', 'Post/2022-03/', '622b2200e10e9.jpg', 134177, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (59, 'logo.png', 'Post/2022-03/', '622d4142bc22b.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (60, '69d2f0bf20100053fc939a70fa1be30b.png', 'Post/2022-03/', '622d433473939.png', 4110951, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (61, '0c5f3525-f0e0-4e28-9aff-7bb352e42506.jpg', 'Post/2022-03/', '622d439c63b5a.jpg', 152467, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (62, 'logo.png', 'Post/2022-03/', '622d5a1036840.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (63, 'logo.png', 'Post/2022-03/', '622d5a92e7f49.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (64, 'logo.png', 'Post/2022-03/', '622d5b2087de9.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (65, 'logo.png', 'Post/2022-03/', '622d5ba86b858.png', 7942, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (66, '01外立面.jpg', 'Post/2022-03/', '622ea9d23fd46.jpg', 1489356, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (67, '01外立面.jpg', 'Post/2022-03/', '622eaa216df64.jpg', 1489356, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (68, '02角度一.jpg', 'Post/2022-03/', '622eaa24a0f9a.jpg', 7800052, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (69, '03角度二.jpg', 'Post/2022-03/', '622eaa288266a.jpg', 8146418, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (70, '094081b9ad735f113db3d334b2d321f.jpg', 'Post/2022-03/', '622eaa5037efd.jpg', 7540350, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (71, '4691fc7bc15e925720c772c0363c2b5.jpg', 'Post/2022-03/', '622eaa803c6ca.jpg', 4986248, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (72, '6154b2dba739a10a4209d703ae8b394.jpg', 'Post/2022-03/', '622eaa8474fdc.jpg', 12125563, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (73, 'd75a439f9e70ca2a1b0a24d4d7afa24.jpg', 'Post/2022-03/', '622eaa889d55e.jpg', 11804400, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (74, 'dbdf0a6f2d6e7f640b05c0f3bf80129.jpg', 'Post/2022-03/', '622eaa8cc2a66.jpg', 7405184, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (75, 'e55e7ded9cf699c306c4901361da851.jpg', 'Post/2022-03/', '622eaa91587ca.jpg', 11043678, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (76, '外立面0209a.jpg', 'Post/2022-03/', '622eaa95135c8.jpg', 1628675, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (77, '角度二.jpg', 'Post/2022-03/', '622eaaaec0e19.jpg', 6384026, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (78, '角度三.jpg', 'Post/2022-03/', '622eaab2c101e.jpg', 6001247, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (79, '角度四.jpg', 'Post/2022-03/', '622eaab6585ea.jpg', 6626113, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (80, '角度一.jpg', 'Post/2022-03/', '622eaab9ae543.jpg', 5949971, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (81, '外立面.jpg', 'Post/2022-03/', '622eaac468e29.jpg', 2207191, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (82, '角度1.jpg', 'Post/2022-03/', '622eaaf71db95.jpg', 8145876, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (83, '角度2.jpg', 'Post/2022-03/', '622eaafb8e3ee.jpg', 8390755, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (84, '角度3.jpg', 'Post/2022-03/', '622eab00d0724.jpg', 4332079, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (85, '角度4a.jpg', 'Post/2022-03/', '622eab04904de.jpg', 3947983, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (86, '角度1.jpg', 'Post/2022-03/', '622eab2d311da.jpg', 8145876, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (87, '角度1.jpg', 'Post/2022-03/', '622eab6627632.jpg', 8145876, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (88, '角度2.jpg', 'Post/2022-03/', '622eab6a27f14.jpg', 8390755, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (89, '角度3.jpg', 'Post/2022-03/', '622eab6de9a24.jpg', 4332079, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (90, '角度4a.jpg', 'Post/2022-03/', '622eab7176d64.jpg', 3947983, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (91, '微信图片_20190319143422.jpg', 'Post/2022-03/', '622eac5fb004e.jpg', 4208820, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (92, '微信图片_20190319143441.jpg', 'Post/2022-03/', '622eac684d099.jpg', 4247421, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (93, '微信图片_20190319143445.jpg', 'Post/2022-03/', '622eac6e9eac7.jpg', 2995537, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (94, '微信图片_20190319143449.jpg', 'Post/2022-03/', '622eac7243531.jpg', 4974414, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (95, '微信图片_20190319143453.jpg', 'Post/2022-03/', '622eac759bb1b.jpg', 3924724, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (96, '门头.jpg', 'Post/2022-03/', '622eac94aa8cc.jpg', 5438946, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (97, '01.jpg', 'Post/2022-03/', '622eac98aebb7.jpg', 2721017, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (98, '02.jpg', 'Post/2022-03/', '622eac9c28f6d.jpg', 2785108, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (99, '03.jpg', 'Post/2022-03/', '622eac9fa9392.jpg', 2834366, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (100, '9b02dd018e73e7221d498f47cf56ec5.jpg', 'Post/2022-03/', '622eacb475cbf.jpg', 290308, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (101, '大堂1.jpg', 'Post/2022-03/', '622eacfa5abfb.jpg', 9999870, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (102, '宴会厅7.1.jpg', 'Post/2022-03/', '622ead0170a8b.jpg', 3279423, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (103, '5.1.jpg', 'Post/2022-03/', '622ead0857f29.jpg', 4326312, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (104, '包房.jpg', 'Post/2022-03/', '622ead0cc170a.jpg', 2747717, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (105, '主卧.jpg', 'Post/2022-03/', '622eadf46c2d7.jpg', 2901496, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (106, '主卫.jpg', 'Post/2022-03/', '622eadf97186c.jpg', 2157587, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (107, '客厅.jpg', 'Post/2022-03/', '622eae00d2a05.jpg', 3102635, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (108, '餐厅.jpg', 'Post/2022-03/', '622eae061cc01.jpg', 2944204, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (109, '书房.jpg', 'Post/2022-03/', '622eae0abd138.jpg', 1965253, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (110, '图片1.png', 'Post/2022-03/', '622eb91d959ac.png', 2711254, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (111, '图片4.png', 'Post/2022-03/', '622eb9210a4e6.png', 2236221, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (112, '微信图片_202101151608451.jpg', 'Post/2022-03/', '622eb967dc4b1.jpg', 35269, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (113, '微信图片_202101151608451.png', 'Post/2022-03/', '622eb96c6bfe4.png', 2412800, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (114, '微信图片_202101151608456.jpg', 'Post/2022-03/', '622eb9761b6eb.jpg', 2964723, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (115, '微信图片_202101151608455.jpg', 'Post/2022-03/', '622eb97bbb27f.jpg', 2950491, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (116, '微信图片_202101151608452.png', 'Post/2022-03/', '622eb981188d8.png', 3035454, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (117, '2019-07-30 164314.jpg', 'Post/2022-03/', '622eb9b2678f8.jpg', 2836320, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (118, '2019-07-30 171957.jpg', 'Post/2022-03/', '622eb9b829b91.jpg', 1621814, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (119, '2019-07-30 165609.jpg', 'Post/2022-03/', '622eb9c40ce46.jpg', 3180483, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (120, '2019-07-30 170539.jpg', 'Post/2022-03/', '622eb9c86ee92.jpg', 2610032, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (121, '2019-07-30 165651_20190802_134312.jpg', 'Post/2022-03/', '622eb9cd8dc6d.jpg', 3383930, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (122, '763f8486a80d94567fb728591e02d8f.jpg', 'Post/2022-03/', '622eba01a0d8e.jpg', 5375055, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (123, '6861519167dd5d4320df7d28e59dcde.jpg', 'Post/2022-03/', '622eba054db1d.jpg', 1926632, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (124, '0aeb5555d1de31f51d241038dd65759.jpg', 'Post/2022-03/', '622eba381c541.jpg', 4628122, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (125, '26aa5eb003d8f4da4cd4e26b0424df4.jpg', 'Post/2022-03/', '622eba456dd42.jpg', 4179438, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (126, '78fa0234978c1675b34d862780f2c01.jpg', 'Post/2022-03/', '622eba509ebc0.jpg', 2565949, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (127, '70113f60ed9e66c2ed3a042679c7f5d.jpg', 'Post/2022-03/', '622eba54cbe24.jpg', 2144722, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (128, '2019-05-06 151721.jpg', 'Post/2022-03/', '622eba7a2acdb.jpg', 5400213, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (129, '2019-05-06 152102.jpg', 'Post/2022-03/', '622eba7fcec00.jpg', 5364571, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (130, '2019-05-06 153815(1).jpg', 'Post/2022-03/', '622eba8937699.jpg', 3224615, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (131, '2019-05-06 155227.jpg', 'Post/2022-03/', '622eba8d90622.jpg', 4800673, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (132, '2019-05-06 161400(1).jpg', 'Post/2022-03/', '622eba934e1c9.jpg', 2619518, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (133, '创客3.jpg', 'Post/2022-03/', '622eef2f91341.jpg', 1772845, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (134, '创客1 (1).jpg', 'Post/2022-03/', '622eef337982a.jpg', 2239814, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (135, '创客2.jpg', 'Post/2022-03/', '622eef36c778f.jpg', 3433904, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (136, '8d938aaca605260f83c1a2cef5522ac.jpg', 'Post/2022-03/', '622eef51b6171.jpg', 46838, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (137, '3173346a34c24d185815851345b41e4.jpg', 'Post/2022-03/', '622eef570437f.jpg', 49278, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (138, 'de72d18fdc74cc7af971659644f38d9.jpg', 'Post/2022-03/', '622eef5aa119e.jpg', 7702540, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (139, 'f1234c7c0bd2f49c6842738c1d4d8d4.jpg', 'Post/2022-03/', '622eef5de48ab.jpg', 53417, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (140, '微信图片_20190302134620.jpg', 'Post/2022-03/', '622eefa28d19f.jpg', 233591, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (141, '微信图片_20190302134632.jpg', 'Post/2022-03/', '622eefa609191.jpg', 219792, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (142, '微信图片_20190302134605.jpg', 'Post/2022-03/', '622eefad9051f.jpg', 2374512, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (143, '微信图片_20190302134635.jpg', 'Post/2022-03/', '622eefb1c8380.jpg', 201035, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (144, '微信图片_20190302134641.jpg', 'Post/2022-03/', '622eefbe0881d.jpg', 184402, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (145, '1客厅.jpg', 'Post/2022-03/', '622eefda6fbac.jpg', 2333792, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (146, '2餐厅.jpg', 'Post/2022-03/', '622eefdfe190d.jpg', 2041538, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (147, '6主卧2.jpg', 'Post/2022-03/', '622eefe6b7280.jpg', 2442748, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (148, '8吧台区.jpg', 'Post/2022-03/', '622eefeb2f3c9.jpg', 2209949, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (149, '9瑜伽室.jpg', 'Post/2022-03/', '622eefeed2dda.jpg', 1238662, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (150, '别墅餐厅.jpg', 'Post/2022-03/', '622ef00c8111c.jpg', 4065012, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (151, '别墅客厅a.jpg', 'Post/2022-03/', '622ef01131204.jpg', 7034359, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (152, '茶室a.jpg', 'Post/2022-03/', '622ef01451939.jpg', 5293778, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (153, '卧室2.jpg', 'Post/2022-03/', '622ef017f1e0e.jpg', 2230081, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (154, '01    一层客厅效果图.jpg', 'Post/2022-03/', '622ef0368567f.jpg', 6855155, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (155, '02 一层餐厅.jpg', 'Post/2022-03/', '622ef03f5a317.jpg', 6650842, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (156, '05   负一层影音室2.jpg', 'Post/2022-03/', '622ef04aa8d2a.jpg', 5506067, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (157, '07   三层女儿房.jpg', 'Post/2022-03/', '622ef04f45d4c.jpg', 6558094, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (158, '09   四层主卧.jpg', 'Post/2022-03/', '622ef0556057e.jpg', 6464379, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (159, 'ggg.jpg', 'Post/2022-03/', '622ef05c61a85.jpg', 6021953, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (160, '7c2c6d7d2f90cad89652157ebacad4eA.jpg', 'Post/2022-03/', '622ef080bb1a6.jpg', 7164627, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (161, '9b209f4c43d1aad9d3136884e69c12e.jpg', 'Post/2022-03/', '622ef08c2062a.jpg', 6534754, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (162, '75743ba7fa8101a590b9e077eb4f43e.jpg', 'Post/2022-03/', '622ef09626da8.jpg', 9408031, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (163, 'b9e2119e809c01eec55c38c4307133c.jpg', 'Post/2022-03/', '622ef09b3fd17.jpg', 9624586, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (164, 'b9e2119e809c01eec55c38c4307133c.jpg', 'Post/2022-03/', '622ef0a9e5e9a.jpg', 9624586, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (165, '微信图片_20190422185413.jpg', 'Post/2022-03/', '622ef0dcb510d.jpg', 2919994, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (166, '微信图片_20190422185452.jpg', 'Post/2022-03/', '622ef0e549942.jpg', 4060872, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (167, '微信图片_20190422185503.jpg', 'Post/2022-03/', '622ef0ef7410a.jpg', 2800533, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (168, '微信图片_20190422185508.jpg', 'Post/2022-03/', '622ef0f33326f.jpg', 2943767, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (169, '微信图片_20190422185706.jpg', 'Post/2022-03/', '622ef0f6d9834.jpg', 6283776, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (170, '外观_Camera0010000.jpg', 'Post/2022-03/', '622efdb16d96b.jpg', 2605651, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (171, '微信图片_20180420134837.jpg', 'Post/2022-03/', '622efdbac2e70.jpg', 5337614, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (172, '微信图片_20180420134851.jpg', 'Post/2022-03/', '622efdc11aeb8.jpg', 1456075, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (173, '微信图片_20180420134858.jpg', 'Post/2022-03/', '622efdc60a586.jpg', 2826273, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (174, '微信图片_20180920153706.jpg', 'Post/2022-03/', '622efdfbe36f1.jpg', 4485945, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (175, '微信图片_20180920153638.jpg', 'Post/2022-03/', '622efe0147b36.jpg', 7364919, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (176, '微信图片_20180920153646.jpg', 'Post/2022-03/', '622efe066120d.jpg', 7779147, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (177, '微信图片_20180920153613.jpg', 'Post/2022-03/', '622efe0aa5da0.jpg', 3472478, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (178, '微信图片_20180920153713.jpg', 'Post/2022-03/', '622efe0f0cfd1.jpg', 6690720, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (179, '走道1.jpg', 'Post/2022-03/', '622efe578f875.jpg', 1979919, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (180, '前厅.jpg', 'Post/2022-03/', '622efe6229400.jpg', 3116534, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (181, '洽谈室2.jpg', 'Post/2022-03/', '622efe67094d7.jpg', 4249552, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (182, '洽谈室1.jpg', 'Post/2022-03/', '622efe6cbf493.jpg', 3560752, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (183, '茶水间.jpg', 'Post/2022-03/', '622efe736bbfa.jpg', 1167819, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (184, '01外观ss.jpg', 'Post/2022-03/', '622eff9eb7161.jpg', 3324023, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (185, '02一层楼梯口.jpg', 'Post/2022-03/', '622effa49fd97.jpg', 5468677, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (186, '大厅20180204a.jpg', 'Post/2022-03/', '622effac38a03.jpg', 1705050, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (187, '08会议室改.jpg', 'Post/2022-03/', '622effaf8d1d2.jpg', 3814293, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (188, '04面诊室3.jpg', 'Post/2022-03/', '622effb542714.jpg', 6788180, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (189, '报告0609-0111.jpg', 'Post/2022-03/', '622effd069999.jpg', 11400742, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (190, '报告06012b.jpg', 'Post/2022-03/', '622effd47dfff.jpg', 11382259, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (191, '外立面0407d.jpg', 'Post/2022-03/', '622f001ae1b50.jpg', 17691038, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (192, '微信图片_20180506111337.jpg', 'Post/2022-03/', '622f0020d60ae.jpg', 5323960, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (193, '微信图片_20180506111355.jpg', 'Post/2022-03/', '622f002489d8a.jpg', 5674527, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (194, '微信图片_20180621144428.jpg', 'Post/2022-03/', '622f00281db0e.jpg', 7338227, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (195, '走廊.jpg', 'Post/2022-03/', '622f002eed0d5.jpg', 3946752, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (196, '01外立面.jpg', 'Post/2022-03/', '62306d4a036fd.jpg', 1489356, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (197, '02角度一.jpg', 'Post/2022-03/', '62306d5140cb9.jpg', 1940972, 0, 'image/jpeg', 0, 'Post');
INSERT INTO `jz_assets` VALUES (198, '微信截图_20220310154416.png', 'Post/2022-03/', '62313dc95636e.png', 92672, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (199, '微信截图_20220310154416.png', 'Post/2022-03/', '62313e6746943.png', 92672, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (200, '微信截图_20220310154416.png', 'Post/2022-03/', '62313e87e864f.png', 92672, 0, 'image/png', 0, 'Post');
INSERT INTO `jz_assets` VALUES (201, '微信截图_20220310154416.png', 'Post/2022-03/', '62313ecd3c06e.png', 92672, 0, 'image/png', 0, 'Post');

-- ----------------------------
-- Table structure for jz_category
-- ----------------------------
DROP TABLE IF EXISTS `jz_category`;
CREATE TABLE `jz_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `parentid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `order` int(11) NULL DEFAULT NULL COMMENT '排序',
  `ctime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_category
-- ----------------------------
INSERT INTO `jz_category` VALUES (1, '餐饮类', 0, 1, '2022-03-13 09:19:06');
INSERT INTO `jz_category` VALUES (2, '酒店类', 0, 2, '2022-03-13 09:19:36');
INSERT INTO `jz_category` VALUES (3, '地产类', 0, 3, '2022-03-13 09:58:45');
INSERT INTO `jz_category` VALUES (4, '办公类', 0, 4, '2022-03-13 09:59:02');
INSERT INTO `jz_category` VALUES (5, '别墅会所', 0, 5, '2022-03-13 09:59:20');
INSERT INTO `jz_category` VALUES (6, '商业零售类', 0, 6, '2022-03-13 09:59:35');
INSERT INTO `jz_category` VALUES (7, '医美类', 0, 7, '2022-03-13 09:59:50');
INSERT INTO `jz_category` VALUES (8, '市政类', 0, 8, '2022-03-13 10:00:05');
INSERT INTO `jz_category` VALUES (9, '软装陈设', 0, 9, '2022-03-14 10:28:17');

-- ----------------------------
-- Table structure for jz_order
-- ----------------------------
DROP TABLE IF EXISTS `jz_order`;
CREATE TABLE `jz_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `ctime` int(30) NOT NULL COMMENT '创建时间',
  `is_url` smallint(30) NOT NULL COMMENT '是否是网址: 0: 否, 1:是',
  `web_url` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网址地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_order
-- ----------------------------
INSERT INTO `jz_order` VALUES (1, '电子封条技术', '&lt;p&gt;电子封条技术&lt;/p&gt;', 1640670874, 0, '');
INSERT INTO `jz_order` VALUES (4, '三项大奖', '&lt;p&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;近日，&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;美國&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;LIT LIGHTING DESIGN AWARDS 202&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:Calibri;box-sizing: inherit;&quot;&gt;1&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;公佈了年度最終獲獎名單。&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:Calibri;box-sizing: inherit;&quot;&gt;CCD&lt;/span&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;燈光設計作品&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;“&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;西安融創&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;·&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;曲江印現代藝術中心&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;”&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;、&lt;/span&gt;“&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:Calibri;box-sizing: inherit;&quot;&gt;CCD 48F MIX MATCH&amp;nbsp;&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;灣區生活體驗館&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;”&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;及&lt;/span&gt;&lt;span style=&quot;font-family:Calibri;box-sizing: inherit;&quot;&gt;“&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;雲南彌勒藝術家會客廳&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;”&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;三&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;個&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;項目&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;最終順利入選，斬獲&lt;/span&gt;&lt;span style=&quot;font-family:Calibri;box-sizing: inherit;&quot;&gt;&amp;quot;Community&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;Building Lighting&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;、&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;Workplace Lighting&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;及&lt;/span&gt;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&amp;quot;Hotel and Restaurants&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;Lighting&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;三&lt;/span&gt;&lt;span style=&quot;box-sizing: inherit; margin: 0px; padding: 0px; color: rgb(161, 161, 161); font-family: &amp;quot;Microsoft YaHei!important&amp;quot;; font-size: 12px; letter-spacing: 1.05px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family:宋体;box-sizing: inherit;&quot;&gt;個類別的大獎。&lt;/span&gt;&lt;/span&gt;&lt;img src=&quot;/ueditor/php/upload/image/20220314/1647225040124936.png&quot; title=&quot;1647225040124936.png&quot; alt=&quot;3483eb5f-e8f2-4eff-87f0-29c1ca36dbdc.png&quot;/&gt;&lt;/p&gt;', 1647225111, 0, '');

-- ----------------------------
-- Table structure for jz_user
-- ----------------------------
DROP TABLE IF EXISTS `jz_user`;
CREATE TABLE `jz_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `categoryid` int(11) NULL DEFAULT NULL COMMENT '分类',
  `img_arr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案例图',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数1',
  `content` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数2',
  `ctime` int(30) NULL DEFAULT 0 COMMENT '申请时间',
  `status` int(5) NULL DEFAULT 1 COMMENT '审核状态: 1:审核中 2:审核通过 3:拒绝',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jz_user
-- ----------------------------
INSERT INTO `jz_user` VALUES (19, 1, ' Post/2022-03/622eaa216df64.jpg, Post/2022-03/622eaa24a0f9a.jpg, Post/2022-03/622eaa288266a.jpg', '百年粥道', '百年粥道', 1647225393, 1);
INSERT INTO `jz_user` VALUES (20, 1, ' Post/2022-03/622eaa5037efd.jpg', '谷雨春', '谷雨春', 1647225426, 1);
INSERT INTO `jz_user` VALUES (21, 1, ' Post/2022-03/622eaa803c6ca.jpg, Post/2022-03/622eaa8474fdc.jpg, Post/2022-03/622eaa889d55e.jpg, Post/2022-03/622eaa8cc2a66.jpg, Post/2022-03/622eaa91587ca.jpg, Post/2022-03/622eaa95135c8.jpg', '珑井苑', '珑井苑', 1647225494, 1);
INSERT INTO `jz_user` VALUES (22, 1, ' Post/2022-03/622eaaaec0e19.jpg, Post/2022-03/622eaab2c101e.jpg, Post/2022-03/622eaab6585ea.jpg, Post/2022-03/622eaab9ae543.jpg, Post/2022-03/622eaac468e29.jpg', '炉小哥烤肉', '炉小哥烤肉', 1647225542, 1);
INSERT INTO `jz_user` VALUES (24, 1, ' Post/2022-03/622eab6627632.jpg, Post/2022-03/622eab6a27f14.jpg, Post/2022-03/622eab6de9a24.jpg, Post/2022-03/622eab7176d64.jpg', '深圳湘见', '深圳湘见', 1647225715, 1);
INSERT INTO `jz_user` VALUES (25, 1, ' Post/2022-03/622eac5fb004e.jpg, Post/2022-03/622eac684d099.jpg, Post/2022-03/622eac6e9eac7.jpg, Post/2022-03/622eac7243531.jpg, Post/2022-03/622eac759bb1b.jpg', '石家庄万众会所', '石家庄万众会所', 1647225975, 1);
INSERT INTO `jz_user` VALUES (26, 1, ' Post/2022-03/622eac94aa8cc.jpg, Post/2022-03/622eac98aebb7.jpg, Post/2022-03/622eac9c28f6d.jpg, Post/2022-03/622eac9fa9392.jpg', '彦小馆', '彦小馆', 1647226017, 1);
INSERT INTO `jz_user` VALUES (27, 1, ' Post/2022-03/622eacb475cbf.jpg', '中州潮鲜餐厅', '中州潮鲜餐厅', 1647226037, 1);
INSERT INTO `jz_user` VALUES (28, 2, ' Post/2022-03/622eacfa5abfb.jpg, Post/2022-03/622ead0170a8b.jpg, Post/2022-03/622ead0857f29.jpg, Post/2022-03/622ead0cc170a.jpg', '商丘酒店', '商丘酒店', 1647226126, 1);
INSERT INTO `jz_user` VALUES (29, 3, ' Post/2022-03/622eadf46c2d7.jpg, Post/2022-03/622eadf97186c.jpg, Post/2022-03/622eae00d2a05.jpg, Post/2022-03/622eae061cc01.jpg, Post/2022-03/622eae0abd138.jpg', '吉地样板房', '吉地样板房', 1647226380, 1);
INSERT INTO `jz_user` VALUES (30, 3, ' Post/2022-03/622eb91d959ac.jpg, Post/2022-03/622eb9210a4e6.jpg', '佳田新时代', '佳田新时代', 1647229234, 1);
INSERT INTO `jz_user` VALUES (31, 3, ' Post/2022-03/622eb967dc4b1.jpg, Post/2022-03/622eb96c6bfe4.jpg, Post/2022-03/622eb9761b6eb.jpg, Post/2022-03/622eb97bbb27f.jpg, Post/2022-03/622eb981188d8.jpg', '珑翠园样', '珑翠园样', 1647229314, 1);
INSERT INTO `jz_user` VALUES (32, 3, ' Post/2022-03/622eb9b2678f8.jpg, Post/2022-03/622eb9b829b91.jpg, Post/2022-03/622eb9c40ce46.jpg, Post/2022-03/622eb9c86ee92.jpg, Post/2022-03/622eb9cd8dc6d.jpg', '平顶山西湖岸', '平顶山西湖岸', 1647229391, 1);
INSERT INTO `jz_user` VALUES (33, 3, ' Post/2022-03/622eba01a0d8e.jpg, Post/2022-03/622eba054db1d.jpg', '原阳颐养乐福', '原阳颐养乐福', 1647229452, 1);
INSERT INTO `jz_user` VALUES (34, 3, ' Post/2022-03/622eba381c541.jpg, Post/2022-03/622eba456dd42.jpg, Post/2022-03/622eba509ebc0.jpg, Post/2022-03/622eba54cbe24.jpg', '鋆宸洲际广场营销中心', '鋆宸洲际广场营销中心', 1647229526, 1);
INSERT INTO `jz_user` VALUES (35, 3, ' Post/2022-03/622eba7a2acdb.jpg, Post/2022-03/622eba7fcec00.jpg, Post/2022-03/622eba8937699.jpg, Post/2022-03/622eba8d90622.jpg, Post/2022-03/622eba934e1c9.jpg', '驻马店尚书苑', '驻马店尚书苑', 1647229589, 1);
INSERT INTO `jz_user` VALUES (36, 4, ' Post/2022-03/622eef2f91341.jpg, Post/2022-03/622eef337982a.jpg, Post/2022-03/622eef36c778f.jpg', '国家电网', '国家电网', 1647243064, 1);
INSERT INTO `jz_user` VALUES (37, 4, ' Post/2022-03/622eef51b6171.jpg, Post/2022-03/622eef570437f.jpg, Post/2022-03/622eef5aa119e.jpg, Post/2022-03/622eef5de48ab.jpg', '龙子湖办公室', '龙子湖办公室', 1647243105, 1);
INSERT INTO `jz_user` VALUES (38, 5, ' Post/2022-03/622eefa28d19f.jpg, Post/2022-03/622eefa609191.jpg, Post/2022-03/622eefad9051f.jpg, Post/2022-03/622eefb1c8380.jpg, Post/2022-03/622eefbe0881d.jpg', '金雨玫瑰会所', '金雨玫瑰会所', 1647243199, 1);
INSERT INTO `jz_user` VALUES (39, 9, ' Post/2022-03/622eefda6fbac.jpg, Post/2022-03/622eefdfe190d.jpg, Post/2022-03/622eefe6b7280.jpg, Post/2022-03/622eefeb2f3c9.jpg, Post/2022-03/622eefeed2dda.jpg', '许昌别墅', '许昌别墅', 1647243249, 1);
INSERT INTO `jz_user` VALUES (40, 5, ' Post/2022-03/622ef00c8111c.jpg, Post/2022-03/622ef01131204.jpg, Post/2022-03/622ef01451939.jpg, Post/2022-03/622ef017f1e0e.jpg', '鄢陵莱茵河畔', '鄢陵莱茵河畔', 1647243289, 1);
INSERT INTO `jz_user` VALUES (41, 5, ' Post/2022-03/622ef0368567f.jpg, Post/2022-03/622ef03f5a317.jpg, Post/2022-03/622ef04aa8d2a.jpg, Post/2022-03/622ef04f45d4c.jpg, Post/2022-03/622ef0556057e.jpg, Post/2022-03/622ef05c61a85.jpg', '迎宾花园三号院别墅', '迎宾花园三号院别墅', 1647243357, 1);
INSERT INTO `jz_user` VALUES (42, 5, ' Post/2022-03/622ef080bb1a6.jpg, Post/2022-03/622ef08c2062a.jpg, Post/2022-03/622ef09626da8.jpg, Post/2022-03/622ef09b3fd17.jpg, Post/2022-03/622ef0a9e5e9a.jpg', '正弘领', '正弘领', 1647243439, 1);
INSERT INTO `jz_user` VALUES (43, 6, ' Post/2022-03/622ef0dcb510d.jpg, Post/2022-03/622ef0e549942.jpg, Post/2022-03/622ef0ef7410a.jpg, Post/2022-03/622ef0f33326f.jpg, Post/2022-03/622ef0f6d9834.jpg', '金雨时代广场', '金雨时代广场', 1647243511, 1);
INSERT INTO `jz_user` VALUES (44, 6, ' Post/2022-03/622efdb16d96b.jpg, Post/2022-03/622efdbac2e70.jpg, Post/2022-03/622efdc11aeb8.jpg, Post/2022-03/622efdc60a586.jpg', '酒便利', '酒便利', 1647246791, 1);
INSERT INTO `jz_user` VALUES (45, 6, ' Post/2022-03/622efdfbe36f1.jpg, Post/2022-03/622efe0147b36.jpg, Post/2022-03/622efe066120d.jpg, Post/2022-03/622efe0aa5da0.jpg, Post/2022-03/622efe0f0cfd1.jpg', '唯爱摄影', '唯爱摄影', 1647246864, 1);
INSERT INTO `jz_user` VALUES (46, 7, ' Post/2022-03/622efe578f875.jpg, Post/2022-03/622efe6229400.jpg, Post/2022-03/622efe67094d7.jpg, Post/2022-03/622efe6cbf493.jpg, Post/2022-03/622efe736bbfa.jpg', '深圳希瑞尔美容院', '深圳希瑞尔美容院', 1647246965, 1);
INSERT INTO `jz_user` VALUES (47, 7, ' Post/2022-03/622eff9eb7161.jpg, Post/2022-03/622effa49fd97.jpg, Post/2022-03/622effac38a03.jpg, Post/2022-03/622effaf8d1d2.jpg, Post/2022-03/622effb542714.jpg', '西安智美好医', '西安智美好医', 1647247287, 1);
INSERT INTO `jz_user` VALUES (48, 8, ' Post/2022-03/622effd069999.jpg, Post/2022-03/622effd47dfff.jpg', '黄淮学院报告厅', '黄淮学院报告厅', 1647247318, 1);
INSERT INTO `jz_user` VALUES (49, 8, ' Post/2022-03/622f001ae1b50.jpg, Post/2022-03/622f0020d60ae.jpg, Post/2022-03/622f002489d8a.jpg, Post/2022-03/622f00281db0e.jpg, Post/2022-03/622f002eed0d5.jpg', '鄢陵文化广场剧院', '鄢陵文化广场剧院', 1647247408, 1);

SET FOREIGN_KEY_CHECKS = 1;

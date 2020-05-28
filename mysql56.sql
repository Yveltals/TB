/*
 Navicat Premium Data Transfer

 Source Server         : LINK01
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : 127.0.0.1:3306
 Source Schema         : mysql56

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 27/05/2020 13:50:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `announcement_id` int NOT NULL AUTO_INCREMENT COMMENT '公告唯一id',
  `announcement_title` varchar(255) NOT NULL COMMENT '公告标题',
  `announcement_body` text NOT NULL COMMENT '公告内容',
  `announcement_top` int NOT NULL COMMENT '是否置顶0 置顶 1未置顶',
  `announcement_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of announcement
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `blog_id` int NOT NULL AUTO_INCREMENT COMMENT '唯一博文id--主键',
  `blog_title` varchar(255) NOT NULL COMMENT '博文标题',
  `blog_body` text NOT NULL COMMENT '博文内容',
  `blog_discussCount` int NOT NULL COMMENT '博文评论数',
  `blog_blogViews` int NOT NULL COMMENT '博文浏览数',
  `blog_time` datetime NOT NULL COMMENT '博文发布时间',
  `blog_state` int NOT NULL COMMENT '博文状态--0 删除 1正常',
  `user_id` int NOT NULL COMMENT '用户id',
  PRIMARY KEY (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog
-- ----------------------------
BEGIN;
INSERT INTO `blog` VALUES (126, 'Idea快捷键', '\n### **1. Editing(编辑)**\n\n| **快捷键**                 | **介绍**                                                     |\n| -------------------------- | ------------------------------------------------------------ |\n| **Ctrl +Space**            | **基本代码补全，输入字母按后列出匹配的词组**                 |\n| **Ctrl+Shift+Space**       | **智能代码补全，列出与预期类型一致的方法或变量**             |\n| **Ctrl+Alt+Space**         | **补全类名**                                                 |\n| **Ctrl+Shift+Enter**       | **补全语句**                                                 |\n| **Ctrl+P**                 | **显示方法参数**                                             |\n| **Ctrl+Q**                 | **显示注释文档**                                             |\n| **Shift+F1**               | **显示外部文档**                                             |\n| **Ctrl+mouse over code**   | **显示描述信息**                                             |\n| **Ctrl+F1**                | **显示提示、警告、错误等信息**                               |\n| **Alt+Insert**             | **生成代码，生成 Getter、Setter、构造器等**                  |\n| **Ctrl+O**                 | **重写父类方法**                                             |\n| **Ctrl+I**                 | **实现接口方法**                                             |\n| **Ctrl+Alt+T**             | **使用(if..else, try..catch, for, synchronized 等)包围选中语句** |\n| **Ctrl+/**                 | **使用“//”注释或取消注释**                                   |\n| **Ctrl+Shift+/**           | **使用“/\\** \\**/”注释或取消注释**                            |\n| **Ctrl+W**                 | **选择代码块，连续按会增加选择外层的代码块**                 |\n| **Ctrl+Shift+W**           | **与“Ctrl+W”相反，减少选择代码块**                           |\n| **Alt+Q**                  | **显示类描述信息**                                           |\n| **Alt+Enter**              | **显示快速修复列表**                                         |\n| **Ctrl+Alt+L**             | **格式化代码**                                               |\n| **Ctrl+Alt+O**             | **优化 Imports**                                             |\n| **Ctrl+Alt+I**             | **自动优化代码缩进**                                         |\n| **Tab/Shift+Tab**          | **缩进代码/取消缩进代码**                                    |\n| **Ctrl+X or Shift+Delete** | **剪切代码，未选择代码时剪切当前行**                         |\n| **Ctrl+C or Ctrl+Insert**  | **复制代码，未选择代码时复制当前行**                         |\n| **Ctrl+V or Shift+Insert** | **粘贴代码**                                                 |\n| **Ctrl+Shift+V**           | **粘贴最近复制的内容**                                       |\n| **Ctrl+D**                 | **重复代码，未选择代码时重复当前行**                         |\n| **Ctrl+Y**                 | **删除行，未选择时删除当前行**                               |\n| **Ctrl+Shift+J**           | **合并多行为一行**                                           |\n| **Ctrl+Enter**             | **分割一行为多行**                                           |\n| **Shift+Enter**            | **使光标所在位置的下一行为新行**                             |\n| **Ctrl+Shift+U**           | **对选中内容进行大小写切换**                                 |\n| **Ctrl+Shift+]/[**         | **选中到代码块的开始/结束**                                  |\n| **Ctrl+Delete**            | **删除从光标所在位置到单词结束位置的字符**                   |\n| **Ctrl+Backspace**         | **删除从单词起始位置到光标所在位置的字符**                   |\n| **Ctrl+NumPad+/-**         | **展开或收起代码块**                                         |\n| **Ctrl+Shift+NumPad+**     | **展开所有代码块**                                           |\n| **Ctrl+Shift+NumPad-**     | **收起所有代码块**                                           |\n| **Ctrl+F4**                | **关闭当前编辑页**                                           |\n| **CTRL+ALT+B**             | **查找接口的实现类**                                         |\n| **CTRL+ALT+SHIFT+C**       | **复制类的全类名**                                           |\n\n### **2. Search/Replace(查找/替换)**\n\n| **快捷键**       | **介绍**              |\n| ---------------- | --------------------- |\n| **Double Shift** | **Search everywhere** |\n| **Ctrl+F**       | **查找**              |\n| **F3**           | **查找下一个**        |\n| **Shift+F3**     | **查找上一个**        |\n| **Ctrl+R**       | **替换**              |\n| **Ctrl+Shift+F** | **目录内查找**        |\n| **Ctrl+Shift+R** | **目录内替换**        |\n| **Ctrl+Shift+S** | **语法模板搜索**      |\n| **Ctrl+Shift+M** | **语法模板替换**      |\n\n### **3. Usage Search(使用搜索)**\n\n| **快捷键**        | **介绍**                   |\n| ----------------- | -------------------------- |\n| **Alt+F7**        | **查找被使用处**           |\n| **Ctrl+F7**       | **查找当前文件中的使用处** |\n| **Ctrl+Shift+F7** | **高亮当前文件中的使用处** |\n| **Ctrl+Alt+F7**   | **列出使用者**             |\n\n### **4. Compile and Run(编译/运行)**\n\n| **快捷键**         | **介绍**                       |\n| ------------------ | ------------------------------ |\n| **Ctrl+F9**        | **Make 模块、项目**            |\n| **Ctrl+Shift+F9**  | **编译选中的文件、模块、项目** |\n| **Alt+Shift+F10**  | **选择配置后运行代码**         |\n| **Alt+Shift+F9**   | **选择配置后调试代码**         |\n| **Shift+F10**      | **运行代码**                   |\n| **Shift+F9**       | **调试代码**                   |\n| **Ctrl+F2**        | **停止调试**                   |\n| **Ctrl+Shift+F10** | **运行代码**                   |\n\n### **5. Debugging(调试)**\n\n| **快捷键**                | **介绍**                                 |\n| ------------------------- | ---------------------------------------- |\n| **F8**                    | **单步调试，不进入函数内部**             |\n| **F7**                    | **单步调试，进入函数内部**               |\n| **Shift+F7/Alt+Shift+F7** | **选择要进入的函数/强制进入函数**        |\n| **Shift+F8**              | **跳出函数**                             |\n| **Alt+F9**                | **运行到断点**                           |\n| **Alt+F8**                | **执行表达式查看结果**                   |\n| **F9**                    | **继续执行，进入下一个断点或执行完程序** |\n| **Ctrl+F8**               | **设置/取消当前行断点**                  |\n| **Ctrl+Shift+F8**         | **查看断点**                             |\n\n### **6. Navigation(导航)**\n\n| **快捷键**               | **介绍**                           |\n| ------------------------ | ---------------------------------- |\n| **Double Shift**         | **查找所有**                       |\n| **Ctrl+N**               | **查找类**                         |\n| **Ctrl+Shift+N**         | **查找文件**                       |\n| **Ctrl+Alt+Shift+N**     | **Go to symbol**                   |\n| **Alt+Right/Left**       | **左右切换 Tab**                   |\n| **F12**                  | **回到上一个打开的窗口**           |\n| **Esc**                  | **焦点回到编辑器**                 |\n| **Shift+Esc**            | **隐藏打开的视图**                 |\n| **Ctrl+Shift+F4**        | **关闭当前 Tab**                   |\n| **Ctrl+G**               | **跳到指定行**                     |\n| **Ctrl+E**               | **显示最近打开的文件**             |\n| **Ctrl+Alt+Left**        | **跳到光标的上一个位置**           |\n| **Ctrl+Alt+Right**       | **跳到光标的下一个位置**           |\n| **Ctrl+Shift+Backspace** | **跳到上一个编辑处**               |\n| **Alt+F1**               | **选择当前文件显示在不同的视图中** |\n| **Ctrl+B or Ctrl+Click** | **跳到类声明处**                   |\n| **Ctrl+Alt+B**           | **跳到实现类/方法**                |\n| **Ctrl+Shift+I**         | **显示类/变量/方法定义**           |\n| **Ctrl+Shift+B**         | **跳到类型定义处**                 |\n| **Ctrl+U**               | **跳到父类/方法**                  |\n| **Alt+Up**               | **光标移动到上一个方法**           |\n| **Alt+Down**             | **光标移动到下一个方法**           |\n| **Ctrl+]**               | **光标移动到代码块的起始位置**     |\n| **Ctrl+]**               | **光标移动到代码块的结束位置**     |\n| **Ctrl+F12**             | **显示文件结构**                   |\n| **Ctrl+H**               | **显示类层级**                     |\n| **Ctrl+Shift+H**         | **显示方法层级**                   |\n| **Ctrl+Alt+H**           | **显示类/方法调用层级**            |\n| **F2**                   | **光标移动到下一个错误**           |\n| **Shift+F2**             | **标移动到上一个错误**             |\n| **F4**                   | **编辑源码，光标移到编辑器内**     |\n| **Ctrl+Enter**           | **查看源码，光标没移到编辑器内**   |\n| **Alt+Home**             | **显示导航面包屑**                 |\n| **F11**                  | **当前行设置书签**                 |\n| **Shift+F11**            | **显示所有书签**                   |\n| **Ctrl+F11**             | **设置书签号[0-9]**                |\n| **Ctrl+[0-9]**           | **跳到书签号[0-9]所在位置**        |\n\n### **7. Refactoring(重构)**\n\n| **快捷键**     | **介绍**                         |\n| -------------- | -------------------------------- |\n| **F5**         | **复制类**                       |\n| **F6**         | **移动类**                       |\n| **Alt+Delete** | **安全删除，删除前会提示调用处** |\n| **Shift+F6**   | **重命名**                       |\n| **Ctrl+F6**    | **重构方法参数、Exception 等**   |\n| **Ctrl+Alt+N** | **合并多行为一行**               |\n| **Ctrl+Alt+M** | **提取为新方法**                 |\n| **Ctrl+Alt+V** | **提取为新变量**                 |\n| **Ctrl+Alt+F** | **提取为对象新属性**             |\n| **Ctrl+Alt+C** | **提取为新静态常量**             |\n| **Ctrl+Alt+P** | **提取参数**                     |\n\n### **8. VCS/Local History(版本控制/本地历史)**\n\n| **快捷键**           | **介绍**               |\n| -------------------- | ---------------------- |\n| **Ctrl+K**           | **提交改动到 VCS**     |\n| **Ctrl+T**           | **从 VCS 上更新**      |\n| **Alt+Shift+C**      | **查看最近的改动记录** |\n| **Alt+BackQuote(`)** | **显示 VCS 操作列表**  |\n\n### **9. Live Templates(动态模板)**\n\n| **快捷键**     | **介绍**                               |\n| -------------- | -------------------------------------- |\n| **Ctrl+Alt+J** | **使用 Live Template 包围选中代码**    |\n| **Ctrl+J**     | **快速插入 Live Template**             |\n| **iter**       | **快速生成 for…in 语句**               |\n| **inst**       | **快速生成”if instanceof ”语句**       |\n| **itco**       | **快速生成 iterator 的 for 循环**      |\n| **itit**       | **快速生成 iterator 的 while 循环**    |\n| **itli**       | **快速生成 list 的 for(i)循环**        |\n| **psf**        | **快速生成“public static final” 语句** |\n| **thr**        | **快速生成“throw new” 语句**           |\n\n### **10. General(代码生成)**\n\n| **快捷键**             | **介绍**                                                   |\n| ---------------------- | ---------------------------------------------------------- |\n| **Alt+0**              | **聚焦到 Messages 窗口**                                   |\n| **Alt+1**              | **聚焦到 Project 窗口**                                    |\n| **Alt+2**              | **聚焦到 Favorite 窗口**                                   |\n| **Alt+3**              | **聚焦到 Find 窗口**                                       |\n| **Alt+4**              | **聚焦到 Run 窗口**                                        |\n| **Alt+5**              | **聚焦到 Debug 窗口**                                      |\n| **Alt+6**              | **聚焦到 TODO 窗口**                                       |\n| **Alt+7**              | **聚焦到 Structure 窗口**                                  |\n| **Alt+8**              | **聚焦到 Hierarchy 窗口**                                  |\n| **Alt+9**              | **聚焦到 Change 窗口**                                     |\n| **Ctrl+S**             | **保存文件**                                               |\n| **Ctrl+Alt+Y**         | **与本地文件同步**                                         |\n| **Ctrl+Shift+F12**     | **切换最大化编辑**                                         |\n| **Alt+Shift+F**        | **添加到收藏夹**                                           |\n| **Alt+Shift+I**        | **检查当前文件，包括 Javadoc 问题、可能存在的 bug 等**     |\n| **Ctrl+BackQuote (`)** | **模式切换，包括文本外观、快捷键、编辑器外观、代码样式。** |\n| **Ctrl+Alt+S**         | **打开 settings 窗口**                                     |\n| **Ctrl+Alt+Shift+S**   | **打开项目结构对话框**                                     |\n| **Ctrl+Shift+A**       | **Find Action**                                            |\n| **Ctrl+Tab**           | **选项卡和工具窗口之间切换**                               |\n| **Alt+F12**            | **打开命令终端**                                           |\n| **Shift+Shift**        | **搜索文件**                                               |\n\n', 0, 1, '2020-05-01 02:07:52', 1, 1);
INSERT INTO `blog` VALUES (138, '图片', '## linux和win路径差异问题\n![alive.jpg](/img/fc8752c027714c4c942bea9557ee3ec8.jpg)', 3, 4, '2020-05-15 06:54:53', 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `blog_id` int NOT NULL COMMENT '博文id',
  `tag_id` int NOT NULL COMMENT '标签id',
  UNIQUE KEY `blog_id` (`blog_id`,`tag_id`),
  KEY `6` (`tag_id`),
  CONSTRAINT `5` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`),
  CONSTRAINT `6` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
BEGIN;
INSERT INTO `blog_tag` VALUES (126, 15);
INSERT INTO `blog_tag` VALUES (138, 15);
COMMIT;

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `code_id` varchar(32) NOT NULL COMMENT '邀请码主键',
  `code_state` int NOT NULL COMMENT '激活码状态0 未使用 1已使用 2 已删除',
  `user_id` int DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`code_id`),
  KEY `7` (`user_id`),
  CONSTRAINT `7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code
-- ----------------------------
BEGIN;
INSERT INTO `code` VALUES ('60E443A4B2E64F4183207304FA19790B', 1, 4);
COMMIT;

-- ----------------------------
-- Table structure for discuss
-- ----------------------------
DROP TABLE IF EXISTS `discuss`;
CREATE TABLE `discuss` (
  `discuss_id` int NOT NULL AUTO_INCREMENT COMMENT '评论唯一id',
  `discuss_body` varchar(255) NOT NULL COMMENT '评论内容',
  `discuss_time` datetime NOT NULL COMMENT '评论时间',
  `user_id` int NOT NULL COMMENT '用户id',
  `blog_id` int NOT NULL COMMENT '博文id',
  PRIMARY KEY (`discuss_id`),
  KEY `1` (`user_id`),
  CONSTRAINT `1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discuss
-- ----------------------------
BEGIN;
INSERT INTO `discuss` VALUES (2, '1234567', '2020-04-29 19:24:30', 1, 124);
INSERT INTO `discuss` VALUES (4, '7654321', '2020-05-01 14:46:28', 4, 124);
INSERT INTO `discuss` VALUES (5, '12345678', '2020-05-07 14:02:00', 1, 128);
INSERT INTO `discuss` VALUES (6, '222', '2020-05-07 14:12:13', 1, 128);
INSERT INTO `discuss` VALUES (7, '212121', '2020-05-19 05:14:45', 1, 138);
INSERT INTO `discuss` VALUES (8, '555', '2020-05-20 02:04:01', 1, 138);
COMMIT;

-- ----------------------------
-- Table structure for favor
-- ----------------------------
DROP TABLE IF EXISTS `favor`;
CREATE TABLE `favor` (
  `user_id` int NOT NULL,
  `blog_id` int NOT NULL,
  KEY `fk_user` (`user_id`),
  KEY `fk_blog` (`blog_id`),
  CONSTRAINT `fk_blog` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favor
-- ----------------------------
BEGIN;
INSERT INTO `favor` VALUES (4, 138);
INSERT INTO `favor` VALUES (1, 138);
COMMIT;

-- ----------------------------
-- Table structure for login
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `login_time` datetime NOT NULL COMMENT '最后登录时间',
  `login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `user_id` int NOT NULL COMMENT '用户id--主键',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of login
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `message_id` int NOT NULL AUTO_INCREMENT COMMENT '留言唯一id',
  `message_name` varchar(30) NOT NULL COMMENT '游客保存为ip地址，用户保存用户名',
  `message_body` varchar(255) NOT NULL COMMENT '留言主体',
  `message_time` datetime NOT NULL COMMENT '留言时间',
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` VALUES (40, 'admin', '123', '2020-05-15 06:57:52');
COMMIT;

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `reply_id` int NOT NULL AUTO_INCREMENT COMMENT '回复唯一id',
  `reply_body` varchar(255) NOT NULL COMMENT '回复内容',
  `reply_time` datetime NOT NULL COMMENT '回复时间',
  `user_id` int NOT NULL COMMENT '用户id',
  `discuss_id` int NOT NULL COMMENT '评论id',
  `reply_rootid` int DEFAULT NULL COMMENT '父回复节点id',
  PRIMARY KEY (`reply_id`),
  KEY `3` (`user_id`),
  KEY `4` (`discuss_id`),
  CONSTRAINT `3` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `4` FOREIGN KEY (`discuss_id`) REFERENCES `discuss` (`discuss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
BEGIN;
INSERT INTO `reply` VALUES (2, '890', '2020-05-01 14:46:36', 4, 2, NULL);
INSERT INTO `reply` VALUES (4, '6767', '2020-05-20 02:04:07', 1, 7, NULL);
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(30) NOT NULL COMMENT '角色名',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, 'USER');
INSERT INTO `role` VALUES (2, 'ADMIN');
COMMIT;

-- ----------------------------
-- Table structure for t_files
-- ----------------------------
DROP TABLE IF EXISTS `t_files`;
CREATE TABLE `t_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `path` varchar(300) DEFAULT NULL,
  `size` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `uploadTime` varchar(100) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_files
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `tag_id` int NOT NULL AUTO_INCREMENT COMMENT '唯一标签id--主键',
  `tag_name` varchar(20) NOT NULL COMMENT '标签名',
  `user_id` int NOT NULL COMMENT '用户id',
  PRIMARY KEY (`tag_id`),
  KEY `8` (`user_id`),
  CONSTRAINT `8` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES (14, 'test2', 1);
INSERT INTO `tag` VALUES (15, 'test1', 1);
INSERT INTO `tag` VALUES (16, 'test3', 1);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户唯一id--主键',
  `user_name` varchar(30) NOT NULL COMMENT '用户名--不能重复',
  `user_password` varchar(255) NOT NULL COMMENT '用户密码',
  `user_mail` varchar(50) NOT NULL COMMENT '用户邮箱',
  `user_state` int NOT NULL COMMENT '用户状态 0 封禁 1正常',
  `user_reward` varchar(255) DEFAULT NULL COMMENT '用户打赏码图片路径',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$usmASSUxqidbn2RrQi4jdeVWUcFyTfmwZgTxSy8FIXQ5CVpm/0qEa', 'xxxxx@xxxx.com', 1, 'null');
INSERT INTO `user` VALUES (4, 'Yveltals', '$2a$10$5fVmHIoX4DDtmQLihhEycOKctXSMI4OUlEk9U1b.3wHsBl.lB6.c2', '3481146533@qq.com', 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_role_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int NOT NULL COMMENT '用户id',
  `role_id` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_role_id`),
  KEY `9` (`user_id`),
  KEY `10` (`role_id`),
  CONSTRAINT `10` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `9` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 1, 2);
INSERT INTO `user_role` VALUES (6, 4, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

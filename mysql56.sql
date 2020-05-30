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

 Date: 31/05/2020 01:09:31
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of announcement
-- ----------------------------
BEGIN;
INSERT INTO `announcement` VALUES (1, 'test', '12sdfbsbrbtxxx', 0, '2020-05-28 11:08:38');
INSERT INTO `announcement` VALUES (12, 'vdfvdfvd', '22222哈哈哈哈', 1, '2020-05-28 11:17:28');
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
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog
-- ----------------------------
BEGIN;
INSERT INTO `blog` VALUES (1, 'Idea快捷键', '\n### **1. Editing(编辑)**\n\n| **快捷键**                 | **介绍**                                                     |\n| -------------------------- | ------------------------------------------------------------ |\n| **Ctrl +Space**            | **基本代码补全，输入字母按后列出匹配的词组**                 |\n| **Ctrl+Shift+Space**       | **智能代码补全，列出与预期类型一致的方法或变量**             |\n| **Ctrl+Alt+Space**         | **补全类名**                                                 |\n| **Ctrl+Shift+Enter**       | **补全语句**                                                 |\n| **Ctrl+P**                 | **显示方法参数**                                             |\n| **Ctrl+Q**                 | **显示注释文档**                                             |\n| **Shift+F1**               | **显示外部文档**                                             |\n| **Ctrl+mouse over code**   | **显示描述信息**                                             |\n| **Ctrl+F1**                | **显示提示、警告、错误等信息**                               |\n| **Alt+Insert**             | **生成代码，生成 Getter、Setter、构造器等**                  |\n| **Ctrl+O**                 | **重写父类方法**                                             |\n| **Ctrl+I**                 | **实现接口方法**                                             |\n| **Ctrl+Alt+T**             | **使用(if..else, try..catch, for, synchronized 等)包围选中语句** |\n| **Ctrl+/**                 | **使用“//”注释或取消注释**                                   |\n| **Ctrl+Shift+/**           | **使用“/\\** \\**/”注释或取消注释**                            |\n| **Ctrl+W**                 | **选择代码块，连续按会增加选择外层的代码块**                 |\n| **Ctrl+Shift+W**           | **与“Ctrl+W”相反，减少选择代码块**                           |\n| **Alt+Q**                  | **显示类描述信息**                                           |\n| **Alt+Enter**              | **显示快速修复列表**                                         |\n| **Ctrl+Alt+L**             | **格式化代码**                                               |\n| **Ctrl+Alt+O**             | **优化 Imports**                                             |\n| **Ctrl+Alt+I**             | **自动优化代码缩进**                                         |\n| **Tab/Shift+Tab**          | **缩进代码/取消缩进代码**                                    |\n| **Ctrl+X or Shift+Delete** | **剪切代码，未选择代码时剪切当前行**                         |\n| **Ctrl+C or Ctrl+Insert**  | **复制代码，未选择代码时复制当前行**                         |\n| **Ctrl+V or Shift+Insert** | **粘贴代码**                                                 |\n| **Ctrl+Shift+V**           | **粘贴最近复制的内容**                                       |\n| **Ctrl+D**                 | **重复代码，未选择代码时重复当前行**                         |\n| **Ctrl+Y**                 | **删除行，未选择时删除当前行**                               |\n| **Ctrl+Shift+J**           | **合并多行为一行**                                           |\n| **Ctrl+Enter**             | **分割一行为多行**                                           |\n| **Shift+Enter**            | **使光标所在位置的下一行为新行**                             |\n| **Ctrl+Shift+U**           | **对选中内容进行大小写切换**                                 |\n| **Ctrl+Shift+]/[**         | **选中到代码块的开始/结束**                                  |\n| **Ctrl+Delete**            | **删除从光标所在位置到单词结束位置的字符**                   |\n| **Ctrl+Backspace**         | **删除从单词起始位置到光标所在位置的字符**                   |\n| **Ctrl+NumPad+/-**         | **展开或收起代码块**                                         |\n| **Ctrl+Shift+NumPad+**     | **展开所有代码块**                                           |\n| **Ctrl+Shift+NumPad-**     | **收起所有代码块**                                           |\n| **Ctrl+F4**                | **关闭当前编辑页**                                           |\n| **CTRL+ALT+B**             | **查找接口的实现类**                                         |\n| **CTRL+ALT+SHIFT+C**       | **复制类的全类名**                                           |\n\n### **2. Search/Replace(查找/替换)**\n\n| **快捷键**       | **介绍**              |\n| ---------------- | --------------------- |\n| **Double Shift** | **Search everywhere** |\n| **Ctrl+F**       | **查找**              |\n| **F3**           | **查找下一个**        |\n| **Shift+F3**     | **查找上一个**        |\n| **Ctrl+R**       | **替换**              |\n| **Ctrl+Shift+F** | **目录内查找**        |\n| **Ctrl+Shift+R** | **目录内替换**        |\n| **Ctrl+Shift+S** | **语法模板搜索**      |\n| **Ctrl+Shift+M** | **语法模板替换**      |\n\n### **3. Usage Search(使用搜索)**\n\n| **快捷键**        | **介绍**                   |\n| ----------------- | -------------------------- |\n| **Alt+F7**        | **查找被使用处**           |\n| **Ctrl+F7**       | **查找当前文件中的使用处** |\n| **Ctrl+Shift+F7** | **高亮当前文件中的使用处** |\n| **Ctrl+Alt+F7**   | **列出使用者**             |\n\n### **4. Compile and Run(编译/运行)**\n\n| **快捷键**         | **介绍**                       |\n| ------------------ | ------------------------------ |\n| **Ctrl+F9**        | **Make 模块、项目**            |\n| **Ctrl+Shift+F9**  | **编译选中的文件、模块、项目** |\n| **Alt+Shift+F10**  | **选择配置后运行代码**         |\n| **Alt+Shift+F9**   | **选择配置后调试代码**         |\n| **Shift+F10**      | **运行代码**                   |\n| **Shift+F9**       | **调试代码**                   |\n| **Ctrl+F2**        | **停止调试**                   |\n| **Ctrl+Shift+F10** | **运行代码**                   |\n\n### **5. Debugging(调试)**\n\n| **快捷键**                | **介绍**                                 |\n| ------------------------- | ---------------------------------------- |\n| **F8**                    | **单步调试，不进入函数内部**             |\n| **F7**                    | **单步调试，进入函数内部**               |\n| **Shift+F7/Alt+Shift+F7** | **选择要进入的函数/强制进入函数**        |\n| **Shift+F8**              | **跳出函数**                             |\n| **Alt+F9**                | **运行到断点**                           |\n| **Alt+F8**                | **执行表达式查看结果**                   |\n| **F9**                    | **继续执行，进入下一个断点或执行完程序** |\n| **Ctrl+F8**               | **设置/取消当前行断点**                  |\n| **Ctrl+Shift+F8**         | **查看断点**                             |\n\n### **6. Navigation(导航)**\n\n| **快捷键**               | **介绍**                           |\n| ------------------------ | ---------------------------------- |\n| **Double Shift**         | **查找所有**                       |\n| **Ctrl+N**               | **查找类**                         |\n| **Ctrl+Shift+N**         | **查找文件**                       |\n| **Ctrl+Alt+Shift+N**     | **Go to symbol**                   |\n| **Alt+Right/Left**       | **左右切换 Tab**                   |\n| **F12**                  | **回到上一个打开的窗口**           |\n| **Esc**                  | **焦点回到编辑器**                 |\n| **Shift+Esc**            | **隐藏打开的视图**                 |\n| **Ctrl+Shift+F4**        | **关闭当前 Tab**                   |\n| **Ctrl+G**               | **跳到指定行**                     |\n| **Ctrl+E**               | **显示最近打开的文件**             |\n| **Ctrl+Alt+Left**        | **跳到光标的上一个位置**           |\n| **Ctrl+Alt+Right**       | **跳到光标的下一个位置**           |\n| **Ctrl+Shift+Backspace** | **跳到上一个编辑处**               |\n| **Alt+F1**               | **选择当前文件显示在不同的视图中** |\n| **Ctrl+B or Ctrl+Click** | **跳到类声明处**                   |\n| **Ctrl+Alt+B**           | **跳到实现类/方法**                |\n| **Ctrl+Shift+I**         | **显示类/变量/方法定义**           |\n| **Ctrl+Shift+B**         | **跳到类型定义处**                 |\n| **Ctrl+U**               | **跳到父类/方法**                  |\n| **Alt+Up**               | **光标移动到上一个方法**           |\n| **Alt+Down**             | **光标移动到下一个方法**           |\n| **Ctrl+]**               | **光标移动到代码块的起始位置**     |\n| **Ctrl+]**               | **光标移动到代码块的结束位置**     |\n| **Ctrl+F12**             | **显示文件结构**                   |\n| **Ctrl+H**               | **显示类层级**                     |\n| **Ctrl+Shift+H**         | **显示方法层级**                   |\n| **Ctrl+Alt+H**           | **显示类/方法调用层级**            |\n| **F2**                   | **光标移动到下一个错误**           |\n| **Shift+F2**             | **标移动到上一个错误**             |\n| **F4**                   | **编辑源码，光标移到编辑器内**     |\n| **Ctrl+Enter**           | **查看源码，光标没移到编辑器内**   |\n| **Alt+Home**             | **显示导航面包屑**                 |\n| **F11**                  | **当前行设置书签**                 |\n| **Shift+F11**            | **显示所有书签**                   |\n| **Ctrl+F11**             | **设置书签号[0-9]**                |\n| **Ctrl+[0-9]**           | **跳到书签号[0-9]所在位置**        |\n\n### **7. Refactoring(重构)**\n\n| **快捷键**     | **介绍**                         |\n| -------------- | -------------------------------- |\n| **F5**         | **复制类**                       |\n| **F6**         | **移动类**                       |\n| **Alt+Delete** | **安全删除，删除前会提示调用处** |\n| **Shift+F6**   | **重命名**                       |\n| **Ctrl+F6**    | **重构方法参数、Exception 等**   |\n| **Ctrl+Alt+N** | **合并多行为一行**               |\n| **Ctrl+Alt+M** | **提取为新方法**                 |\n| **Ctrl+Alt+V** | **提取为新变量**                 |\n| **Ctrl+Alt+F** | **提取为对象新属性**             |\n| **Ctrl+Alt+C** | **提取为新静态常量**             |\n| **Ctrl+Alt+P** | **提取参数**                     |\n\n### **8. VCS/Local History(版本控制/本地历史)**\n\n| **快捷键**           | **介绍**               |\n| -------------------- | ---------------------- |\n| **Ctrl+K**           | **提交改动到 VCS**     |\n| **Ctrl+T**           | **从 VCS 上更新**      |\n| **Alt+Shift+C**      | **查看最近的改动记录** |\n| **Alt+BackQuote(`)** | **显示 VCS 操作列表**  |\n\n### **9. Live Templates(动态模板)**\n\n| **快捷键**     | **介绍**                               |\n| -------------- | -------------------------------------- |\n| **Ctrl+Alt+J** | **使用 Live Template 包围选中代码**    |\n| **Ctrl+J**     | **快速插入 Live Template**             |\n| **iter**       | **快速生成 for…in 语句**               |\n| **inst**       | **快速生成”if instanceof ”语句**       |\n| **itco**       | **快速生成 iterator 的 for 循环**      |\n| **itit**       | **快速生成 iterator 的 while 循环**    |\n| **itli**       | **快速生成 list 的 for(i)循环**        |\n| **psf**        | **快速生成“public static final” 语句** |\n| **thr**        | **快速生成“throw new” 语句**           |\n\n### **10. General(代码生成)**\n\n| **快捷键**             | **介绍**                                                   |\n| ---------------------- | ---------------------------------------------------------- |\n| **Alt+0**              | **聚焦到 Messages 窗口**                                   |\n| **Alt+1**              | **聚焦到 Project 窗口**                                    |\n| **Alt+2**              | **聚焦到 Favorite 窗口**                                   |\n| **Alt+3**              | **聚焦到 Find 窗口**                                       |\n| **Alt+4**              | **聚焦到 Run 窗口**                                        |\n| **Alt+5**              | **聚焦到 Debug 窗口**                                      |\n| **Alt+6**              | **聚焦到 TODO 窗口**                                       |\n| **Alt+7**              | **聚焦到 Structure 窗口**                                  |\n| **Alt+8**              | **聚焦到 Hierarchy 窗口**                                  |\n| **Alt+9**              | **聚焦到 Change 窗口**                                     |\n| **Ctrl+S**             | **保存文件**                                               |\n| **Ctrl+Alt+Y**         | **与本地文件同步**                                         |\n| **Ctrl+Shift+F12**     | **切换最大化编辑**                                         |\n| **Alt+Shift+F**        | **添加到收藏夹**                                           |\n| **Alt+Shift+I**        | **检查当前文件，包括 Javadoc 问题、可能存在的 bug 等**     |\n| **Ctrl+BackQuote (`)** | **模式切换，包括文本外观、快捷键、编辑器外观、代码样式。** |\n| **Ctrl+Alt+S**         | **打开 settings 窗口**                                     |\n| **Ctrl+Alt+Shift+S**   | **打开项目结构对话框**                                     |\n| **Ctrl+Shift+A**       | **Find Action**                                            |\n| **Ctrl+Tab**           | **选项卡和工具窗口之间切换**                               |\n| **Alt+F12**            | **打开命令终端**                                           |\n| **Shift+Shift**        | **搜索文件**                                               |\n\n', 0, 2, '2020-05-01 02:07:52', 1, 1);
INSERT INTO `blog` VALUES (2, '图片上传测试', '## linux和win路径差异问题\n![alive.jpg](/img/fc8752c027714c4c942bea9557ee3ec8.jpg)', 3, 6, '2020-05-15 06:54:53', 1, 1);
INSERT INTO `blog` VALUES (3, 'git基础入门', '\n# 基本操作\n\n## 创建版本库\n\n```bash\n$ mkdir learngit\n$ cd learngit\n$ git init\n$ git clone git@github.com:Yveltals/Store.git\n```\n\n## 添加文件\n\n`git add`把要提交的所有修改放到暂存区(Stage)\n\n`git commit`一次性把暂存区的所有修改提交到分支\n\n```bash\n$ git add file1.txt\n$ git add file2.txt file3.txt\n$ git commit -m \"add 3 files.\"\n```\n\n## 文件修改\n\n`git log`查看文件修改记录，`--pretty=oneline`简化\n\n`git status`查看一下状态\n\n`git diff filename`:比较工作区和暂存区\n\n`git diff HEAD -- filename`:比较工作区和版本库的最新版本\n\n## 撤销修改\n\n`git checkout -- file`:改乱了工作区某个文件的内容，想直接丢弃工作区的修改时\n\n`git reset HEAD`:不但改乱了工作区还添加到了暂存区时，第一步用该命令，就回到了场景1，第二步按场景1操作\n\n## 文件删除\n\n`rm`:删除工作区文件，可从版本库恢复`git checkout -- test.txt`\n`git rm;git commit`:从版本库删除，不能上边方法恢复\n\n# 分支操作\n\n## 创建分支\n\n`git branch name`：创建\n\n`git checkout -b name`：创建并转到\n\n`git checkout -b name origin/name`：在本地创建和远程分支对应的分支\n\n`git branch --set-upstream name origin/name`：建立本地分支和远程分支的关联\n\n## 合并分支\n\n`git branch`：查看分支\n\n`git switch/checkout name`：切换分支\n\n`git merge name`：将name分支合并到当前分支(新分支合并到老分支)\n\n`git branch -d name`：删除分支\n\n## 分支同步\n\n- 指定本地`dev`分支与远程`origin/dev`分支的链接(简化大量操作)\n\n    ```bash\n    git branch --set-upstream-to=origin/dev dev\n    ```\n\n- 从本地推送分支，使用`git push origin name`，如果推送失败，先用git pull抓取远程的新提交(必需保证对应修改的是最新的)\n\n    ```bash\n    git push origin :\n    ```\n\n- 从远程抓取分支，使用`git pull`，如果有冲突，要先处理冲突\n\n    ```bash\n    git pull origin :\n    ```\n\n```\n因此，多人协作的工作模式通常是这样：\n\n1. 首先，可以试图用`git push origin `推送自己的修改；\n2. 如果推送失败，因为远程分支比本地更新，需要先用`git pull`试图合并；\n3. 如果合并有冲突，则解决冲突，并在本地提交；\n4. 没有冲突或者解决掉冲突后，再用`git push origin `推送就能成功！\n\n如果`git pull`提示`no tracking information`，则说明本地分支和远程分支的链接关系没有创建，用命令`git branch --set-upstream-to  origin/`\n```\n\n# 冲突操作\n\n## 分支合并冲突\n\n[![img](https://img-blog.csdnimg.cn/2020040601115598.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1pFUk9fVVM=,size_16,color_FFFFFF,t_70)](https://img-blog.csdnimg.cn/2020040601115598.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1pFUk9fVVM=,size_16,color_FFFFFF,t_70)\n\n两分支各自都分别有新的提交，Git无法执行“快速合并”，只能试图把各自的修改合并起来，但这种合并就可能会有冲突，如：\n\n```bash\n$ git merge feature1\nAuto-merging readme.txt\nCONFLICT (content): Merge conflict in readme.txt\nAutomatic merge failed; fix conflicts and then commit the result.\n```\n\n必须手动解决冲突后再提交(`git status`显示冲突文件)，可以直接查看`readme.txt`内容：\n\n```\nGit is a distributed version control system.\nGit is free software distributed under the GPL.\nGit has a mutable index called stage.\nGit tracks changes of files.\n<<<<<<< HEAD\nCreating a new branch is quick & simple.\n=======\nCreating a new branch is quick AND simple.\n>>>>>>> feature1\n```\n\nGit用`<<<<<<<`，`=======`，`>>>>>>>`标记不同分支的内容，我们修改如下后保存：\n\n```bash\nCreating a new branch is quick and simple.\n```\n\n再提交：\n\n```bash\n$ git add readme.txt \n$ git commit -m \"conflict fixed\"\n[master cf810e4] conflict fixed\n```\n\n# 版本回退\n\n在Git中，用`HEAD`表示当前版本，上个版本`HEAD^`，上上版本`HEAD^^`直到`HEAD~100`。\n\n`git reset`把当前版本回退到上一个版本：\n\n```bash\n$ git reset --hard HEAD^\nHEAD is now at e475afc add distributed\n```\n\n若想撤销回去，可以顺着往上找到对应的`commit id`如`1094adb...`：\n\n```bash\n$ git reset --hard 1094a\nHEAD is now at 83b0afe append GPL\n```\n\n`git reflog`查看命令历史，以便确定要回到未来的哪个版本：\n\n```bash\n$ git reflog\ne475afc HEAD@{1}: reset: moving to HEAD^\n1094adb (HEAD -> master) HEAD@{2}: commit: append GPL\ne475afc HEAD@{3}: commit: add distributed\neaadf4e HEAD@{4}: commit (initial): wrote a readme file\n从输出可知，`append GPL`的commit id是`1094adb`\n```\n\n# 概念理解\n\n## 工作区和暂存区\n\n[![img](https://img-blog.csdnimg.cn/20200406011145920.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1pFUk9fVVM=,size_16,color_FFFFFF,t_70)](https://img-blog.csdnimg.cn/20200406011145920.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1pFUk9fVVM=,size_16,color_FFFFFF,t_70)\n\n## 分支策略\n\n在实际开发中，我们应该按照几个基本原则进行分支管理：\n\n首先，`master`分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；\n\n那在哪干活呢？干活都在`dev`分支上，也就是说，`dev`分支是不稳定的，到某个时候，比如1.0版本发布时，再把`dev`分支合并到`master`上，在`master`分支发布1.0版本；\n\n你和你的小伙伴们每个人都在`dev`分支上干活，每个人都有自己的分支，时不时地往`dev`分支上合并就可以了。\n\n所以，团队合作的分支看起来就像这样：\n\n[![img](https://img-blog.csdnimg.cn/20200406011134555.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1pFUk9fVVM=,size_16,color_FFFFFF,t_70)](https://img-blog.csdnimg.cn/20200406011134555.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1pFUk9fVVM=,size_16,color_FFFFFF,t_70)\n\nGit核心概念\n\n[https://lufficc.com/blog/the-core-conception-of-git#Git%E5%9F%BA%E7%A1%80](https://lufficc.com/blog/the-core-conception-of-git#Git基础)\n\nGit廖雪峰\n\nhttps://www.liaoxuefeng.com/wiki/896043488029600/900003767775424', 0, 1, '2020-05-27 16:03:33', 1, 1);
INSERT INTO `blog` VALUES (140, '敏捷开发入门教程', '作者： 阮一峰\n\n日期： 2019年3月 6日\n\n敏捷开发（agile development）是非常流行的软件开发方法。据统计，2018年90%的软件开发采用敏捷开发。\n\n但是，到底什么是敏捷开发，能说清的人却不多。本文尝试用简洁易懂的语言，解释敏捷开发。\n\n一、迭代开发\n\n敏捷开发的核心是迭代开发（iterative development）。敏捷一定是采用迭代开发的方式。\n\n那么什么是\"迭代开发\"呢？迭代的英文是 iterative，直译为\"重复\"，迭代开发其实就是\"重复开发\"。\n\n对于大型软件项目，传统的开发方式是采用一个大周期（比如一年）进行开发，整个过程就是一次\"大开发\"；迭代开发的方式则不一样，它将开发过程拆分成多个小周期，即一次\"大开发\"变成多次\"小开发\"，每次小开发都是同样的流程，所以看上去就好像重复在做同样的步骤。\n\n举例来说，SpaceX 公司想造一个大推力火箭，将人类送到火星。但是，它不是一开始就造大火箭，而是先造一个最简陋的小火箭 Falcon 1。结果，第一次发射就爆炸了，直到第四次发射，才成功进入轨道。然后，开发了中型火箭 Falcon 9，九年中发射了70次。最后，才开发 Falcon 重型火箭。如果 SpaceX 不采用迭代开发，它可能直到现在还无法上天。\n\n迭代开发将一个大任务，分解成多次连续的开发，本质就是逐步改进。开发者先快速发布一个有效但不完美的最简版本，然后不断迭代。每一次迭代都包含规划、设计、编码、测试、评估五个步骤，不断改进产品，添加新功能。通过频繁的发布，以及跟踪对前一次迭代的反馈，最终接近较完善的产品形态。\n二、增量开发\n\n迭代开发只是要求将开发分成多个迭代，并没有回答一个重要的问题：怎么划分迭代，哪个任务在这个迭代，哪个任务在下个迭代？这时，一般采用\"增量开发\"（incremental development）划分迭代。\n\n所谓\"增量开发\"，指的是软件的每个版本，都会新增一个用户可以感知的完整功能。也就是说，按照新增功能来划分迭代。\n\n举例来说，房产公司开发一个10栋楼的小区。如果采用增量开发的模式，该公司第一个迭代就是交付一号楼，第二个迭代交付二号楼......每个迭代都是完成一栋完整的楼。而不是第一个迭代挖好10栋楼的地基，第二个迭代建好每栋楼的骨架，第三个迭代架设屋顶......\n\n增量开发加上迭代开发，才算真正的敏捷开发。\n三、敏捷开发的好处\n3.1 早期交付\n\n敏捷开发的第一个好处，就是早期交付，从而大大降低成本。\n\n还是以上一节的房产公司为例，如果按照传统的\"瀑布开发模式\"，先挖10栋楼的地基、再盖骨架、然后架设屋顶，每个阶段都等到前一个阶段完成后开始，可能需要两年才能一次性交付10栋楼。也就是说，如果不考虑预售，该项目必须等到两年后才能回款。\n\n敏捷开发是六个月后交付一号楼，后面每两个月交付一栋楼。因此，半年就能回款10%，后面每个月都会有现金流，资金压力就大大减轻了。\n3.2 降低风险\n\n敏捷开发的第二个好处是，及时了解市场需求，降低产品不适用的风险。\n\n请想一想，哪一种情况损失比较小：10栋楼都造好以后，才发现卖不出去，还是造好第一栋楼，就发现卖不出去，从而改进或停建后面9栋楼？\n\n对于软件项目来说，先有一个原型产品，了解市场的接受程度，往往是项目成功的关键。有一本书叫做《梦断代码》，副标题就是\"20+个程序员，三年时间，4732个bug，100+万美元，最后失败的故事\"，这就是没有采用敏捷开发的结果。相反的，Instagram 最初是一个地理位置打卡 App，后来发现用户不怎么在乎地理位置，更喜欢上传照片，就改做照片上传软件，结果成了独角兽。\n\n由于敏捷开发可以不断试错，找出对业务最重要的功能，然后通过迭代，调整软件方向。相比传统方式，大大增加了产品成功的可能性。如果市场需求不确定，或者你对该领域不熟悉，那么敏捷开发几乎是唯一可行的应对方式。\n四、如何进行每一次迭代\n\n虽然敏捷开发将软件开发分成多个迭代，但是也要求，每次迭代都是一个完整的软件开发周期，必须按照软件工程的方法论，进行正规的流程管理。\n\n具体来说，每次迭代都必须依次完成以下五个步骤。\n\n        需求分析（requirements analysis）\n        设计（design）\n        编码（coding）\n        测试（testing）\n        部署和评估（deployment / evaluation）\n\n每个迭代大约持续2~6周。\n五、敏捷开发的价值观\n\n《敏捷软件开发宣言》里面提到四个价值观。\n\n        程序员的主观能动性，以及程序员之间的互动，优于既定流程和工具。\n        软件能够运行，优于详尽的文档。\n        跟客户的密切协作，优于合同和谈判。\n        能够响应变化，优于遵循计划。\n\n六、十二条原则\n\n该宣言还提出十二条敏捷开发的原则。\n\n    通过早期和持续交付有价值的软件，实现客户满意度。\n    欢迎不断变化的需求，即使是在项目开发的后期。要善于利用需求变更，帮助客户获得竞争优势。\n    不断交付可用的软件，周期通常是几周，越短越好。\n    项目过程中，业务人员与开发人员必须在一起工作。\n    项目必须围绕那些有内在动力的个人而建立，他们应该受到信任。\n    面对面交谈是最好的沟通方式。\n    可用性是衡量进度的主要指标。\n    提倡可持续的开发，保持稳定的进展速度。\n    不断关注技术是否优秀，设计是否良好。\n    简单性至关重要，尽最大可能减少不必要的工作。\n    最好的架构、要求和设计，来自团队内部自发的认识。\n    团队要定期反思如何更有效，并相应地进行调整。\n\n七、参考链接\n\n    Iterative development: the secret to great product launches, Pavlo Zinchenko\n    Agile software development, Wikipedia\n\n（完）', 1, 2, '2020-05-28 19:57:49', 1, 1);
INSERT INTO `blog` VALUES (141, '动态规划', '## 算法实现的步骤\n\n1、创建一个一维数组或者二维数组，保存每一个子问题的结果，具体创建一维数组还是二维数组看题目而定，基本上如果题目中给出的是一个一维数组进行操作，就可以只创建一个一维数组，如果题目中给出了两个一维数组进行操作或者两种不同类型的变量值，比如背包问题中的不同物体的体积与总体积，找零钱问题中的不同面值零钱与总钱数，这样就需要创建一个二维数组。\n\n注：需要创建二维数组的解法，都可以创建一个一维数组运用滚动数组的方式来解决，即一位数组中的值不停的变化，后面会详细徐叙述\n\n2、设置数组边界值，一维数组就是设置第一个数字，二维数组就是设置第一行跟第一列的值，特别的滚动一维数组是要设置整个数组的值，然后根据后面不同的数据加进来变幻成不同的值。\n\n3、找出状态转换方程，也就是说找到每个状态跟他上一个状态的关系，根据状态转化方程写出代码。\n\n4、返回需要的值，一般是数组的最后一个或者二维数组的最右下角。\n\n代码基本框架：\n```c++\n    for(j=1; j<=m; j=j+1) // 第一个阶段\n        xn[j] = 初始值;\n     \n      for(i=n-1; i>=1; i=i-1)// 其他n-1个阶段\n        for(j=1; j>=f(i); j=j+1)//f(i)与i有关的表达式\n          xi[j]=j=max（或min）{g(xi-[j1:j2]), ......, g(xi-1[jk:jk+1])};\n     \n     t = g(x1[j1:j2]); // 由子问题的最优解求解整个问题的最优解的方案\n     \n     print(x1[j1]);\n     \n     for(i=2; i<=n-1; i=i+1）\n     {  \n          t = t-xi-1[ji];\n     \n          for(j=1; j>=f(i); j=j+1)\n             if(t=xi[ji])\n                  break;}\n```\n下面通过几个典型例子，从简单到难帮助我们理解动态规划。\n\n### 1、斐波那契数列\n\n斐波那契数列大家都很熟悉，而且知道用递归可以很容易的做出来\n```c++\n        if(n == 0){\n    	return 0;\n        }else if(n == 1){\n    	return 1;\n        }else{\n    	return solutionFibonacci(n-1)+solutionFibonacci(n-2);\n        }\n\n如果用动态规划，就是把结果存到一个数组中。\n\n    public static int solutionFibonacci(int n){\n    		if(n==0){\n    			return 0;\n    		}else if(n == 1){\n    			return 1;\n    		}else{\n    			int result[] = new int[n+1];\n    			result[0] = 0;\n    			result[1] = 1;\n    			for(int i=2;i<=n;i++){\n    				result[i] = result[i-1] + result[i-2];\n    			}\n    			return result[n];\n    		}\n```\n>与之类似的还有：跳台阶问题：每次只能跳一个或者两个台阶，跳到n层台阶上有几种方法\n\n填充长方体问题：将一个2*1的长方体填充到2*n的长方体中，有多少种方法\n\n### 2、数组最大不连续递增子序列\n\n>arr[] = {3,1,4,1,5,9,2,6,5}的最长递增子序列长度为4。即为：1,4,5,9\n\n设置一个数组temp，长度为原数组长度，数组第i个位置上的数字代表0...i上最长递增子序列，当增加一个数字时，最大递增子序列可能变成前面最大的递增子序列+1，也可能就是前面最大递增子序列，这需要让新增加进来的数字arr[i]跟前面所有数字比较大小，即当 arr[i] > arr[j]，temp[i] = max{temp[j]}+1，其中，j 的取值范围为：0,1...i-1，当 arr[i] < arr[j]，temp[i] = max{temp[j]}，j 的取值范围为：0,1...i-1，所以在状态转换方程为temp[i]=max{temp[i-1], temp[i-1]+1}\n```c++\n    public static int MaxChildArrayOrder(int a[]) {\n    		int n = a.length;\n    		int temp[] = new int[n];//temp[i]代表0...i上最长递增子序列\n    		for(int i=0;i<n;i++){\n    			temp[i] = 1;//初始值都为1\n    		}\n    		for(int i=1;i<n;i++){\n    			for(int j=0;j<i;j++){\n    				if(a[i]>a[j]&&temp[j]+1>temp[i]){\n    					//如果有a[i]比它前面所有的数都大，则temp[i]为它前面的比它小的数的那一个temp+1取得的最大值\n    					temp[i] = temp[j]+1;\n    				}\n    			}\n    		}\n    		int max = temp[0];\n    		//从temp数组里取出最大的值\n    		for(int i=1;i<n;i++){\n    			if(temp[i]>max){\n    				max = temp[i];\n    			}\n    		}\n    		return max;\n    	}\n```\n### 3、数组最大连续子序列和\n\n如arr[] = {6,-1,3,-4,-6,9,2,-2,5}的最大连续子序列和为14。即为：9,2,-2,5\n\n创建一个数组a，长度为原数组长度，不同位置数字a[i]代表0...i上最大连续子序列和，a[0]=arr[0]设置一个最大值max，初始值为数组中的第一个数字。当进来一个新的数字arr[i+1]时，判断到他前面数字子序列和a[i]+arr[i+1]跟arr[i+1]哪个大，前者大就保留前者，后者大就说明前面连续数字加起来都不如后者一个新进来的数字大，前面数字就可以舍弃，从arr[i+1]开始，每次比较完都跟max比较一下，最后的max就是最大值。\n```c++\n    public static int MaxContinueArraySum(int a[]) {\n    		int n = a.length;\n    		int max = a[0];\n    		int sum = a[0];\n    		for(int i=1;i<n;i++){\n    			sum = Math.max(sum+a[i], a[i]);\n    			if(sum>=max){\n    				max = sum;\n    			}\n    		}\n    		return max;\n    	}\n```', 2, 2, '2020-05-28 20:05:56', 1, 4);
INSERT INTO `blog` VALUES (142, '线程与进程', '![](https://img-blog.csdnimg.cn/20190420151217315.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzI1ODkwOA==,size_16,color_FFFFFF,t_70)\n我们都知道计算机的核心是CPU，它承担了所有的计算任务，而操作系统是计算机的管理者，它负责任务的调度，资源的分配和管理，统领整个计算机硬件；应用程序是具有某种功能的程序，程序是运行于操作系统之上的。\n\n## 进程\n\n进程是一个具有一定独立功能的程序在一个数据集上的一次动态执行的过程，是操作系统进行资源分配和调度的一个独立单位，是应用程序运行的载体。进程是一种抽象的概念，从来没有统一的标准定义。进程一般由程序，数据集合和进程控制块三部分组成。\n\n程序用于描述进程要完成的功能，是控制进程执行的指令集；数据集合是程序在执行时所需要的数据和工作区；程序控制块包含进程的描述信息和控制信息是进程存在的唯一标志。\n\n进程具有的特征：\n\n动态性：进程是程序的一次执行过程，是临时的，有生命期的，是动态产生，动态消亡的；\n\n并发性：任何进程都可以同其他进行一起并发执行；\n\n独立性：进程是系统进行资源分配和调度的一个独立单位；\n\n结构性：进程由程序，数据和进程控制块三部分组成。\n\n## 线程\n\n在早期的操作系统中并没有线程的概念，进程是拥有资源和独立运行的最小单位，也是程序执行的最小单位。任务调度采用的是时间片轮转的抢占式调度方式，而进程是任务调度的最小单位，每个进程有各自独立的一块内存，使得各个进程之间内存地址相互隔离。\n\n后来，随着计算机的发展，对CPU的要求越来越高，进程之间的切换开销较大，已经无法满足越来越复杂的程序的要求了。于是就发明了线程，线程是程序执行中一个单一的顺序控制流程，是程序执行流的最小单元，是处理器调度和分派的基本单位。一个进程可以有一个或多个线程，各个线程之间共享程序的内存空间(也就是所在进程的内存空间)。一个标准的线程由线程ID，当前指令指针PC，寄存器和堆栈组成。而进程由内存空间(代码，数据，进程空间，打开的文件)和一个或多个线程组成。\n\n## 进程与线程的区别\n\n线程是程序执行的最小单位，而进程是操作系统分配资源的最小单位；\n一个进程由一个或多个线程组成，线程是一个进程中代码的不同执行路线；\n进程之间相互独立，但同一进程下的各个线程之间共享程序的内存空间\n调度和切换：线程上下文切换比进程上下文切换要快得多。\n![](https://img-blog.csdnimg.cn/2019042015123733.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzI1ODkwOA==,size_16,color_FFFFFF,t_70)\n\n\n## 为何不使用多进程而是使用多线程？\n\n线程廉价，线程启动比较快，退出比较快，对系统资源的冲击也比较小。而且线程彼此分享了大部分核心对象(File Handle)的拥有权如果使用多重进程，但是不可预期，且测试困难。', 0, 2, '2020-05-28 20:10:42', 1, 4);
INSERT INTO `blog` VALUES (143, 'vue组件', '\n\n## 十、 组件\n\n组件 (Component) 是 Vue.js 最强大的功能之一。组件可以扩展 HTML 元素，封装可重用的代码。在较高层面上，组件是自定义元素，Vue.js 的编译器为它添加特殊功能。\n\n### (一) 组件注册：\n\n组件构造器：Vue.extend({ })，2.0中可以不使用构造器进行构造，直接写入对象；\n规则：对于自定义标签名，Vue.js 不强制要求遵循 W3C 规则\n1、 全局注册：\n方式：Vue.component(“组件名”,组件)\n2、 局部注册：\n组件只能在被注册的组件中使用，而无法在其他组件中使用.\n3、 注册语法糖：\n全局注册和局部注册(使用components属性，值为对象，组件名和组件定义对象是键值对的关系)；\n\n### (二) 组件选项：\n\n1、 props：\n\na) 定义一个局部变量，并用 prop 的值初始化它：（只会在初始化时，进行一次赋值，后期不会动态改变）\nprops: [\'initialCounter\'],\n\n```vue\ndata: function () {\n  return { counter: this.initialCounter }\n}\n```\n\nb) 定义一个计算属性，处理prop的值并返回：（进行属性值的动态跟踪）\nprops: [\'size\'],\n\n```vue\ncomputed: {\n  normalizedSize: function () {\n   return this.size.trim().toLowerCase()\n  }\n}\n```\n\n\n\n### (三) 非Prop属性：\n\n1、 在组件上使用自定义属性，如果不在子组件中使用props进行接受，则此属性会被默认添加到组件的根元素上；\n2、  在组件上使用html元素已有的属性，如class、style等，则组件上的属性值，会和组件的根节点的相应属性值进行合并等特性；如type等属性值，会进行覆盖或替换；如：组件中的input的type为number，使用组件时传入的type值为text，则组件内部的input的type值将被替换为text；\n\n\n\n### (四) 组件间通信:\n\n1、 直接访问：\n1) 父组件实例children：包含所有子组件实例\n3) ：组件所在的根实例；这三个属性都挂载在组件的上，不推荐这样做，会造成父子组件间的强耦合；、自定义事件监听：组件实例化时，在组件的标签上使用进行事件的监听；、自定义事件触发机制：emit:在实例本身上触发事件在子组件的钩子函数中去触发事件；\n4、 子组件索引：\n通过ref指令，绑定一个子组件，可以在父组件中使用this.$refs.属性名  的方式获取子组件；\n5、 非父子通信：\n思想：建立一个空的vue实例作为中央事件总线，即全局的vue实例；\n代码如下：\n\n```vue\nvar bus = new Vue()\n// 触发组件 A 中的事件\nbus.$emit(\'id-selected\', 1)\n// 在组件 B 创建的钩子中监听事件\nbus.$on(\'id-selected\', function (id) {\n  // ...\n})\n```\n\n### \n\n### (五) 内容分发：\n\n1、 基础用法：\n提供一种混合父组件内容与子组件自己模板的方式叫做内容分发；\nSlot标签；\n2、 使用需求：\n当子组件中的dom结构以及展示的内容由父组件决定时\n3、 编译作用域：\n如果在子组件的模板中使用{{}}解析数据，则模板会解析自己作用域中的数据，而不是解析父组件作用中的数据；\n4、 默认slot：\n   <slot>标签允许有一个匿名slot，不需要name值，作为找不到匹配的内容片段的回退插槽，如果没有默认的slot，这些找不到匹配的内容片段将被忽略；\n5、 作用域插槽：\n在父组件的slot模板中使用子组件中数据；如：\n\n```vue\n//子组件\n<div class=\"child\">\n  <slot text=\"hello from child\"></slot>\n</div>\n//父组件\n<div class=\"parent\">\n  <child>\n    <template scope=\"props\">\n      <span>hello from parent</span>\n      <span>{{ props.text }}</span>\n    </template>\n  </child>\n</div>\n```\n\n\n\n### (六) 动态组件：\n\n1、基础用法：\ncomponent 标签上 is 属性决定了当前采用的子组件，:is 是 v-bind:is 的缩写，绑定了父  组件中 data 的 currentView 属性。顶部的 ul 则起到导航的作用，点击即可修改 currentView 值，也就修改  component 标签中使用的子组件类型，需要注意的事，currentView 的值需要 和父组件实例中的 components 属性的  key 相对应。（起到路由的作用）\n2、keep-alive\n在component 标签外层包裹一个 keep-alive 标签，可以将切换出去的组件保留在内存中，避免重新 渲染。\n\n### (七)   杂项：\n\n1、 异步组件：\n局部定义组件写法：\n\n```vue\nnew Vue({\n  components: {\n//使用webpack+es6\n    \'my-component\': () => import(\'./my-async-component\')\n//使用webpack+es5\n\'my-component\': require([\'./my-async-component\'], resolve)\n  }\n})\n使用webpack + es5的写法：\n```\n\n2、 当注册组件 (或者 props) 时，可以使用 kebab-case，camelCase，或 PascalCase。但是使用组件时只能用kebab-case这种写法；html不识别大小写；\n3、 当组件中包含大量静态内容时，可以考虑使用 v-once 将渲染结果缓存起来\n\n```vue\nVue.component(\'terms-of-service\', {\n  template: \'\\\n    <div v-once>\\\n      <h1>Terms of Service</h1>\\\n      ... a lot of static content ...\\\n    </div>\\\n  \'\n})\n```', 0, 2, '2020-05-28 20:16:36', 1, 4);
INSERT INTO `blog` VALUES (144, 'springboot学习笔记-6 springboot整合RabbitMQ', '\n**一. RabbitMQ的介绍**　　\n\n　　RabbitMQ是消息中间件的一种,消息中间件即分布式系统中完成消息的发送和接收的基础软件.这些软件有很多,包括ActiveMQ(apache公司的),RocketMQ(阿里巴巴公司的,现已经转让给apache).\n\n　　消息中间件的工作过程可以用生产者消费者模型来表示.即,生产者不断的向消息队列发送信息,而消费者从消息队列中消费信息.\n\n　　紧接着说一下交换机.交换机的主要作用是接收相应的消息并且绑定到指定的队列.交换机有四种类型,分别为Direct,topic,headers,Fanout.\n\n　　Direct是RabbitMQ默认的交换机模式,也是最简单的模式.即创建消息队列的时候,指定一个BindingKey.当发送者发送消息的时候,指定对应的Key.当Key和消息队列的BindingKey一致的时候,消息将会被发送到该消息队列中.\n\n　　topic转发信息主要是依据通配符,队列和交换机的绑定主要是依据一种模式(通配符+字符串),而当发送消息的时候,只有指定的Key和该模式相匹配的时候,消息才会被发送到该消息队列中.\n\n\n\n**二.SpringBoot整合RabbitMQ(Direct模式)**\n\n　　SpringBoot整合RabbitMQ非常简单!感觉SpringBoot真的极大简化了开发的搭建环境的时间..这样我们程序员就可以把更多的时间用在业务上了,下面开始搭建环境:\n\n　　首先创建两个maven工程,这是为了模拟分布式应用系统中,两个应用之间互相交流的过程,一个发送者(Sender),一个接收者(Receiver)\n\n![img](https://images2015.cnblogs.com/blog/972319/201703/972319-20170311163430779-895119703.png)\n\n​		在application.properties中,去编辑和RabbitMQ相关的配置信息,配置信息的代表什么内容根据键就能很直观的看出了.这里端口是5672,不是15672...15672是管理端的端口!\n\n```yml\nspring.application.name=spirng-boot-rabbitmq-sender\nspring.rabbitmq.host=127.0.0.1\nspring.rabbitmq.port=5672\nspring.rabbitmq.username=guest\nspring.rabbitmq.password=guest\n```\n\n　　随后,配置Queue(消息队列).那注意由于采用的是Direct模式,需要在配置Queue的时候,指定一个键,使其和交换机绑定\n\n```java\n@Configuration\npublic class SenderConf {\n     @Bean\n     public Queue queue() {\n          return new Queue(\"queue\");\n     }\n}\n```\n\n　　接着就可以发送消息啦!在SpringBoot中,我们使用AmqpTemplate去发送消息!代码如下:\n\n```java\n@Component\npublic class HelloSender {\n    @Autowired\n    private AmqpTemplate template;\n    \n    public void send() {\n    template.convertAndSend(\"queue\",\"hello,rabbit~\");\n    }\n}\n```\n\n　　编写测试类!这样我们的发送端代码就编写完了~\n\n```java\n@SpringBootTest(classes=App.class)\n@RunWith(SpringJUnit4ClassRunner.class)\npublic class TestRabbitMQ {\n    \n    @Autowired\n    private HelloSender helloSender;\n\n    @Test\n    public void testRabbit() {\n        helloSender.send();\n    }\n}\n```\n\n　　接着我们编写接收端.接收端的pom文件,application.properties(修改spring.application.name),Queue配置类,App启动类都是一致的!这里省略不计.主要在于我们需要配置监听器去监听绑定到的消息队列,当消息队列有消息的时候,予以接收,代码如下\n\n```java\n@Component\npublic class HelloReceive {\n\n    @RabbitListener(queues=\"queue\")    //监听器监听指定的Queue\n    public void processC(String str) {\n        System.out.println(\"Receive:\"+str);\n    }\n\n}\n```\n\n　　接下来就可以测试啦,首先启动接收端的应用,紧接着运行发送端的单元测试,接收端应用打印出来接收到的消息,测试即成功!\n\n　　需要注意的地方,Direct模式相当于一对一模式,一个消息被发送者发送后,会被转发到一个绑定的消息队列中,然后被一个接收者接收!\n\n　　实际上RabbitMQ还可以支持发送对象:当然由于涉及到序列化和反序列化,该对象要实现Serilizable接口.HelloSender做出如下改写:\n\n```java\npublic void send() {\n\n        User user=new User();    //实现Serializable接口\n        user.setUsername(\"hlhdidi\");\n        user.setPassword(\"123\");\n        template.convertAndSend(\"queue\",user);\n    \n}\n```\n\n```java\n@RabbitListener(queues=\"queue\")    //监听器监听指定的Queue\n    public void process1(User user) {    //用User作为参数\n        System.out.println(\"Receive1:\"+user);\n    }\n```', 0, 2, '2020-05-28 20:25:02', 1, 4);
INSERT INTO `blog` VALUES (145, '常用meta整理', '\n## <meta\\> 元素\n\n### 概要\n\nmeta标签提供关于HTML文档的元数据。元数据不会显示在页面上，但是对于机器是可读的。它可用于浏览器（如何显示内容或重新加载页面），搜索引擎（关键词），或其他 web 服务。\n\n\n\n**必要属性**\n\n| 属性    | 值        | 描述                                   |\n| ------- | --------- | -------------------------------------- |\n| content | some text | 定义与http-equiv或name属性相关的元信息 |\n\n**可选属性**\n\n| 属性       | 值                                                           | 描述                                |\n| ---------- | ------------------------------------------------------------ | ----------------------------------- |\n| http-equiv | content-type / expire / refresh / set-cookie                 | 把content属性关联到HTTP头部。       |\n| name       | author / description / keywords / generator / revised / others | 把 content 属性关联到一个name。     |\n| content    | some text                                                    | 定义用于翻译 content 属性值的格式。 |\n\n### 网页相关\n\n- **申明编码**\n\n```html\n<meta charset=\'utf-8\' />\n```\n\n- **优先使用 IE 最新版本和 Chrome**\n\n```html\n<!-- 关于X-UA-Compatible -->\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" /> <!-- 推荐 -->\n\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=6\" ><!-- 使用IE6 -->\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=7\" ><!-- 使用IE7 -->\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=8\" ><!-- 使用IE8 -->\n```\n\n- **浏览器内核控制**：国内浏览器很多都是双内核（webkit和Trident），webkit内核高速浏览，IE内核兼容网页和旧版网站。而添加meta标签的网站可以控制浏览器选择何种内核渲染。[参考文档](http://se.360.cn/v6/help/meta.html)\n\n```html\n默认用极速核(Chrome)：<meta name=\"renderer\" content=\"webkit\"> \n默认用ie兼容内核（IE6/7）：<meta name=\"renderer\" content=\"ie-comp\"> \n默认用ie标准内核（IE9/IE10/IE11/取决于用户的IE）：<meta name=\"renderer\" content=\"ie-stand\"> \n```\n\n国内双核浏览器默认内核模式如下：\n\n1. 搜狗高速浏览器、QQ浏览器：IE内核（兼容模式）\n2. 360极速浏览器、遨游浏览器：Webkit内核（极速模式）\n\n- **禁止浏览器从本地计算机的缓存中访问页面内容**：这样设定，访问者将无法脱机浏览。\n\n```html\n<meta http-equiv=\"Pragma\" content=\"no-cache\">\n```\n\n- **Windows 8**\n\n```html\n<meta name=\"msapplication-TileColor\" content=\"#000\"/> <!-- Windows 8 磁贴颜色 -->\n<meta name=\"msapplication-TileImage\" content=\"icon.png\"/> <!-- Windows 8 磁贴图标 -->\n```\n\n- **站点适配**：主要用于PC-手机页的对应关系。\n\n```html\n<meta name=\"mobile-agent\"content=\"format=[wml|xhtml|html5]; url=url\">\n<!--\n[wml|xhtml|html5]根据手机页的协议语言，选择其中一种；\nurl=\"url\" 后者代表当前PC页所对应的手机页URL，两者必须是一一对应关系。\n -->\n```\n\n- **转码申明**：用百度打开网页可能会对其进行转码（比如贴广告），避免转码可添加如下meta。\n\n```html\n<meta http-equiv=\"Cache-Control\" content=\"no-siteapp\" />\n```\n\n\n\n\n\n### SEO优化\n\n- **页面关键词**，每个网页应具有描述该网页内容的一组唯一的关键字。\n    使用人们可能会搜索，并准确描述网页上所提供信息的描述性和代表性关键字及短语。标记内容太短，则搜索引擎可能不会认为这些内容相关。另外标记不应超过 874 个字符。\n\n```html\n<meta name=\"keywords\" content=\"your tags\" />\n```\n\n- **页面描述**，每个网页都应有一个不超过 150 个字符且能准确反映网页内容的描述标签。\n\n```html\n<meta name=\"description\" content=\"150 words\" />\n```\n\n- **页面重定向和刷新**：content内的数字代表时间（秒），既多少时间后刷新。如果加url,则会重定向到指定网页（搜索引擎能够自动检测，也很容易被引擎视作误导而受到惩罚）。\n\n```html\n<meta http-equiv=\"refresh\" content=\"0;url=\" />\n```\n\n- **其他**\n\n```html\n<meta name=\"author\" content=\"author name\" /> <!-- 定义网页作者 -->\n<meta name=\"google\" content=\"index,follow\" />\n<meta name=\"googlebot\" content=\"index,follow\" />\n<meta name=\"verify\" content=\"index,follow\" />\n```\n\n### 移动设备\n\n- **viewport**：能优化移动浏览器的显示。如果不是响应式网站，不要使用initial-scale或者禁用缩放。\n\n```html\n<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0,minimun-scale=1.0,maximum-scale=1.0,user-scalable=no\"/>\n<!--这是常用的移动meta设置-->\n```\n\n1. width：宽度（数值 / device-width）（范围从200 到10,000，默认为980 像素）\n2. height：高度（数值 / device-height）（范围从223 到10,000）\n3. initial-scale：初始的缩放比例 （范围从>0 到10）\n\n**注意**，很多人使用initial-scale=1到非响应式网站上，这会让网站以100%宽度渲染，用户需要手动移动页面或者缩放。如果和initial-scale=1同时使用user-scalable=no或maximum-scale=1，则用户将不能放大/缩小网页来看到全部的内容。\n\n- **WebApp全屏模式**：伪装app，离线应用。\n\n```html\n<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" /> <!-- 启用 WebApp 全屏模式 -->\n```\n\n- **主题颜色**\n\n```html\n<meta name=\"theme-color\" content=\"#11a8cd\">\n```\n\n![](https://cdn.jsdelivr.net/gh/xugaoyi/image_store/blog/20200221134927.jpg)\n\n- **隐藏状态栏/设置状态栏颜色**：只有在开启WebApp全屏模式时才生效。content的值为default | black | black-translucent 。\n\n```html\n<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black-translucent\" />\n```\n\n- **添加到主屏后的标题**\n\n```html\n<meta name=\"apple-mobile-web-app-title\" content=\"标题\">\n```\n\n- **忽略数字自动识别为电话号码**\n\n```html\n<meta content=\"telephone=no\" name=\"format-detection\" />\n```\n\n- **忽略识别邮箱**\n\n```html\n<meta content=\"email=no\" name=\"format-detection\" />\n```\n\n- **添加智能 App 广告条 Smart App Banner**：告诉浏览器这个网站对应的app，并在页面上显示下载banner(如下图)。[参考文档](https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/PromotingAppswithAppBanners/PromotingAppswithAppBanners.html)\n\n```html\n<meta name=\"apple-itunes-app\" content=\"app-id=myAppStoreID, affiliate-data=myAffiliateData, app-argument=myURL\">\n```\n\n![](https://cdn.jsdelivr.net/gh/xugaoyi/image_store/blog/20200221134638.png)\n\n\n\n### 一个常用的移动端页面meta设置\n\n```html\n<meta charset=\"utf-8\">\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0,minimun-scale=1.0,maximum-scale=1.0,user-scalable=no\">\n```\n\n', 1, 41, '2020-05-28 20:29:11', 1, 4);
INSERT INTO `blog` VALUES (146, '数据库基本操作', '-- 选择要操作的数据库\n-- world:数据库名\nuse world;\n\n-- 显示已存在的数据库列表\nshow databases;\n\n-- 显示指定数据库下的表的信息\nshow tables;\n\n-- 显示指定表的列的信息\n-- world.country:数据库名.表名\nshow columns from world.country;\n\n-- 显示指定表的索引信息\n-- world.country:数据库名.表名\nshow index from world.country;\n\n-- 显示指定数据库下的表的详细信息\n-- world:数据库名\nshow table status from world;\n\n-- 显示指定数据库下的表名称以字母\'c\'开头的表的详细信息\n-- world:数据库名\nshow table status from world like \'c%\';\n\n-- 显示数据库表的结构，如：字段名，字段类型等\n-- world.country:数据库名.表名\ndescribe world.country;\n\n-- 查看创建表的SQL语句\n-- demo.test：数据库名.表名\nshow create table demo.test;\n\n-- 查看创建存储过程的SQL语句\n-- demo.test_proc：数据库名.存储过程名\nshow create procedure demo.test_proc;\n\n-- 查看创建视图的SQL语句\n-- demo.test_view：数据库名.视图名\nshow create view demo.test_view;\n\n-- 查看创建函数的SQL语句\n-- demo.test_fun：数据库名.函数名\nshow create function demo.test_fun;\n\n-- 查看当前用户的数据库权限\nshow grants;\n\n-- 查看指定用户的数据库权限\n-- admin@localhost:用户名@访问主机\nshow grants for \'admin\'@\'localhost\';        \n\n-- 查询数据库用户信息\nselect * from mysql.user;\n\n-- 获取服务器版本信息\nSELECT VERSION();\n\n-- 获取当前数据库名 (或者返回空)\nSELECT DATABASE();\n\n-- 获取当前用户名\nSELECT USER();\n\n-- 获取服务器状态\nSHOW STATUS;\n\n-- 获取服务器配置变量\nSHOW VARIABLES;\n例如：\n-- 查询自增长值的步长，即每次增加多少，默认为1。\nshow variables like \'%auto_increment%\';\n-- 设置自增长值每次增加的数值，会影响所有数据表。\nset auto_increment_increment=3;\n-- 设置自增长值的起始值，会影响所有数据表。\nset auto_increment_offset=100;\n\n-- mysql运行在安全模式下时，非主键条件下是无法执行update或者delete命令的\n-- 查看安全模式状态\nshow variables like \'%sql_safe_updates%\';\n-- 设置安全模式为关闭\nset sql_safe_updates=off;\n\n-- 获取最近一次向具有identity属性(即自增列)的表插入数据时对应的自增列的值，@@identity是系统定义的全局变量。\nselect @@identity;\n\n-- LAST_INSERT_ID函数将返回当前连接自增列最新的 insert or update 操作生成的第一个记录的ID。因为其基于Connection的，所以也是线程安全的。\nselect LAST_INSERT_ID();', 3, 29, '2020-05-28 23:40:20', 1, 1);
INSERT INTO `blog` VALUES (147, '技术分享类博客网站', '## 网站要求\n1.基本页面至少应包括：主页、用户空间、博文浏览页面、博文编辑页面搜索结果页面\n2.主页为用户访问网站最先看的页面，需要展示推荐博文条目及分类板块等信息。推荐应采用合理的推荐算法\n3.用户空间应包含个人博文列表板块、个人信息修改板块等\n4.博文浏览页面应展示博文内容、题目、作者信息、博文类别以及提供评论入口。博文应能够支持展示图片\n5.博文编辑页面需包含博文题目、内容的输入区域。作者可以为博文添加类别标签。博文编辑应支持插入图片\n6.搜索结果页面按条目展示搜索结果，搜索应可选全文匹配或者关键字（类别标签）匹配\n7.网站可使用邮箱或手机号码进行注册，做好登录注册信息传输安全方面的考虑。\n8.搜索结果页面需要展示搜索到的结果条目，搜索要求做到尽量精准快速。\n9.网站应具有资源上传、下载功能，可单独构建资源板块也可将资源嵌入博文中。\n10.网站应具有一定程度社交功能，用户可以关注作者、查看动态、点赞文章、评论文章等。\n11.页面设计美观，各页面之间风格统一。', 3, 29, '2020-05-29 00:05:56', 1, 1);
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
INSERT INTO `blog_tag` VALUES (146, 1);
INSERT INTO `blog_tag` VALUES (142, 2);
INSERT INTO `blog_tag` VALUES (142, 3);
INSERT INTO `blog_tag` VALUES (144, 3);
INSERT INTO `blog_tag` VALUES (141, 4);
INSERT INTO `blog_tag` VALUES (3, 5);
INSERT INTO `blog_tag` VALUES (140, 5);
INSERT INTO `blog_tag` VALUES (147, 5);
INSERT INTO `blog_tag` VALUES (144, 6);
INSERT INTO `blog_tag` VALUES (143, 7);
INSERT INTO `blog_tag` VALUES (3, 8);
INSERT INTO `blog_tag` VALUES (140, 8);
INSERT INTO `blog_tag` VALUES (143, 8);
INSERT INTO `blog_tag` VALUES (145, 8);
INSERT INTO `blog_tag` VALUES (147, 8);
INSERT INTO `blog_tag` VALUES (3, 10);
INSERT INTO `blog_tag` VALUES (140, 10);
INSERT INTO `blog_tag` VALUES (144, 10);
INSERT INTO `blog_tag` VALUES (147, 10);
INSERT INTO `blog_tag` VALUES (143, 11);
INSERT INTO `blog_tag` VALUES (145, 11);
INSERT INTO `blog_tag` VALUES (147, 11);
INSERT INTO `blog_tag` VALUES (1, 12);
INSERT INTO `blog_tag` VALUES (2, 12);
INSERT INTO `blog_tag` VALUES (146, 12);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discuss
-- ----------------------------
BEGIN;
INSERT INTO `discuss` VALUES (9, '1234567890', '2020-05-28 20:00:10', 1, 140);
INSERT INTO `discuss` VALUES (10, '1234567890', '2020-05-29 00:11:01', 1, 147);
INSERT INTO `discuss` VALUES (11, 'nginx', '2020-05-29 00:12:04', 4, 147);
INSERT INTO `discuss` VALUES (12, '222', '2020-05-30 11:08:48', 5, 141);
INSERT INTO `discuss` VALUES (13, '哈哈哈红红火火恍恍惚惚哈哈哈哈', '2020-05-30 13:20:57', 5, 146);
INSERT INTO `discuss` VALUES (15, '114514', '2020-05-30 13:21:21', 5, 146);
INSERT INTO `discuss` VALUES (16, 'Hightlisht: one-dark-light', '2020-05-30 14:30:43', 4, 145);
COMMIT;

-- ----------------------------
-- Table structure for favor
-- ----------------------------
DROP TABLE IF EXISTS `favor`;
CREATE TABLE `favor` (
  `user_id` int NOT NULL,
  `blog_id` int NOT NULL,
  `favor_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`favor_id`),
  KEY `fk_user` (`user_id`),
  KEY `fk_blog` (`blog_id`),
  CONSTRAINT `fk_blog` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favor
-- ----------------------------
BEGIN;
INSERT INTO `favor` VALUES (4, 145, 2);
INSERT INTO `favor` VALUES (1, 147, 3);
INSERT INTO `favor` VALUES (1, 146, 4);
INSERT INTO `favor` VALUES (1, 145, 5);
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` VALUES (44, 'admin', 'wqqwqw', '2020-05-28 10:09:34');
INSERT INTO `message` VALUES (45, 'Yveltals', 'sdvsvdsvvvvvv', '2020-05-28 11:03:14');
INSERT INTO `message` VALUES (46, 'zero', 'http://localhost:1024/#/message', '2020-05-29 00:24:33');
INSERT INTO `message` VALUES (47, 'zero', '321', '2020-05-29 00:26:34');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
BEGIN;
INSERT INTO `reply` VALUES (5, 'qwesad', '2020-05-29 00:11:17', 1, 10, NULL);
INSERT INTO `reply` VALUES (6, 'eee', '2020-05-30 11:18:04', 5, 12, NULL);
INSERT INTO `reply` VALUES (7, '4321', '2020-05-30 13:21:13', 5, 13, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES (1, '数据库');
INSERT INTO `tag` VALUES (2, 'OS');
INSERT INTO `tag` VALUES (3, 'Java');
INSERT INTO `tag` VALUES (4, '算法');
INSERT INTO `tag` VALUES (5, '软件工程');
INSERT INTO `tag` VALUES (6, 'springboot');
INSERT INTO `tag` VALUES (7, 'vue');
INSERT INTO `tag` VALUES (8, '前端开发');
INSERT INTO `tag` VALUES (9, 'rabbitMQ');
INSERT INTO `tag` VALUES (10, '后端开发');
INSERT INTO `tag` VALUES (11, '网页设计');
INSERT INTO `tag` VALUES (12, '资料');
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
  `user_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_birth` varchar(255) DEFAULT NULL,
  `user_job` varchar(255) DEFAULT NULL,
  `user_qq` varchar(255) DEFAULT NULL,
  `user_summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$3SvaOLWaEU3if/pAnABXOe1uz6uUMuorkdN.nwgkT8vCQ4zpvku3K', 'sddcsd@gmail.com', 1, '男', '2020-05-30', '学生', '1234567890', '无');
INSERT INTO `user` VALUES (4, 'Yveltals', '$2a$10$FIHxuaKYSOeWboQjvBrxOOyzWJaZ4mBYY/Rzja3TmTVGUm7f8dIgi', '3481146533@qq.com', 1, '男', '2000-05-24', '本科生', '3481146533', '12345678\nzxcvbnm');
INSERT INTO `user` VALUES (5, 'zero', '$2a$10$NJRO75OAdfcSk15X63tQ4eBrh7Yg9kyj3Z6xZTitwutfYdkA4CS5K', 'Yveltals@qq.com', 1, NULL, NULL, NULL, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 1, 2);
INSERT INTO `user_role` VALUES (6, 4, 1);
INSERT INTO `user_role` VALUES (7, 5, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

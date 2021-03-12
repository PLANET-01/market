/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : 127.0.0.1:3306
 Source Schema         : market

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 16/12/2020 22:59:04
*/

create database market default charset utf8 collate utf8_general_ci;
use market;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate`  (
  `orderID` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goodsID` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userID` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cmTime` datetime(0) NULL DEFAULT NULL,
  `stars` smallint(6) NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`orderID`) USING BTREE,
  INDEX `FK_用户的评论`(`userID`) USING BTREE,
  INDEX `FK_商品的评论`(`goodsID`) USING BTREE,
  CONSTRAINT `FK_商品的评论` FOREIGN KEY (`goodsID`) REFERENCES `goods` (`goodsID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_用户的评论` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_订单的评论` FOREIGN KEY (`orderID`) REFERENCES `order` (`orderID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluate
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goodsID` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ownerID` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `number` int(11) NULL DEFAULT NULL,
  `price` decimal(8, 2) NULL DEFAULT NULL,
  `submitTime` datetime(0) NULL DEFAULT NULL,
  `fromAddress` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`goodsID`) USING BTREE,
  INDEX `FK_销售`(`ownerID`) USING BTREE,
  CONSTRAINT `FK_销售` FOREIGN KEY (`ownerID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('000000000011607188755923', '00000000001', '计算机组成原理（第2版）', '书本 唐朔飞 高等教育出版社', 100, 45.00, '2020-12-06 11:19:16', '北京', '编辑推荐\r\n本书突出介绍计算机组成的一般原理，不结合任何具体机型，采用自顶向下的分析方法，详述计算机组成原理，使读者更容易形成计算机的整体概念。本书在编写思路上充分体现“以学生为中心”的教学理念。注重激发学生主动探索知识的欲望。全书各个篇章始末提出了各种悬念，从而激发学生主动探索答案的积极性。 \r\n内容简介\r\n本书是“十二五”普通高等教育本科*规划教材。本书第1版被列为“面向21世纪课程教材”，是教育部高等学校计算机科学与技术教学指导委员会组织编写的“体系结构—组成原理—微机技术”系列教材之一，是2005年国家精品课程主讲教材，于2002年获普通高等学校优秀教材二等奖。\r\n\r\n为了紧跟国际上计算机技术的新发展，本书对第1版各章节的内容进行了补充和修改，并增加了例题分析，以加深对各知识点的理解和掌握。本书通过对一台实际计算机的剖析，使读者更深入地理解总线是如何将计算机各大部件互连成整机的。\r\n\r\n全书共分为4篇，第1篇（第1、2章）介绍计算机的基本组成、发展及应用；第2篇（第3～5章）介绍系统总线、存储器（包括主存储器、高速缓冲存储器和辅助存储器）和输入输出系统；第3篇（第6～8章）介绍CPU的特性、结构和功能，包括计算机的算术逻辑单元、指令系统、指令流水、RISC技术及中断系统；第4篇（第9、10章）介绍控制单元的功能和设计，包括时序系统以及采用组合逻辑和微程序设计控制单元的设计思想与实现措施。每章后均附有思考题与习题。\r\n\r\n本书概念清楚，通俗易懂，书中举例力求与当代计算机技术相结合，可作为高等学校计算机专业教材，也可作为其他科技人员的参考书。\r\n\r\n作者简介\r\n唐朔飞，哈尔滨工业大学计算机科学与技术学院教授。2003年评为首届黑龙江省和哈尔滨工业大学教学名师，2006年获得第二届国家教学名师奖。长期从事计算机科学与技术的教学和研究工作。从教40多年来，给计算机专业27届4600余名学生讲授“计算机组成原理”课程。1986年获哈尔滨工业大学首届教学一等奖。面向21世纪课程教材《计算机组成原理》2002年获教育部“全国普通高等学校优秀教材二等奖”，以该课程为核心的“计算机组成原理”课程2005年被评为国家精品课程。唐朔飞教授主要研究计算机体系结构、并行处理。');
INSERT INTO `goods` VALUES ('000000000011607189319877', '00000000001', '管理运筹学', '书 徐辉，陈光辉，张杰', 50, 25.00, '2020-12-06 11:28:40', '山西', '本书系统讲解规划论中线性规划、运输问题、整数规划、目标规划和动态规划等的基本原理和方法，及其应用案例分析。详细介绍了图论中图与树的概念、最短路问题、网络最大流问题、网络最小费用最大流问题、中国邮递员问题，以及网络计划中网络图的绘制、关键路线和网络优化方法等及其应用案例分析，在不同决策准则下的不确定性决策问题的决策分析，以及在不同需求情况下的确定性和非确定性的存储策略问题，博弈论等。');
INSERT INTO `goods` VALUES ('000000000011607189398237', '00000000001', '普通逻辑学(第三版）', '书 王海传', 97, 35.81, '2020-12-06 11:29:58', '上海', '本书介绍了普通逻辑学的相关知识，包括判断与演绎推理；归纳推理、类比推理与假说；逻辑基本规律；论证与反驳等内容。');
INSERT INTO `goods` VALUES ('000000000011607189507236', '00000000001', '计量经济学', '书 庞皓 北京:科学出版社', 99, 40.54, '2020-12-06 11:31:47', '佛山', '本书介绍了计量经济学的基本理论、基本思想、基本方法及其应用。内容包括:简单线性回归模型、多元线性回归模型、多重共线性、异方差性等十二章。');
INSERT INTO `goods` VALUES ('000000000011607189614013', '00000000001', '高等数学.上册', '书 同济大学数学系编', 99, 56.45, '2020-12-06 11:33:34', '南京', '本书内容包括函数与极限、导数与微分、微分中值定理与导数的应用、不定积分、定积分及其应用、微分方程等。');
INSERT INTO `goods` VALUES ('000000000011607189738354', '00000000001', '平凡的世界', '书 中国青年出版社', 56, 33.33, '2020-12-06 11:35:38', '西安', '小说以陕北黄土高原双水村孙、田、金三家的命运为中心，反映了从“文革”后期到改革初期广阔的社会面貌。 　　第一部写1975年初农民子弟孙少平到原西县高中读书，他贫困，自尊；学习和劳动都好，与地主家庭出身的郝红梅互相爱怜，后来郝红梅却与家境优越的顾养民恋爱，少平又高考落榜，回乡生产。但他并没有消沉， 与县革委副主任田福军女儿田晓霞建立了友情，在晓霞帮助下关注着外部世界。少平的哥哥少安一直在家劳动，与村支书田福堂女儿，县城教师润叶是青梅竹马，却遭到田福堂反对。经过痛苦的煎熬，少安到山西找到了勤劳善良的秀莲，润叶也只得含泪与向前结婚。这时农村生活混乱，旱灾又火上加油，田福堂为加强自己威信,组织偷挖河坝与上游抢水，不料出了人命，为了“学大寨”，他好大喜功炸山修田叫人搬家又弄得天怒人怨。生活的航道已到了非改变不可的地步。 　　第二部写 1979年春十一届三中全会后百废待兴又矛盾重重，田福堂连夜召开支部会抵制责任制，孙少安却领导生产队率先实行接着也就在全村推广了责任制。少安又进城 拉砖，用赚的钱建窑烧砖，成了公社的“冒尖户”。少平青春的梦想和追求也激励着他到外面去“闯荡世界”，他从漂泊的揽工汉成为正式的建筑工人，最后又获得 了当煤矿工人的好机遇，他的女友晓霞从师专毕业后到省报当了记者，他们相约两年后再相会。润叶远离她不爱的丈夫到团地委工作，引起钟情痴心的丈夫酒后开车致残，润叶受到内疚回到丈夫身边，开始幸福生活。她的弟弟润生也已长大成人，他在异乡与命运坎坷的郝红梅邂逅，终于两人结为夫妻。往昔主宰全村命运的强人田福堂，不仅对新时期的变革抵触，同时也为女儿、儿子的婚事窝火，加上病魔缠身，弄得焦头烂额。 　　第三部写1982年秋少平到了煤矿，尽心尽力干活，成了一 名优秀工人。少安的砖窑也有了很大发展，他决定贷款扩建机器制砖，不料因技师根本不懂技术，砖窑蒙受很大损失，后来 在朋友和县长的帮助下再度奋起。润叶也生活幸福，生了个胖儿子，润生和郝红梅的婚事也终于得到了父母的承认，并添了可爱的女儿。但是祸不单行，少安的妻子秀莲，在欢庆由他家出资两万元扩建的小学会上口吐鲜血，确诊肺癌。晓霞在抗洪采访中为抢救灾民光荣献身。少平在一次事故中为救护徒弟也受了重伤。但他们并没有被不幸压垮，少平从医院出来，又充满信心地回到了矿山，迎接他的又将是怎样的生活呢？……　');
INSERT INTO `goods` VALUES ('000000000011607189847423', '00000000001', '白夜行', '书 东野圭吾著 刘姿君译', 106, 48.32, '2020-12-06 11:37:27', '青岛', '将无望却坚守的凄凉爱情和执著而缜密的冷静推理完美结合,被众多“东饭”视作东野圭吾作品中的无冕之王,被称为东野笔下“最绝望的念想、最悲恸的守望”,出版之后引起巨大轰动,使东野圭吾成为天王级作家。');
INSERT INTO `goods` VALUES ('000000000011607189949457', '00000000001', '艺术学概论', '书 北京大学出版社', 423, 55.56, '2020-12-06 11:39:09', '深圳', '本书内容分三编：上编为艺术总论，系统论述了艺术的本质与特征、艺术的起源、艺术的功能等；中编为艺术种类，把艺术分为实用艺术、造型艺术、表情艺术、综合艺术、语言艺术五大类；下编为艺术系统，对艺术创作、艺术作品中、艺术鉴赏进行了全面介绍。');
INSERT INTO `goods` VALUES ('000000000011607190024097', '00000000001', '国家公务员制度', '书', 109, 30.22, '2020-12-06 11:40:24', '广州', '本书以历史唯物主义为指导，以《公务员法》为依据，系统完整地阐述了我国公务员制度的概念、特点和基本内容，及时全面地体现了我国公务员制度的发展历程，并通过与国外主要国家公务员制度比较的方式，帮助读者完整、准确地了解和掌握公务员制度的基本理论和知识。');
INSERT INTO `goods` VALUES ('000000000011607190079776', '00000000001', '中级翻译教程', '书', 99, 45.51, '2020-12-06 11:41:20', '广州', '本书除“翻译导言”外全部以翻译练习为核心，围绕着这些练习做文章。全书由16个单元组成，每一单元包括两篇翻译练习及其词汇提示、注解、参考译文和相关翻译技巧五个部分。');
INSERT INTO `goods` VALUES ('000000000011607190211705', '00000000001', '西方经济学', '书 组编教育部高教司', 103, 20.51, '2020-12-06 11:43:32', '杭州', '本书介绍西方主流经济学的理论框架并加以简要的评论，以便达到“洋为中用”的目的，而与此同时，又能避免它可能带来的不良的副作用。');
INSERT INTO `goods` VALUES ('000000000021607190690744', '00000000002', '正义论', '书 (美)罗尔斯(Rawls,J.)著', 55, 12.23, '2020-12-06 11:51:31', '广州', '本书充分表达作者严密的条理一贯的思想体系-即一种继承西方契约论的传统,试图代替现行功利主义的、有关社会基本结构的正义理论。');
INSERT INTO `goods` VALUES ('000000000021607190788494', '00000000002', '数学分析(第2版)(上册)', '书 陈纪修, 於崇华, 金路', 99, 87.11, '2020-12-06 11:53:08', '广州', '上册包括: 集合与映射、数列极限、函数极限与连续函数、微分、微分中值定理及其应用、不定积分、定积分、反常积分等八章。');
INSERT INTO `goods` VALUES ('000000000021607190851904', '00000000002', '西窗法雨.2版', '刘星著', 12, 31.13, '2020-12-06 11:54:12', '深圳', '本书以亲切家常、平和幽默的手法漫谈西方法律文化,对似乎是信手拈来的法律现象材料进行点拨评说,说的是西方法律文化现象,却时时启蒙着中国人的法律意识和法治观念,不着痕迹地调动着读者的思维,去思考中国的问题。');
INSERT INTO `goods` VALUES ('000000000021607190937136', '00000000002', '会计信息系统原理与应用', '李勉，张依农，王新玲编著', 150, 15.21, '2020-12-06 11:55:37', '广州', '本书共分14章，在第1章中简要介绍了会计信息系统的相关概念、发展历程、用友ERP-U8的主要功能及课程的学习建议。在第2～14章以用友ERP-U8 872为蓝本，分别介绍了构成会计信息系统最重要和最基础的系统管理、企业应用平台、总账、报表和存货子系统，内容主要涉及模块的基本功');
INSERT INTO `goods` VALUES ('000000000021607191036016', '00000000002', '半生缘', '张爱玲 书', 216, 30.44, '2020-12-06 11:57:16', '广州', '张爱玲的改写工作历时近一年半终于完成。新长篇先以《惘然记》为题连载于一九六七年二月至七月台北《皇冠》月刊。一九六九年三月，新长篇作为张爱玲作品系列第六种，由治湾皇冠出版社出版，书名确定为《半生缘》。《半生缘》对《十八春》的改写，凸现了张爱玲新的艺术构思，是张爱玲式“倾城之恋美学”的灿烂重现，虽与《十八春》同源共根，结出的却是不同的更为艳异的果实。 本书所收的《半生缘》据初版本编入，并作了必要的校勘。作为有鲜明个人风格的作家，张爱玲的小说用词特别讲究，除了恰到好处地运用方言，还有不少与当下行文规范不同的独到用法。为了保持张爱玲小说文字的原貌和丰富性，只要不是明显的错漏，本书一律不作改动，特此说明。');
INSERT INTO `goods` VALUES ('000000000021607191095148', '00000000002', '三体', '刘慈欣著 书', 23, 43.00, '2020-12-06 11:58:15', '广州', '文化大革命如火如荼进行的同时，军方探寻外星文明的绝秘计划“红岸工程”取得了突破性进展。但在按下发射键的那一刻，历经劫难的叶文洁没有意识到，她彻底改变了人类的命运。 地球文明向宇宙发出的第一声啼鸣，以太阳为中心，以光速向宇宙深处飞驰…… 四光年外，“三体文明”正苦苦挣扎——三颗无规则运行的太阳主导下的百余次毁灭与重生逼迫他们逃离母星。而恰在此时，他们接收到了地球发来的信息。 在运用超技术锁死地球人的基础科学之后，三体人庞大的宇宙舰队开始向地球进发……人类的末日悄然来临。');
INSERT INTO `goods` VALUES ('000000000021607191175066', '00000000002', '苏菲的世界', '(挪威) 乔斯坦·贾德著', 454, 45.00, '2020-12-06 11:59:35', '广州', '本书可以当作哲学启蒙书来阅读，对于未曾修习哲学概论者而言，本书是最佳的入门读物，对于修过此门课程但已忘却大半的人而言，本书有助他们重新温习。');
INSERT INTO `goods` VALUES ('000000000021607191225441', '00000000002', '皮囊', '蔡崇达著', 65, 34.00, '2020-12-06 12:00:25', '广州', '本书是作家蔡崇达的首部个人散文集。以人物肖像画的方式描写了福建渔业小镇的风土人情和时代变迁，阐述了作者对父母、家乡的缅怀，对朋友命运的关切。文集风格沉稳，表达了“80后”这一代理想膨胀却又深感现实骨感而无处安身的青年人对自己命运的深切思考，有较高的出版价值。');
INSERT INTO `goods` VALUES ('000000000021607191294608', '00000000002', '资本论', '马克思著', 86, 43.00, '2020-12-06 12:01:35', '广州', '现在作者把这部著作的第一卷交给读者。这部著作是作者1859年发表的《政治经济学批判》的续篇。 　　 前书的内容已经概述在这一卷的第一章中。这样做不仅是为了联贯和完整，叙述方式也改进了。在情况许可的范围内，前书只是略略提到的许多论点，这里都作了进一步的阐述；相反地，前书已经详细阐述的论点，这里只略略提到。关于价值理论和货币理论的历史的部分，现在自然完全删去了。但是前书的读者可以在本书第一章的注释中，找到有关这两种理论的历史的新材料。 　　 万事开头难，每门科学都是如此。所以本书第一章，特别是分析商品的部分，是最难理解的。其中对价值实体和价值量的分析，作者已经尽可能地做到通俗易懂。以货币形式为完成形态的价值形式，是极无内容和极其简单的。然而，两干多年来人类智慧在这方面进行探讨的努力，并未得到什么结果，而对更有内容和更复杂的形式的分析，却至少已接近于成功。为什么会这样呢？因为已经发育的身体比身体的细胞容易研究些。并且，分析经济形式，既不能用显微镜，也不能用化学试剂。二者都必须用抽象力来代替。而对资产阶级社会说来，劳动产品的商品形式，或者商品的价值形式，就是经济的细胞形式。在浅薄的人看来，分析这种形式好像是斤斤于一些琐事。这的确是琐事，但这是显微解剖学所要做的那种琐事。 　　 因此，除了价值形式那一部分外，不能说这本书难懂。当然，作者指的是那些想学到一些新东西、因而愿意自己思考的读者。');
INSERT INTO `goods` VALUES ('000000000021607191362780', '00000000002', '中国财税史', '刘孝诚主编', 87, 43.00, '2020-12-06 12:02:43', '广州', '《中国财税史》内容简介：中国经济发展日新月异，经济学界的教材竞争也在日益加剧。在国外，不少大学教材是由经济学大家撰写的，如萨缪尔森的《经济学》，再版十余次，被翻译成各国文字，行销全球，堪称成功教材的典范。不过，国际知名的经济学教材往往是介绍经济学原理的，一旦涉及应用经济学领域，就需要结合各国国情编写，以便更紧密地贴近学生所处的时空。这就是我们推出这套财税系列教材的初衷。');
INSERT INTO `goods` VALUES ('000000000021607191451084', '00000000002', '乌合之众——大众心理研究', '(法)古斯塔夫·勒庞著', 87, 32.54, '2020-12-06 12:04:11', '广州', '本书是解析群体心理的经典名著,内容包括:群体心理、群体的意见与信念、不同群体的分类及其特点三卷。');
INSERT INTO `goods` VALUES ('137155179751607186465771', '13715517975', '计算机网络', '书本 谢希仁 电子工业出版社', 88, 45.00, '2020-12-06 09:41:06', '广州', 'null');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `orderID` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `buyerID` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sellerID` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goodsID` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `buyNumber` int(11) NULL DEFAULT NULL,
  `buyPrice` decimal(8, 2) NULL DEFAULT NULL,
  `totalMoney` decimal(8, 2) NULL DEFAULT NULL,
  `orderStatus` smallint(6) NULL DEFAULT NULL,
  `startTime` datetime(0) NULL DEFAULT NULL,
  `endTime` datetime(0) NULL DEFAULT NULL,
  `toAddress` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expressID` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderID`) USING BTREE,
  INDEX `FK_销售者`(`sellerID`) USING BTREE,
  INDEX `FK_购买者`(`buyerID`) USING BTREE,
  INDEX `FK_被购买商品`(`goodsID`) USING BTREE,
  CONSTRAINT `FK_被购买商品` FOREIGN KEY (`goodsID`) REFERENCES `goods` (`goodsID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_购买者` FOREIGN KEY (`buyerID`) REFERENCES `user` (`userID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_销售者` FOREIGN KEY (`sellerID`) REFERENCES `user` (`userID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userID` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nickname` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `registerTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('00000000001', '甲', '00000000001', '北京', '2020-12-06 00:38:01');
INSERT INTO `user` VALUES ('00000000002', '乙', '00000000002', '上海', '2020-12-06 00:38:02');
INSERT INTO `user` VALUES ('00000000003', '丙', '00000000003', '广州', '2020-12-06 00:38:03');
INSERT INTO `user` VALUES ('00000000004', '丁', '00000000004', '深圳', '2020-12-06 00:38:04');
INSERT INTO `user` VALUES ('00000000005', '戊', '00000000005', '武汉', '2020-12-06 00:38:05');
INSERT INTO `user` VALUES ('00000000006', '己', '00000000006', '成都', '2020-12-06 00:38:06');
INSERT INTO `user` VALUES ('00000000007', '庚', '00000000007', '南京', '2020-12-06 00:38:07');
INSERT INTO `user` VALUES ('00000000008', '辛', '00000000008', '杭州', '2020-12-06 00:38:08');
INSERT INTO `user` VALUES ('00000000009', '壬', '00000000009', '重庆', '2020-12-06 00:38:09');
INSERT INTO `user` VALUES ('00000000010', '癸', '00000000010', '西安', '2020-12-06 00:38:10');
INSERT INTO `user` VALUES ('13715517975', '彭海涛', '13715517975', '广东省广州市海珠区官洲街道广东财经大学', '2020-12-06 08:00:00');

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet`  (
  `userID` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `balance` decimal(8, 2) NULL DEFAULT NULL,
  `payPassword` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`userID`) USING BTREE,
  CONSTRAINT `FK_拥有2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallet
-- ----------------------------
INSERT INTO `wallet` VALUES ('00000000001', 100.00, '00000000001');
INSERT INTO `wallet` VALUES ('00000000002', 100.00, '00000000002');
INSERT INTO `wallet` VALUES ('00000000003', 100.00, '00000000003');
INSERT INTO `wallet` VALUES ('00000000004', 100.00, '00000000004');
INSERT INTO `wallet` VALUES ('00000000005', 100.00, '00000000005');
INSERT INTO `wallet` VALUES ('00000000006', 100.00, '00000000006');
INSERT INTO `wallet` VALUES ('00000000007', 100.00, '00000000007');
INSERT INTO `wallet` VALUES ('00000000008', 100.00, '00000000008');
INSERT INTO `wallet` VALUES ('00000000009', 100.00, '00000000009');
INSERT INTO `wallet` VALUES ('00000000010', 100.00, '00000000010');
INSERT INTO `wallet` VALUES ('13715517975', 100.00, '13715517975');

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `createWallet`;

CREATE TRIGGER `createWallet` AFTER INSERT ON `user` FOR EACH ROW begin
    insert into wallet values(new.userID, 0, new.password);
end;

SET FOREIGN_KEY_CHECKS = 1;

-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: ali.vickey.me    Database: popular
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pop_comments`
--

DROP TABLE IF EXISTS `pop_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_post_id` int(11) NOT NULL,
  `comment_author` tinytext,
  `comment_author_email` varchar(100) DEFAULT NULL,
  `comment_author_url` varchar(100) DEFAULT NULL,
  `comment_date` datetime DEFAULT NULL,
  `comment_content` varchar(255) NOT NULL,
  `comment_parent` int(11) DEFAULT NULL,
  `comment_approved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`comment_id`),
  KEY `comment_post_idx` (`comment_post_id`),
  CONSTRAINT `comment_post` FOREIGN KEY (`comment_post_id`) REFERENCES `pop_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_comments`
--

LOCK TABLES `pop_comments` WRITE;
/*!40000 ALTER TABLE `pop_comments` DISABLE KEYS */;
INSERT INTO `pop_comments` VALUES (1,1,'Tester','Test@test.test','test.test','2017-05-11 21:00:00','测试评论',0,1),(2,1,'Tester','Test@test.test','test.test','2017-05-11 21:00:00','测试测试评论',1,1),(3,1,'t2','t2@test.test','test2.test','2017-05-11 21:00:00','测试评论2',0,1),(4,1,'t1','t1@te.com','baidu.com','2017-05-15 03:03:03','1123',1,1),(5,1,'TEst123','t1@te.com','baidu.com','2017-05-15 03:06:08','123',3,1);
/*!40000 ALTER TABLE `pop_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_links`
--

DROP TABLE IF EXISTS `pop_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_links` (
  `link_id` int(11) NOT NULL AUTO_INCREMENT,
  `link_url` varchar(100) NOT NULL,
  `link_name` varchar(100) NOT NULL,
  `link_image` varchar(255) DEFAULT NULL,
  `link_description` varchar(255) DEFAULT NULL,
  `link_visible` tinyint(1) NOT NULL DEFAULT '1',
  `link_user_id` int(11) DEFAULT NULL,
  `link_rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`link_id`),
  KEY `link_user_idx` (`link_user_id`),
  CONSTRAINT `link_user` FOREIGN KEY (`link_user_id`) REFERENCES `pop_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_links`
--

LOCK TABLES `pop_links` WRITE;
/*!40000 ALTER TABLE `pop_links` DISABLE KEYS */;
INSERT INTO `pop_links` VALUES (1,'http://github.com/vickey94','GitHub','/img/common/github.png',NULL,1,1,2),(2,'http://vickey.me','About','/img/common/about.png',NULL,1,1,1),(3,'/admin/login','Admin','/img/common/admin.png',NULL,1,1,10);
/*!40000 ALTER TABLE `pop_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_old_posts`
--

DROP TABLE IF EXISTS `pop_old_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_old_posts` (
  `old_post_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `post_date` datetime NOT NULL,
  `post_title` varchar(100) DEFAULT NULL,
  `post_content` longtext,
  `post_excerpt` longtext,
  PRIMARY KEY (`post_id`),
  CONSTRAINT `old_post_post_id` FOREIGN KEY (`post_id`) REFERENCES `pop_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_old_posts`
--

LOCK TABLES `pop_old_posts` WRITE;
/*!40000 ALTER TABLE `pop_old_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `pop_old_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_options`
--

DROP TABLE IF EXISTS `pop_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_options` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `option_name` varchar(255) NOT NULL,
  `option_value` varchar(255) DEFAULT NULL,
  `option_user_id` int(11) NOT NULL,
  PRIMARY KEY (`option_id`),
  KEY `option_user_idx` (`option_user_id`),
  CONSTRAINT `option_user` FOREIGN KEY (`option_user_id`) REFERENCES `pop_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_options`
--

LOCK TABLES `pop_options` WRITE;
/*!40000 ALTER TABLE `pop_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `pop_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_posts`
--

DROP TABLE IF EXISTS `pop_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_posts` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_user_id` int(11) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `post_title` varchar(100) DEFAULT NULL,
  `post_content` longtext,
  `post_excerpt` longtext,
  `post_term_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) NOT NULL COMMENT '1  发布\n0  草稿\n-1 回收站',
  `post_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `post_user_idx` (`post_user_id`),
  KEY `post_term_idx` (`post_term_id`),
  CONSTRAINT `post_term` FOREIGN KEY (`post_term_id`) REFERENCES `pop_terms` (`term_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `post_user` FOREIGN KEY (`post_user_id`) REFERENCES `pop_users` (`user_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_posts`
--

LOCK TABLES `pop_posts` WRITE;
/*!40000 ALTER TABLE `pop_posts` DISABLE KEYS */;
INSERT INTO `pop_posts` VALUES (1,1,'2017-05-16 12:00:00','Hello,Popular','欢迎使用Popular博客系统。这是系统测试文章。你可以编辑或者删除它，然后开始您的博客！','欢迎使用Popular博客系统。这是系统测试文章。',1,'1',0),(3,1,'2017-05-14 22:00:00','机器学习入门——浅谈神经网络（转载）','<div >\n<p>neural network </p>\n<div>\n<p>文章转载自<a href=\"http://tieba.baidu.com/p/3013551686?see_lz=1&amp;qq-pf-to=pcqq.c2c\">贴吧</a> 由于作者写的非常浅显易懂，所以转载，感谢作者！根据评论对文章有所更改</p>\n</div>\n<p>先从<strong>回归(Regression)</strong>问题说起。我在本吧已经看到不少人提到如果想实现强AI，就必须让机器学会观察并总结规律的言论。具体地说，要让机器观察什么是圆的，什么是方的，区分各种颜色和形状，然后根据这些特征对某种事物进行分类或预测。其实这就是回归问题。<br>\n如何解决回归问题？我们用眼睛看到某样东西，可以一下子看出它的一些基本特征。可是计算机呢？它看到的只是一堆数字而已，因此要让机器从事物的特征中找到规律，其实是一个如何在数字中找规律的问题。</p>\n<p><img width=\"507\" height=\"291\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591219.jpg\"></p>\n<p>例：假如有一串数字，已知前六个是1、3、5、7，9，11，请问第七个是几？<br>\n你一眼能看出来，是13。对，这串数字之间有明显的数学规律，都是奇数，而且是按顺序排列的。<br>\n那么这个呢？前六个是0.14、0.57、1.29、2.29、3.57、5.14，请问第七个是几？<br>\n这个就不那么容易看出来了吧！我们把这几个数字在坐标轴上标识一下，可以看到如下图形：<br>\n<img width=\"171\" height=\"120\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591232.gif\"><br>\n用曲线连接这几个点，延着曲线的走势，可以推算出第七个数字——7。<br>\n由此可见，回归问题其实是个<strong>曲线拟合(Curve Fitting)</strong>问题。那么究竟该如何拟合？机器不可能像你一样，凭感觉随手画一下就拟合了，它必须要通过某种算法才行。</p>\n<p><span id=\"more-548\"></span>假设有一堆按一定规律分布的<strong>样本点</strong>，下面我以拟合直线为例，说说这种算法的原理。</p>\n<p>其实很简单，先随意画一条直线，然后不断旋转它。每转一下，就分别计算一下每个样本点和直线上对应点的距离(误差)，求出所有点的误差之和。这样不断旋转，当误差之和达到最小时，停止旋转。说得再复杂点，在旋转的过程中，还要不断平移这条直线，这样不断调整，直到误差最小时为止。这种方法就是著名的<strong>梯度下降法(Gradient Descent)</strong>。为什么是梯度下降呢？在旋转的过程中，当误差越来越小时，旋转或移动的量也跟着逐渐变小，当误差小于某个很小的数，例如0.0001时，我们就可以收工<strong>(收敛, Converge)</strong>了。啰嗦一句，如果随便转，转过头了再往回转，那就不是梯度下降法。</p>\n<p><a title=\"\" class=\"fancybox\" href=\"/img/post/20170516-1/other-1464591241.gif\" rel=\"article0\"><img width=\"180\" height=\"117\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591241.gif\"><br>\n我们知道，直线的公式是y=kx+b，k代表斜率，b代表偏移值(y轴上的截距)。也就是说，k可以控制直线的旋转角度，b可以控制直线的移动。强调一下，<strong>梯度下降法的实质是不断的修改k、b这两个参数值，使最终的误差达到最小</strong>。<br>\n求误差时使用 累加(直线点-样本点)^2，这样比直接求差距 累加(直线点-样本点) 的效果要好。这种利用最小化误差的平方和来解决回归问题的方法叫<strong>最小二乘法(Least Square Method)</strong>。</p>\n<p><img width=\"259\" height=\"125\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591254.gif\"><br>\n问题到此使似乎就已经解决了，可是我们需要一种适应于各种曲线拟合的方法，所以还需要继续深入研究。<br>\n我们根据拟合直线不断旋转的角度(斜率)和拟合的误差画一条函数曲线，如图：<br>\n<img width=\"192\" height=\"145\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591268.gif\"><br>\n从图中可以看出，误差的函数曲线是个二次曲线，凸函数(下凸, Convex)，像个碗的形状，最小值位于碗的最下端。如果在曲线的最底端画一条切线，那么这条切线一定是水平的，在图中可以把横坐标轴看成是这条切线。如果能求出曲线上每个点的切线，就能得到切线位于水平状态时，即<strong>切线斜率等于0</strong>时的坐标值，这个坐标值就是我们要求的误差最小值和最终的拟合直线的最终斜率。<br>\n这样，梯度下降的问题集中到了切线的旋转上。切线旋转至水平时，切线斜率=0，误差降至最小值。</p>\n<p><img width=\"180\" height=\"136\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591277.gif\"><br>\n切线每次旋转的幅度与上次切线的斜率的关系叫做<strong>学习率(Learning Rate)</strong>，加大学习率会加快拟合速度，但是如果调得太大会导致切线旋转过度而无法收敛。</p>\n<p>注意：对于凹凸不平的误差函数曲线，梯度下降时有可能陷入<strong>局部最优解</strong>。下图的曲线中有两个坑，切线有可能在第一个坑的最底部趋于水平。<br>\n<img width=\"187\" height=\"111\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591287.gif\"><br>\n<strong>微分</strong>就是专门求曲线切线的工具，求出的切线斜率叫做<strong>导数(Derivative)</strong>，用dy/dx或f\'(x)表示。扩展到多变量的应用，如果要同时求多个曲线的切线，那么其中某个切线的斜率就叫<strong>偏导数(Partial Derivative)</strong>，用∂y/∂x表示，∂读“偏(partial)”。由于实际应用中，我们一般都是对多变量进行处理，我在后面提到的导数也都是指偏导数。</p>\n<hr>\n<p>以上是<strong>线性回归(Linear Regression)</strong>的基本内容，以此方法为基础，把直线公式改为曲线公式，还可以扩展出二次回归、三次回归、多项式回归等多种曲线回归。下图是Excel的回归分析功能。</p>\n<p><img width=\"417\" height=\"354\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464592860.jpg\"><br>\n在多数情况下，曲线回归会比直线回归更精确，但它也增加了拟合的复杂程度。<br>\n<img width=\"281\" height=\"117\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464592868.gif\"></p>\n<p>直线方程y=kx+b改为二次曲线方程y=ax^2+bx+c时，<strong>参数(Parameter)</strong>由2个(分别是k、b)变为3个(分别是a、b、c)，<strong>特征(Feature)</strong>由1个(x)变为2个(x^2和x)。三次曲线和复杂的多项式回归会增加更多的参数和特征。</p>\n<p>前面讲的是总结一串数字的规律，现实生活中我们往往要根据多个特征(多串数字)来分析一件事情，每个原始特征我们都看作是一个<strong>维度(Dimension)</strong>。例如一个学生的学习成绩好坏要根据语文、数学、英语等多门课程的分数来综合判断，这里每门课程都是一个维度。当使用二次曲线和多变量(多维)拟合的情况下，特征的数量会剧增，特征数=维度^2/2 这个公式可以大概计算出特征增加的情况，例如一个100维的数据，二次多项式拟合后，特征会增加到100*100/2=5000个。</p>\n<p>下面是一张50*50像素的灰度图片，如果用二次多项式拟合的话，它有多少个特征呢？——大约有3百万！<br><img width=\"50\" height=\"50\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464592877.jpg\"></p>\n<p>它的维度是50*50=2500，特征数=2500*2500/2=3,125,000。如果是彩色图片，维度会增加到原来的3倍，那么特征数将增加到接近3千万了！<br><img width=\"289\" height=\"207\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464592889.jpg\"></p>\n<p>这么小的一张图片，就有这么巨大的特征量，可以想像一下我们的数码相机拍下来的照片会有多大的特征量！而我们要做的是从十万乃至亿万张这样的图片中找规律，这可能吗？<br>\n很显然，前面的那些回归方法已经不够用了，我们急需找到一种数学模型，能够在此基础上不断减少特征，降低维度。</p>\n<p>于是，“<strong>人工神经网络(ANN, Artificial Neural Network)</strong>”就在这样苛刻的条件下闪亮登场了，神经科学的研究成果为机器学习领域开辟了广阔的道路。</p>\n<p>&nbsp;</p>\n<div class=\"d_post_content j_d_post_content clearfix\" id=\"post_content_49702620019\">\n<p>神经元</p>\n<p>有一种假说：“智能来源于单一的算法(One Learning Algorithm)”。如果这一假说成立，那么利用单一的算法(神经网络)处理世界上千变万化的问题就成为可能。我们不必对万事万物进行编程，只需采用以不变应万变的策略即可。有越来越多的证据证明这种假说，例如人类大脑发育初期，每一部分的职责分工是不确定的，也就是说，人脑中负责处理声音的部分其实也可以处理视觉影像。<br><img width=\"523\" height=\"315\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593183.jpg\"></p>\n<p>下图是单个<strong>神经元(Neuron)</strong>，或者说一个脑细胞的生理结构：<br>\n<img width=\"568\" height=\"343\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593192.jpg\"></p>\n<p>下面是单个神经元的数学模型，可以看出它是生理结构的简化版，模仿的还挺像：<br>\n<img width=\"275\" height=\"118\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593202.gif\"><br>\n解释一下：+1代表<strong>偏移值(偏置项, Bias Units)</strong>；X1,X2,X2代表<strong>初始特征</strong>；w0,w1,w2,w3代表<strong>权重(Weight)</strong>，即<strong>参数</strong>，是特征的缩放倍数；特征经过缩放和偏移后全部累加起来，此后还要经过一次激活运算然后再输出。激活函数有很多种，后面将会详细说明。</p>\n<p>举例说明：<img width=\"442\" height=\"103\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593209.gif\"><br>\n(原作者图错，55/5=11)</p>\n<p>X1*w1+X2*w2+…+Xn*wn这种计算方法称为<strong>加权求和(Weighted Sum)</strong>法，此方法在线性代数里极为常用。加权求和的标准数学符号是，<img width=\"53\" height=\"42\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593220.gif\">不过为了简化，我在教程里使用女巫布莱尔的符号<img width=\"30\" height=\"31\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593230.gif\">表示，刚好是一个加号和一个乘号的组合。</p>\n<p>这个数学模型有什么意义呢？下面我对照前面那个 y=kx+b 直线拟合的例子来说明一下。<br><img width=\"232\" height=\"80\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593750.gif\"><br>\n这时我们把激活函数改为<strong>Purelin(45度直线)</strong>，Purelin就是y=x，代表保持原来的值不变。<br>\n这样输出值就成了 Y直线点 = b + X直线点*k，即y=kx+b。看到了吧，只是换了个马甲而已，还认的出来吗？下一步，对于每个点都进行这种运算，利用Y直线点和Y样本点计算误差，把误差累加起来，不断地更新b、k的值，由此不断地移动和旋转直线，直到误差变得很小时停住(收敛)。这个过程完全就是前面讲过的梯度下降的线性回归。</p>\n<p>一般直线拟合的精确度要比曲线差很多，那么使用神经网络我们将如何使用曲线拟合？答案是使用非线性的激活函数即可，最常见的激活函数是<strong>Sigmoid(S形曲线)</strong>，Sigmoid有时也称为<strong>逻辑回归(Logistic Regression)</strong>，简称<strong>logsig</strong>。logsig曲线的公式如下：<br><img width=\"199\" height=\"52\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593760.gif\"><br>\n还有一种S形曲线也很常见到，叫<strong>双曲正切函数(tanh)</strong>，或称<strong>tansig</strong>，可以替代logsig。<img width=\"206\" height=\"49\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593779.gif\"><br>\n下面是它们的函数图形，从图中可以看出logsig的数值范围是0~1，而tansig的数值范围是-1~1。<br><img width=\"265\" height=\"123\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464593926.gif\"></p>\n<hr>\n<p>自然常数e</p>\n<p>公式中的<strong>e</strong>叫<strong>自然常数</strong>，也叫<strong>欧拉数</strong>，<strong>e=2.71828…</strong>。e是个很神秘的数字，它是“自然律”的精髓，其中暗藏着自然增长的奥秘，它的图形表达是旋涡形的螺线。<br>\n<img width=\"424\" height=\"424\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464611727.jpg\"></p>\n<p>融入了e的螺旋线，在不断循环缩放的过程中，可以完全保持它原有的弯曲度不变，就像一个无底的黑洞，吸进再多的东西也可以保持原来的形状。这一点至关重要！它可以让我们的数据在经历了多重的Sigmoid变换后仍维持原先的比例关系。</p>\n<p>e是怎么来的？e = 1 + 1/1! + 1/2! + 1/3! + 1/4! + 1/5! + 1/6! + 1/7! + … = 1 + 1 + 1/2 + 1/6 + 1/24 + 1/120+ … ≈ 2.71828 (!代表阶乘，3!=1*2*3=6)</p>\n<p>再举个通俗点的例子：从前有个财主，他特别贪财，喜欢放债。放出去的债年利率为100%，也就是说借1块钱，一年后要还给他2块钱。有一天，他想了个坏主意，要一年算两次利息，上半年50%，下半年50%，这样上半年就有1块5了，下半年按1块5的50%来算，就有1.5/2=0.75元，加起来一年是：上半年1.5+下半年0.75=2.25元。用公式描述，就是(1+50%)(1+50%)=(1+1/2)^2=2.25元。可是他又想，如果按季度算，一年算4次，那岂不是更赚？那就是(1+1/4)^4=2.44141，果然更多了。他很高兴，于是又想，那干脆每天都算吧，这样一年下来就是(1+1/365)^365=2.71457。然后他还想每秒都算，结果他的管家把他拉住了，说要再算下去别人都会疯掉了。不过财主还是不死心，算了很多年终于算出来了，当x趋于无限大的时候，e=(1+1/x)^x≈ 2.71828，结果他成了数学家。</p>\n<p>e在微积分领域非常重要，e^x的导数依然是e^x，自己的导数恰好是它自己，这种巧合在实数范围内绝无仅有。<br><img width=\"465\" height=\"126\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464611732.jpg\"><br>\n一些不同的称呼：<br>\n<img width=\"352\" height=\"133\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464611736.gif\"></p>\n<p>e^x和e^-x的图形是对称的；ln(x)是e^x的逆函数，它们呈45度对称。<a title=\"\" class=\"fancybox\" href=\"/img/post/20170516-1/other-1464611754.gif\" rel=\"article0\"><img width=\"255\" height=\"192\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464611754.gif\"></p>\n<p>&nbsp;</p>\n<p>神经网络</p>\n<p>好了，前面花了不少篇幅来介绍激活函数中那个暗藏玄机的e，下面可以正式介绍神经元的网络形式了。<br>\n下图是几种比较常见的网络形式：<br><img width=\"367\" height=\"345\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464612065.jpg\"></p>\n<p>– 左边蓝色的圆圈叫“<strong>输入层</strong>”，中间橙色的不管有多少层都叫“<strong>隐藏层</strong>”，右边绿色的是“<strong>输出层</strong>”。<br>\n– 每个圆圈，都代表一个神经元，也叫<strong>节点(Node)</strong>。<br>\n– 输出层可以有多个节点，多节点输出常常用于分类问题。<br>\n– 理论证明，任何多层网络可以用三层网络近似地表示。<br>\n– 一般凭经验来确定隐藏层到底应该有多少个节点，在测试的过程中也可以不断调整节点数以取得最佳效果。</p>\n<p>计算方法：<br>\n<img width=\"346\" height=\"246\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464612070.jpg\"></p>\n<p>– 虽然图中未标识，但必须注意每一个箭头指向的连线上，都要有一个权重(缩放)值。<br>\n– 输入层的每个节点，都要与的隐藏层每个节点做点对点的计算，计算的方法是加权求和+激活，前面已经介绍过了。(图中的红色箭头指示出某个节点的运算关系)<br>\n– 利用隐藏层计算出的每个值，再用相同的方法，和输出层进行计算。<br>\n– 隐藏层用都是用Sigmoid作激活函数，而输出层用的是Purelin。这是因为Purelin可以保持之前任意范围的数值缩放，便于和样本值作比较，而Sigmoid的数值范围只能在0~1之间。<br>\n– 起初输入层的数值通过网络计算分别传播到隐藏层，再以相同的方式传播到输出层，最终的输出值和样本值作比较，计算出误差，这个过程叫<strong>前向传播(Forward Propagation)</strong>。</p>\n<p>前面讲过，使用梯度下降的方法，要不断的修改k、b两个参数值，使最终的误差达到最小。神经网络可不只k、b两个参数，事实上，网络的每条连接线上都有一个权重参数，如何有效的修改这些参数，使误差最小化，成为一个很棘手的问题。从人工神经网络诞生的60年代，人们就一直在不断尝试各种方法来解决这个问题。直到80年代，误差反向传播算法(BP算法)的提出，才提供了真正有效的解决方案，使神经网络的研究绝处逢生。<br><img width=\"380\" height=\"144\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464612215.jpg\"><br>\nBP算法是一种计算偏导数的有效方法，它的基本原理是：利用前向传播最后输出的结果来计算误差的偏导数，再用这个偏导数和前面的隐藏层进行加权求和，如此一层一层的向后传下去，直到输入层(不计算输入层)，最后利用每个节点求出的偏导数来更新权重。<br><img width=\"328\" height=\"248\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464612219.jpg\"><br>\n为了便于理解，后面我一律用“<strong>残差(error term)</strong>”这个词来表示<strong>误差的偏导数</strong>。</p>\n<p>输出层→隐藏层：残差 = -(输出值-样本值) * 激活函数的导数<br>\n隐藏层→隐藏层：残差 = (右层每个节点的残差加权求和)* 激活函数的导数</p>\n<p>如果输出层用Purelin作激活函数，Purelin的导数是1，输出层→隐藏层：残差 = -(输出值-样本值)</p>\n<p>如果用Sigmoid(logsig)作激活函数，那么：Sigmoid导数 = Sigmoid*(1-Sigmoid)<br>\n输出层→隐藏层：残差 = -(Sigmoid输出值-样本值) * Sigmoid*(1-Sigmoid) = -(输出值-样本值)*输出值*(1-输出值)<br>\n隐藏层→隐藏层：残差 = (右层每个节点的残差加权求和)* 当前节点的Sigmoid*(1-当前节点的Sigmoid)</p>\n<p>如果用tansig作激活函数，那么：tansig导数 = 1 – tansig^2<br>\n<img width=\"287\" height=\"133\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464612223.gif\"><br>\n残差全部计算好后，就可以更新权重了：<br>\n输入层：权重增加 = 当前节点的Sigmoid * 右层对应节点的残差 * 学习率<br>\n隐藏层：权重增加 = 输入值 * 右层对应节点的残差 * 学习率<br>\n偏移值的权重增加 = 右层对应节点的残差 * 学习率<br>\n学习率前面介绍过，学习率是一个预先设置好的参数，用于控制每次更新的幅度。</p>\n<p>此后，对全部数据都反复进行这样的计算，直到输出的误差达到一个很小的值为止。<br>\n以上介绍的是目前最常见的神经网络类型，称为<strong>前馈神经网络(FeedForward Neural Network)</strong>，由于它一般是要向后传递误差的，所以也叫<strong>BP神经网络(Back Propagation Neural Network)</strong>。</p>\n<p>BP神经网络的特点和局限：<br>\n– BP神经网络可以用作分类、聚类、预测等。需要有一定量的历史数据，通过历史数据的训练，网络可以学习到数据中隐含的知识。在你的问题中，首先要找到某些问题的一些特征，以及对应的评价数据，用这些数据来训练神经网络。<br>\n– BP神经网络主要是在实践的基础上逐步完善起来的系统，并不完全是建立在仿生学上的。从这个角度讲，实用性 &gt; 生理相似性。<br>\n– BP神经网络中的某些算法，例如如何选择初始值、如何确定隐藏层的节点个数、使用何种激活函数等问题，并没有确凿的理论依据，只有一些根据实践经验总结出的有效方法或经验公式。<br>\n– BP神经网络虽然是一种非常有效的计算方法，但它也以计算超复杂、计算速度超慢、容易陷入局部最优解等多项弱点著称，因此人们提出了大量有效的改进方案，一些新的神经网络形式也层出不穷。</p>\n</div>\n		</div>','文章转载自贴吧 由于作者写的非常浅显易懂，所以转载，感谢作者！根据评论对文章有所更改<br>先从回归(Regression)问题说起。我在本吧已经看到不少人提到如果想实现强AI，就必须让机器学会观察并总结规律的言论。具体地说，要让机器观察什么是圆的，什么是方的，区分各种颜色和形状，然后根据这些特征对某种事物进行分类或预测。其实这就是回归问题。<br>\r 如何解决回归问题？我们用眼睛看到某样东西，可以一下子看出它的一些基本特征。可是计算机呢？它看到的只是一堆数字而已，因此要让机器从事物的特征中找到规律，其实是一个如何在数字中找规律的问题。</p>\r <p><img width=\"253\" height=\"145\" class=\"alignnone\" src=\"/img/post/20170516-1/other-1464591219.jpg\"></p>',3,'1',0),(5,2,'2017-05-15 11:40:00','Walk Away','<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" width=330 height=86 src=\"//music.163.com/outchain/player?type=2&id=31861678&auto=1&height=66\"></iframe><div>President Pitzer, Mr.Vice President, Governor, Congressman Thomas, Senator Wiley, and Congressman Miller, Mr. Webb, Mr. Bell, scientists, distinguished guests, and ladies and gentlemen:<br>　　皮茨校长，副总统先生，州长，托马斯众议员，维利议员，米勒众议员，韦伯先生，比尔先生，科学家们，尊敬的来宾，女士们先生们：<br>　　I appreciate your president having made me an honorary visiting professor, and I will assure you that my first lecture will be very brief.<br>　　我十分感谢你们的校长授予我名誉教授的头衔，并且我向你们保证，我的第一个演讲会十分简洁。<br>　　I am delighted to be here and I\'m particularly delighted to be here on this occasion.<br>　　我很高兴来到这里，特别是在这个时候。<br>　　We meet at a college noted for knowledge, in a city noted for progress, in a state noted for strength, and we stand in need of all three, for we meet in an hour of change and challenge, in a decade of hope and fear, in an age of both knowledge and ignorance. <br>　　我们在这个以知识闻名的大学，在这个以进步文明的城市，在这个以实力闻名的州府相会。并且我们需要它们全部三者，因为我们正处于一个变化与挑战的时期，希望与恐惧交织的十年，知识与愚昧并存的时代。<br>　　The greater our knowledge increases, the greater our ignorance unfolds.<br>　　我们获得的知识越多，我们显露出的无知也就越多。<br>　　Despite the striking fact that most of the scientists that the world has ever known are alive and working today, despite the fact that this Nation\'s own scientific manpower is doubling every 12 years in a rate of growth more than three times that of our population as a whole, despite that, the vast stretches of the unknown and the unanswered and the unfinished still far outstrip our collective comprehension.<br>　　尽管显著的事实表明：享誉世界的科学家们仍在奋斗不息，尽管我国的科研力量以每12年翻一番的速度增长、总体超过了人口增长速率的三倍。尽管如此，宇宙中未知之境、未解之谜和未竟之事的范围之广，仍然远远超出了我们所有人的理解能力。No man can fully grasp how far and how fast we have come, but condense, if you will, the 50,000 years of man\'s recorded history in a time span of but a half-century. <br>　　没人能够断言我们能走多远，能走多快。但如果你愿意，将人类的5万年历史压缩成短短的半个世纪。<br>　　Stated in these terms, we know very little about the first 40 years, except at the end of them advanced man had learned to use the skins of animals to cover them. <br>　　在这个时间跨度下，我们对于开始的40年知之甚少，除了在这40年的最后阶段我们学会了用兽皮遮体。<br>　　Then about 10 years ago, under this standard, man emerged from his caves to construct other kinds of shelter. <br>　　在此标准之下，10年前，人类走出洞穴，开始建造新的家园。<br>　　Only five years ago man learned to write and use a cart with wheels.<br>　　五年前人类才学会了写字和使用有轮子的车辆。<br>　　Christianity began less than two years ago. <br>　　基督教产生于不到两年前。<br>　　The printing press came this year, <br>　　印刷出版今年才出现。<br>　　and then less than two months ago, during this whole 50-year span of human history, the steam engine provided a new source of power. <br>　　在人类历史的50年间，在最近不到两个月的时间之前，蒸汽机为我们提供了新的动力。<br>　　Newton explored the meaning of gravity. <br>　　牛顿发现了引力的意义。<br>　　Last month electric lights and telephones and automobiles and airplanes became available.<br>　　上个月出现了电灯，电话，汽车和飞机。<br>　　Only last week did we develop penicillin and television and nuclear power, <br>　　仅仅上周我们才发明了青霉素，电视与核能。<br>　　and now if America\'s new spacecraft succeeds in reaching Venus, we will literally reached the stars before midnight tonight.<br>　　如果现在美国最新的飞船能够成功抵达金星，那么我们才真正算得上在今天午夜抵达其他星球了。<br>　　This is a breathtaking pace, and such a pace cannot help but create new ills as it dispels old, new ignorance, new problems, new dangers. <br>　　这是激动人心的一步，但迈出的这一步在驱散旧邪恶的同时，也会派生出新邪恶，新无知、新问题和新危险。<br>　　Surely the opening vistas of space promise high costs and hardships, as well as high reward.<br>　　无可否认，太空所展现的远景回报不小，但困难巨大、代价高昂。<br>　　So it is not surprising that some would have us stay where we are a little longer to rest, to wait. <br>　　因此不难理解，有时我们会在原地踏步，焦急等待。<br>　　But this city of Houston, this state of Texas, this country of the United States was not built by those who waited and rested and wished to look behind them. <br>　　但建立休斯敦市，德克萨斯州和美利坚合众国的人绝不会止步不前，安于现状，甘愿落后。This country was conquered by those who moved forward--and so will space.<br>　　这个国家是由那些不断进取的人所征服的，航天事业也是如此。<br>　　William Bradford, speaking in 1630 of the founding of the Plymouth Bay Colony, said that all great and honorable actions are accompanied with great difficulties, and both must be enterprised and overcome with answerable courage.<br>　　1630年，威廉·布拉德福德在普利茅斯港殖民地的建立仪式上说，所有伟大而崇高的事业都伴随着巨大的困难，而完成这些行动必须具备冒险精神和与之相当的勇气。<br>　　If this capsule history of our progress teaches us anything, it is that man, in his quest for knowledge and progress, is determined and cannot be deterred. <br>　　如果说这段简短而充满进步的历史能给我们什么样的教训，那就是人类在探求知识和进步的过程中是坚定不移并无所阻挡的。<br>　　The exploration of space will go ahead, whether we join in it or not, and it is one of the great adventures of all time, and no nation which expects to be the leader of other nations can expect to stay behind in this race for space.<br>　　不论我们参加与否，空间探索终将继续。无论何时，它都是一场伟大的冒险，没有任何一个期望领先世界的国家想在这场空间竞赛中止步。<br>　　Those who came before us made certain that this country rode the first waves of the industrial revolution, the first waves of modern invention, and the first wave of nuclear power, <br>　　我们的先辈使这个国家掀起了工业革命的第一波浪潮，现代发明的第一波浪潮，核能技术的第一波浪潮。<br>　　and this generation does not intend to founder in the backwash of the coming age of space. <br>　　而我们这一代绝不会甘愿在即将到来的太空时代的浪潮中倒下。<br>　　We mean to be a part of it--we mean to lead it. <br>　　我们要加入其中――我们要领先世界。<br>　　For the eyes of the world now look into space, to the moon and to the planets beyond, and we have vowed that we shall not see it governed by a hostile flag of conquest, but by a banner of freedom and peace.<br>　　为了如今仰望太空，注视月球和遥望行星的世人，我们发誓，我们决不允许太空被那些邪恶国家所征服，我们会看到自由与和平的旗帜在飘扬。<br>　　We have vowed that we shall not see space filled with weapons of mass destruction, but with instruments of knowledge and understanding.<br>　　我们发誓，我们不会看到太空布满大规模杀伤性武器，而是充满了获取知识的工具。<br>　　Yet the vows of this Nation can only be fulfilled if we in this Nation are first, and, therefore, we intend to be first.<br>　　这个承诺只有在我国领先的情况下才能履行，并且我们即将付诸行动。<br>　　In short, our leadership in science and industry, our hopes for peace and security, our obligations to ourselves as well as others, all require us to make this effort, to solve these mysteries, to solve them for the good of all men, and to become the world\'s leading space-faring nation.<br>　　简而言之，我们在科学和工业上的领导地位，我们对于和平与安全的渴望，我们对于自身和他人的责任，所有这一切要求我们做出努力，为了全人类的利益而努力解开这些谜团，成为世界领先的航天国家。<br>　　We set sail on this new sea because there is new knowledge to be gained, and new rights to be won, and they must be won and used for the progress of all people.<br>　　为了获取新的知识，为了赢得新的权利，我们必须获取并运用权利。为了全人类的进步，我们踏上新的航程。For space science, like nuclear science and all technology, has no conscience of its own. <br>　　空间科技，正如核科技以及其他技术，本身并没有道德可言。<br>　　Whether it will become a force for good or ill depends on man, <br>　　它的善恶完全取决于人类。<br>　　and only if the United States occupies a position of preeminence can we help decide whether this new ocean will be a sea of peace or a new terrifying theater of war. <br>　　并且只有当美利坚合众国获得一个卓越的地位之时，才能帮助决定这片新的领域最终充满和平还是成为战争的威胁。<br>　　I do not say that we should or will go unprotected against the hostile misuse of space any more than we go unprotected against the hostile use of land or sea, but I do say that space can be explored and mastered without feeding the fires of war, without repeating the mistakes that man has made in extending his writ around this globe of ours.<br>　　我不觉得我们应该或者必须对敌人滥用太空比对敌人滥用陆地和海洋更加无动于衷。但是我确实要说，太空能够在非战争的目的下开发和利用，在不重蹈战争覆辙的情况下开发和利用。<br>　　There is no strife, no prejudice, no national conflict in outer space as yet. <br>　　在太空还没有竞争，偏见和国家冲突。<br>　　Its hazards are hostile to us all. <br>　　我们所有人都要面对太空的危险。<br>　　Its conquest deserves the best of all mankind, and its opportunity for peaceful cooperation may never come again. <br>　　太空值得全人类尽最大的努力去征服，而且和平合作的机会可能永远不会重来。<br>　　But why, some say, the moon? <br>　　但有人问：为什么选择月球？<br>　　Why choose this as our goal? <br>　　为什么选择登月作为我们的目标？<br>　　And they may well ask why climb the highest mountain? <br>　　那他们也许会问为什么我们要登上最高的山峰？<br>　　Why, 35 years ago, fly the Atlantic? <br>　　为什么要在35年前飞越大西洋？<br>　　Why does Rice play Texas?<br>　　为什么赖斯大学要与德克萨斯大学竞赛？<br>　　We choose to go to the moon. <br>　　我们决定登月。<br>　　We choose to go to the moon. <br>　　我们决定登月。<br>　　We choose to go to the moon in this decade and do the other things, not because they are easy, but because they are hard, because that goal will serve to organize and measure the best of our energies and skills, because that challenge is one that we are willing to accept, one we are unwilling to postpone, and one which we intend to win, and the others, too.<br>　　我们决定在这十年间登上月球，并实现更多梦想，并非它们轻而易举，而是它们困难重重。因为这个目标将促进我们实现最佳的组织并测出我们最佳的能力，因为这个挑战我们乐于接受，因为这个挑战我们不愿推迟，因为这个挑战我们志在必得，其他的挑战也是如此。<br>　　It is for these reasons that I regard the decision last year to shift our efforts in space from low to high gear as among the most important decisions that will be made during my incumbency in the office of the Presidency.<br>　　正是因为这些理由，我把去年关于提升航天计划的决定作为我在本届总统任期内最重要的决定之一。<br>　　In the last 24 hours we have seen facilities now being created for the greatest and most complex exploration in man\'s history. <br>　　在过去的24小时里，我们看到一些设施已经为人类历史上最复杂的探险而建立起来。<br>　　We have felt the ground shake and the air shattered by the testing of a Saturn C-1 booster rocket, many times as powerful as the Atlas which launched John Glenn, generating power equivalent to 10,000 automobiles with their accelerators on the floor. <br>　　我们感受到了土星C-1火箭试验产生的震动和冲击，它比把约翰·格伦送入太空的阿特拉斯火箭还要强大好几倍，可以产生相当于1万辆汽车的功率。We have seen the site where five F-1 rocket engines, each one as powerful as all eight engines of the Saturn combined, will be clustered together to make the advanced Saturn missile, assembled in a new building to be built at Cape Canaveral as tall as a 48-storey structure, as wide as a city block, and as long as two lengths of this field.<br>　　我们看到了5个F-1火箭发动机，每一个都相当于8个土星火箭发动机的功率，它们将会用于建造更先进的土星火箭，在卡纳维拉尔角即将兴建的48层大楼中组装起来。这幢建筑宽一个街区，长度超过我们现在所在的这个体育场的两倍。<br>　　Within these last 19 months at least 45 satellites have circled the earth. Some 40 of them were made in the United States of America and they were far more sophisticated and supplied far more knowledge to the people of the world than those of the Soviet Union.<br>　　在过去的19个月中至少有45颗卫星进入了太空，其中大约40颗标着“美利坚合众国制造”的标记，它们比苏联的卫星更加精密，能为世界人民提供更多的知识。<br>　　The Mariner spacecraft now on its way to Venus is the most intricate instrument in the history of space science. <br>　　正在飞向金星的水手号飞船是空间科学史上最复杂的装置。<br>　　The accuracy of that shot is comparable to firing a missile from Cape Canaveral and dropping it in this stadium between the 40-yard lines.<br>　　其精确程度比得上在卡纳维拉尔角发射的一枚火箭直接击中这个体育场的40码线之间。Transit satellites are helping our ships at sea to steer a safer course. <br>　　海事卫星使海上的船只航行更加安全。<br>　　Tiros satellites have given us unprecedented warnings of hurricanes and storms, and will do the same for forest fires and icebergs.<br>　　气象卫星可以提前带给我们飓风和风暴警告，它同样也可以用于森林火灾与冰山预警。<br>　　We have had our failures, but so have others, even if they do not admit them.<br>　　我们经历过失败，但是别人也经历过，即便他们不会承认。<br>　　And they may be less public.<br>　　因此它们可能并不为人所知。<br>　　To be sure, we are behind, and will be behind for some time in manned flight.<br>　　显然，我们正落后于人，并且在载人航天方面还将继续落后一段时间。<br>　　But we do not intend to stay behind, and in this decade, we shall make up and move ahead.<br>　　但是我们不会永远落后下去，在这十年间我们将会迎头赶上。<br>　　The growth of our science and education will be enriched by new knowledge of our universe and environment, by new techniques of learning and mapping and observation, by new tools and computers for industry, medicine, the home as well as the school. <br>　　我们所获得的关于宇宙与环境的新知识，新的学习，绘图与观测技术，用于工业，医学和家庭的新工具和计算机，所有的一切都将促进科学和教育的发展。<br>　　Technical institutions, such as Rice, will reap the harvest of these gains.<br>　　像赖斯大学这样的技术院校将会因此而得益。<br>　　And finally, the space effort itself, while still in its infancy, has already created a great number of new companies, and tens of thousands of new jobs. <br>　　最终，尽管航天事业本身仍然处于童年，它已经催生了许多公司和数以千计的工作机会。<br>　　Space and related industries are generating new demands in investment and skilled personnel, <br>　　航天与其他相关工业对投资和有特殊技能的人力产生了新需求。<br>　　and this city and this state, and this region, will share greatly in this growth. <br>　　并且这个城市，这个州和这个地区将会极大的受益于这种增长。<br>　　What was once the furthest outpost on the old frontier of the West will be the furthest outpost on the new frontier of science and space. <br>　　西部的旧疆域将会成为空间科学的新疆域。<br>　　Houston, your city of Houston, with its Manned Spacecraft Center, will become the heart of a large scientific and engineering community. <br>　　休斯敦，你们的休斯敦市，以及它的载人航天中心，将会成为一个巨大的的科学与工程共同体的命脉。<br>　　During the next 5 years the National Aeronautics and Space Administration expects to double the number of scientists and engineers in this area, to increase its outlays for salaries and expenses to $60 million a year; to invest some $200 million in plant and laboratory facilities; and to direct or contract for new space efforts over $10 billion from this center in this city.<br>　　在接下来的5年中，国家航空航天局希望这里的科学家和工程师数量翻倍，希望将工资和开支提高到每年6千万美元，希望在工厂和实验设施上得到2亿美元的投资，希望指导或与这个城市的航天中心签订超过10亿美元的合同。<br>　　To be sure, all this costs us all a good deal of money. <br>　　显然，这会花掉我们一大笔钱。<br>　　This year\'s space budget is three times what it was in January 1961, and it is greater than the space budget of the previous eight years combined.<br>　　今年的航天预算是1961年1月的三倍，比过去八年的总和还要多。<br>　　That budget now stands at $5,400 million a year--a staggering sum, though somewhat less than we pay for cigarettes and cigars every year. <br>　　预算现在保持在每年54亿美元――一个令人震惊的数目，尽管还稍小于我们在香烟和雪茄上的消费额。Space expenditures will soon rise some more, from 40 cents per person per week to more than 50 cents a week for every man, woman and child in the United States, for we have given this program a high national priority--even though I realize that this is in some measure an act of faith and vision, for we do not now know what benefits await us. <br>　　航天支出很快就会从平均每人每周40美分上升到50美分的程度，因为我们赋予了这个计划很高的国家优先权。即使我认识到，目前这个目标从某种程度上来说还停留在信念与幻想之中，因为我们无从知晓人们会从中获得怎样的收益。 <br>　　But if I were to say, my fellow citizens, that we shall send to the moon, 240,000 miles away from the control station in Houston, a giant rocket more than 300 feet tall, the length of this football field, made of new metal alloys, some of which have not yet been invented, capable of standing heat and stresses several times more than have ever been experienced, fitted together with a precision better than the finest watch, carrying all the equipment needed for propulsion, guidance, control, communications, food and survival, on an untried mission, to an unknown celestial body, and then return it safely to earth, re-entering the atmosphere at speeds of over 25,000 miles per hour, causing heat about half that of the temperature of the sun--almost as hot as it is here today--and do all this, and do it right, and do it first before this decade is out--then we must be bold.<br>　　但是我想说，我的同胞们。让我们向那个距离休斯敦控制中心24万英里的月球发射火箭，一枚超过 300 英尺高，与这个橄榄球场长度相当的火箭――这枚火箭采用了新型合金材料，其耐热性与抗压性比现在使用的材料强好几倍，只是个别部分还是未知数。其装配的精密程度可以与最精确的手表相媲美。它运载着用于推进，导航，控制，通讯，食品和维生的各种设备，肩负着一个前所未有的使命，登上那个未知的天体，之后安全返回地球。以超过2万5千英里的时速重返大气层，由此产生的高温大约是太阳温度的一半，就像今天这里这样热――如果我们要实现全部这些目标，要顺利实现这个目标，要在这个十年内领先完成――那我们必须敢做敢为。I\'m the one who is doing all the work, so we just want you to stay cool for a minute.<br>　　我一个人做了所有这些工作，所以我们想让你们冷静一会。<br>　　However, I think we\'re going to do it, and I think that we must pay what needs to be paid. <br>　　然而，我认为我们正在付诸实践，我们必须为所必为。<br>　　I don\'t think we ought to waste any money, but I think we ought to do the job. <br>　　我并不觉得我们应该浪费任何一分钱，但我认为我们应该付诸实践。 <br>　　And this will be done in the decade of the Sixties. <br>　　这些应该在60年代实现。<br>　　It may be done while some of you are still here at school at this college and university. <br>　　它有可能在你们还在中学，这所学院和攻读大学时实现。<br>　　It will be done during the terms of office of some of the people who sit here on this platform. <br>　　它将会在台上诸位的任期之内实现。<br>　　But it will be done. And it will be done before the end of this decade.<br>　　它应当完成，并且应当在这十年结束之前完成。<br>　　And I am delighted that this university is playing a part in putting a man on the moon as part of a great national effort of the United States of America.<br>　　作为美利坚合众国国家事业的一部分，我很高兴这所大学在登月计划中扮演着一个角色。<br>　　Many years ago the great British explorer George Mallory, who was to die on Mount Everest, was asked why did he want to climb it. He said, \"Because it is there.\"<br>　　很多年前，伟大的英国探险家乔治·马拉里在攀登珠穆朗玛峰时遇难。曾经有人问他为什么要攀登珠峰，他回答说，“因为它就在那儿。”<br>　　Well, space is there, and we\'re going to climb it, and the moon and the planets are there, and new hopes for knowledge and peace are there. <br>　　是的，太空就在那儿，而我们即将在那里遨游。月球和其他行星就在那儿，获得知识与和平的新希望就在那儿。<br>　　And, therefore, as we set sail we ask God\'s blessing on the most hazardous and dangerous and greatest adventure on which man has ever embarked.<br>　　因此，在我们启程之时，我们祈求上帝能够保佑这个人类有史以来所从事的最危险和最伟大的历险。<br>　　Thank you.<br>　　谢谢。','<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" width=330 height=86 src=\"//music.163.com/outchain/player?type=2&id=31861678&auto=0&height=66\"></iframe><br>我们决定登月 （We Choose to Go to the Moon） 是美国前总统约翰·费茨杰拉德·肯尼迪（John Fitzgerald Kennedy）于1962年9月12日在赖斯大学的一篇关于航天事业的演讲。',2,'1',0),(6,1,'2017-05-13 19:40:00','柏林墙下演说','<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" width=330 height=86 src=\"//music.163.com/outchain/player?type=2&id=34152579&auto=1&height=66\"></iframe><div>Two thousand years ago the proudest boast was \"civis Romanus sum.\" Today, in the world of freedom, the proudest boast is \"Ich bin ein Berliner.\"<img width=\"267\" height=\"188\"  src=\"/img/post/170515-1.jpg\"><br>There are many people in the world who really don\'t understand, or say they don\'t, what is the 2000 great issue between the free world and the Communist world. Let them come to Berlin. There are some who say that communism is the wave of the future. Let them come to Berlin. And there are some who say in Europe and elsewhere we can work with the Communists. Let them come to Berlin. And there are even a few who say that it is true that communism is an evil system, but it permits us to make economic progress. Lass\' sie nach Berlin kommen. Let them come to Berlin.Freedom has many difficulties and democracy is not perfect, but we have never had to put a wall up to keep our people in, to prevent them from leaving us. I want to say, on behalf of my countrymen, who live many miles away on the other side of the Atlantic, who are far distant from you, that they take the greatest pride that they have been able to share with you, even from a distance, the story of the last 18 years. I know of no town, no city, that has been besieged for 18 years that still lives with the vitality and the force, and the hope and the determination of the city of West Berlin. While the wall is the most obvious and vivid demonstration of the failures of the Communist system, for all the world to see, we take no satisfaction in it, for it is, as your Mayor has said, an offense not only against history but an offense against humanity, separating families, dividing husbands and wives and brothers and sisters, and dividing a people who wish to be joined together.<br>What is true of this city is true of Germany--real, lasting peace in Europe can never be assured as long as one German out of four is denied the elementary right of free men, and that is to make a free choice. In 18 years of peace and good faith, this generation of Germans has earned the right to be free, including the right to unite their families and their nation in lasting peace, with good will to all people. You live in a defended island of freedom, but your life is part of the main. So let me ask you as I close, to lift your eyes beyond the dangers of today, to the hopes of tomorrow, beyond the freedom merely of this city of Berlin, or your country of Germany, to the advance of freedom everywhere, beyond the wall to the day of peace with justice, beyond yourselves and ourselves to all mankind.<br>Freedom is indivisible, and when one man is enslaved, all are not free. When all are free, then we can look forward to that day when this city will be joined as one and this country and this great Continent of Europe in a peaceful and hopeful globe. When that day finally comes, as it will, the people of West Berlin can take sober satisfaction in the fact that they were in the front lines for almost two decades.<br>All free men, wherever they may live, are citizens of Berlin, and, therefore, as a free man, I take pride in the words \"Ich bin ein Berliner.\"<br></div>','<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" width=330 height=86 src=\"//music.163.com/outchain/player?type=2&id=34152579&auto=0&height=66\"></iframe><br>《柏林墙下的演说》为美国总统约翰·F.肯尼迪1963年6月25日在柏林墙位于勃兰登堡门的关口前（西柏林）作出的演讲。演说的最后一句为：“一切自由人，不论他们住在何方，皆是柏林市民，所以作为一个自由人，我为“Ich bin ein Berliner”这句话感到自豪。”',2,'1',0),(7,1,'2017-05-01 19:40:00','Born 2 Run','<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" width=330 height=86 src=\"//music.163.com/outchain/player?type=2&id=28160132&auto=1&height=66\"></iframe><div><img width=\"500\" height=\"281\" class=\"post-avatar\" src=\"/img/post/170515-2.jpg\">乐队名称：7LIONS (7Lions)<br>乐队来自：美国洛杉矶<br>乐队风格：独立摇滚、电子嘻哈<br>经纪公司：RedOne’s label 2101 Records (环球音乐子公司)<br>乐队成员：<br>说唱：Mika Guillory ( The “Prophet” )<br>主唱/节奏吉他：Forrest Fulmer<br>键盘手：Morgan Taylor Reid<br>主音吉他/背景和声：Will Carpenter<br>贝斯手：Daniel Hange<br>鼓手：Tony Tommasi <br>从左至右：Mika Guillory ( The “Prophet” )、Will Carpenter、Morgan Taylor Reid、Tony Tommasi 、Daniel Hange、Forrest Fulmer</div>','<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" width=330 height=86 src=\"//music.163.com/outchain/player?type=2&id=28160132&auto=0&height=66\"></iframe><div>乐队名称：7LIONS (7Lions)<br>乐队来自：美国洛杉矶<br>乐队风格：独立摇滚、电子嘻哈<br>经纪公司：RedOne’s label 2101 Records (环球音乐子公司)<br></div>',2,'1',0),(8,1,'2017-05-01 19:40:00','编辑测试文章','欢迎使用Popular博客系统。这是系统测试文章。你可以编辑或者删除它，然后开始您的博客！','欢迎使用Popular博客系统。这是系统测试文章。',1,'0',0),(9,1,'2017-05-01 19:40:00','回收站测试文章','欢迎使用Popular博客系统。这是系统测试文章。你可以编辑或者删除它，然后开始您的博客！','欢迎使用Popular博客系统。这是系统测试文章。你可以编辑或者删除它，然后开始您的博客！',1,'-1',0);
/*!40000 ALTER TABLE `pop_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_terms`
--

DROP TABLE IF EXISTS `pop_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_terms` (
  `term_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_name` varchar(100) NOT NULL,
  `term_order` int(11) DEFAULT NULL,
  `term_color` varchar(45) DEFAULT '#999',
  PRIMARY KEY (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_terms`
--

LOCK TABLES `pop_terms` WRITE;
/*!40000 ALTER TABLE `pop_terms` DISABLE KEYS */;
INSERT INTO `pop_terms` VALUES (1,'随笔',1,'#5aba59'),(2,'音乐',2,'#df2d4f'),(3,'学习',3,'#4d85d1');
/*!40000 ALTER TABLE `pop_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_users`
--

DROP TABLE IF EXISTS `pop_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pop_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login` varchar(100) NOT NULL,
  `user_pwd` varchar(100) NOT NULL,
  `user_nickname` varchar(100) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_url` varchar(100) DEFAULT NULL,
  `user_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 or 0',
  `user_role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_users`
--

LOCK TABLES `pop_users` WRITE;
/*!40000 ALTER TABLE `pop_users` DISABLE KEYS */;
INSERT INTO `pop_users` VALUES (1,'vickey','123','Vickey','vk@vickey.me','http://vickey.me',1,'admin'),(2,'user1','123','小猫磕豆子','victory_yan@foxmail.com','http://vickey.me',1,'editor');
/*!40000 ALTER TABLE `pop_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-24 18:07:24

-- MariaDB dump 10.19  Distrib 10.8.3-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: nnhshalfcaf
-- ------------------------------------------------------
-- Server version	10.8.3-MariaDB-1:10.8.3+maria~jammy

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `HalfCaf`
--

DROP TABLE IF EXISTS `HalfCaf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HalfCaf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc_order` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_HalfCaf_acc_order` (`acc_order`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`acc_order` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`acc_order` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`acc_order` in (0,1)),
  CONSTRAINT `CONSTRAINT_4` CHECK (`acc_order` in (0,1)),
  CONSTRAINT `CONSTRAINT_5` CHECK (`acc_order` in (0,1)),
  CONSTRAINT `CONSTRAINT_6` CHECK (`acc_order` in (0,1)),
  CONSTRAINT `CONSTRAINT_7` CHECK (`acc_order` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HalfCaf`
--

LOCK TABLES `HalfCaf` WRITE;
/*!40000 ALTER TABLE `HalfCaf` DISABLE KEYS */;
INSERT INTO `HalfCaf` VALUES
(1,1);
/*!40000 ALTER TABLE `HalfCaf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES
('d164c6289484');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caf`
--

DROP TABLE IF EXISTS `caf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caf` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_caf_caf` (`caf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caf`
--

LOCK TABLES `caf` WRITE;
/*!40000 ALTER TABLE `caf` DISABLE KEYS */;
/*!40000 ALTER TABLE `caf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drink`
--

DROP TABLE IF EXISTS `drink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuItem` varchar(50) DEFAULT NULL,
  `temp_id` int(11) NOT NULL,
  `decaf` tinyint(1) DEFAULT NULL,
  `flavors` varchar(50) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `inst` varchar(150) DEFAULT NULL,
  `sf` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `temp_id` (`temp_id`),
  KEY `ix_drink_decaf` (`decaf`),
  KEY `ix_drink_flavors` (`flavors`),
  KEY `ix_drink_inst` (`inst`),
  KEY `ix_drink_menuItem` (`menuItem`),
  KEY `ix_drink_sf` (`sf`),
  CONSTRAINT `drink_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `drink_ibfk_2` FOREIGN KEY (`temp_id`) REFERENCES `temp` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_4` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_5` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_6` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_7` CHECK (`sf` in (0,1)),
  CONSTRAINT `CONSTRAINT_8` CHECK (`decaf` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drink`
--

LOCK TABLES `drink` WRITE;
/*!40000 ALTER TABLE `drink` DISABLE KEYS */;
/*!40000 ALTER TABLE `drink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinksToFlavor`
--

DROP TABLE IF EXISTS `drinksToFlavor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinksToFlavor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drink` varchar(50) DEFAULT NULL,
  `drinkId` int(11) DEFAULT NULL,
  `flavor` varchar(50) DEFAULT NULL,
  `flavorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_drinksToFlavor_drink` (`drink`),
  KEY `ix_drinksToFlavor_drinkId` (`drinkId`),
  KEY `ix_drinksToFlavor_flavor` (`flavor`),
  KEY `ix_drinksToFlavor_flavorId` (`flavorId`),
  CONSTRAINT `drinksToFlavor_ibfk_1` FOREIGN KEY (`flavorId`) REFERENCES `flavor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinksToFlavor`
--

LOCK TABLES `drinksToFlavor` WRITE;
/*!40000 ALTER TABLE `drinksToFlavor` DISABLE KEYS */;
INSERT INTO `drinksToFlavor` VALUES
(1,'Black Coffee',1,'None',1),
(2,'Black Coffee',1,'Caramel',4),
(3,'Black Coffee',1,'French Vanilla',9),
(4,'Black Coffee',1,'Hazelnut',11),
(5,'Black Coffee',1,'Vanilla',19),
(6,'Cafe Mocha',2,'None',1),
(7,'Cafe Mocha',2,'Caramel',4),
(8,'Cafe Mocha',2,'Cinnamon bun',6),
(9,'Cafe Mocha',2,'French Vanilla',9),
(10,'Cafe Mocha',2,'Hazelnut',11),
(11,'Cafe Mocha',2,'Vanilla',19),
(12,'The Huskalatte',3,'None',1),
(13,'The Huskalatte',3,'Caramel',4),
(14,'The Huskalatte',3,'Cinnamon bun',6),
(15,'The Huskalatte',3,'French Vanilla',9),
(16,'The Huskalatte',3,'Hazelnut',11),
(17,'The Huskalatte',3,'Vanilla',19),
(18,'The Huskaccino',4,'None',1),
(19,'The Huskaccino',4,'Caramel',4),
(20,'The Huskaccino',4,'Cinnamon bun',6),
(21,'The Huskaccino',4,'French Vanilla',9),
(22,'The Huskaccino',4,'Hazelnut',11),
(23,'The Huskaccino',4,'Vanilla',19),
(24,'Cold Brew',5,'Vanilla',19),
(25,'Hot Chocolate',6,'None',1),
(26,'Hot Chocolate',6,'Caramel',4),
(27,'Hot Chocolate',6,'Cinnamon bun',6),
(28,'Hot Chocolate',6,'French Vanilla',9),
(29,'Hot Chocolate',6,'Hazelnut',11),
(30,'Hot Chocolate',6,'Vanilla',19),
(31,'Chai Latte',7,'None',1),
(32,'Iced Tea',8,'None',1),
(33,'Huskie Palmer',9,'None',1),
(34,'Lemonade',10,'None',1),
(35,'Lemonade',10,'Blue Raspberry',2),
(36,'Lemonade',10,'Cherry',5),
(37,'Lemonade',10,'Lavender',12),
(38,'Lemonade',10,'Peach',13),
(39,'Lemonade',10,'Raspberry',14),
(40,'Lemonade',10,'Strawberry',15),
(41,'Lemonade',10,'Watermelon',20),
(42,'Frozen Strawberry Lemonade',11,'None',1),
(43,'Black Tea',12,'None',1),
(44,'Chai Tea',13,'None',1),
(45,'Chamomile Tea',14,'None',1),
(46,'Earl Grey Tea',15,'None',1),
(47,'English Breakfast Tea',16,'None',1),
(48,'Green Tea',17,'None',1),
(49,'Lemon Tea',18,'None',1),
(50,'Mint Tea',19,'None',1),
(51,'Orange Tea',20,'None',1),
(52,'Peppermint Tea',21,'None',1);
/*!40000 ALTER TABLE `drinksToFlavor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinkstocaffeine`
--

DROP TABLE IF EXISTS `drinkstocaffeine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinkstocaffeine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drink` varchar(50) DEFAULT NULL,
  `drinkId` int(11) DEFAULT NULL,
  `caf` varchar(50) DEFAULT NULL,
  `cafId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cafId` (`cafId`),
  KEY `ix_drinksToCaffeine_caf` (`caf`),
  KEY `ix_drinksToCaffeine_drink` (`drink`),
  CONSTRAINT `drinkstocaffeine_ibfk_1` FOREIGN KEY (`cafId`) REFERENCES `caf` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinkstocaffeine`
--

LOCK TABLES `drinkstocaffeine` WRITE;
/*!40000 ALTER TABLE `drinkstocaffeine` DISABLE KEYS */;
/*!40000 ALTER TABLE `drinkstocaffeine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinkstotemp`
--

DROP TABLE IF EXISTS `drinkstotemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinkstotemp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drink` varchar(50) DEFAULT NULL,
  `drinkId` int(11) DEFAULT NULL,
  `temp` varchar(50) DEFAULT NULL,
  `tempId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tempId` (`tempId`),
  KEY `ix_drinksToTemp_drink` (`drink`),
  KEY `ix_drinksToTemp_temp` (`temp`),
  CONSTRAINT `drinkstotemp_ibfk_1` FOREIGN KEY (`tempId`) REFERENCES `temp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinkstotemp`
--

LOCK TABLES `drinkstotemp` WRITE;
/*!40000 ALTER TABLE `drinkstotemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `drinkstotemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoriteDrinks`
--

DROP TABLE IF EXISTS `favoriteDrinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favoriteDrinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `drinkId` int(11) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  `tempId` int(11) DEFAULT NULL,
  `decaf` tinyint(1) DEFAULT NULL,
  `flavorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tempId` (`tempId`),
  KEY `ix_favoriteDrinks_decaf` (`decaf`),
  KEY `ix_favoriteDrinks_drinkId` (`drinkId`),
  KEY `ix_favoriteDrinks_flavorId` (`flavorId`),
  KEY `ix_favoriteDrinks_menuId` (`menuId`),
  KEY `ix_favoriteDrinks_userId` (`userId`),
  CONSTRAINT `favoriteDrinks_ibfk_1` FOREIGN KEY (`drinkId`) REFERENCES `drink` (`id`),
  CONSTRAINT `favoriteDrinks_ibfk_2` FOREIGN KEY (`flavorId`) REFERENCES `flavor` (`id`),
  CONSTRAINT `favoriteDrinks_ibfk_3` FOREIGN KEY (`menuId`) REFERENCES `menuItem` (`id`),
  CONSTRAINT `favoriteDrinks_ibfk_4` FOREIGN KEY (`tempId`) REFERENCES `temp` (`id`),
  CONSTRAINT `favoriteDrinks_ibfk_5` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_4` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_5` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_6` CHECK (`decaf` in (0,1)),
  CONSTRAINT `CONSTRAINT_7` CHECK (`decaf` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoriteDrinks`
--

LOCK TABLES `favoriteDrinks` WRITE;
/*!40000 ALTER TABLE `favoriteDrinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoriteDrinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flavor`
--

DROP TABLE IF EXISTS `flavor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flavor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_flavor_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flavor`
--

LOCK TABLES `flavor` WRITE;
/*!40000 ALTER TABLE `flavor` DISABLE KEYS */;
INSERT INTO `flavor` VALUES
(2,'Blue Raspberry'),
(3,'Butterscotch'),
(7,'Cane Sugar'),
(4,'Caramel'),
(5,'Cherry'),
(6,'Cinnamon Bun'),
(8,'Cranberry'),
(9,'French Vanilla'),
(10,'Green Mint'),
(11,'Hazelnut'),
(12,'Lavender'),
(1,'None'),
(13,'Peach'),
(14,'Raspberry'),
(16,'SF Caramel'),
(18,'SF Strawberry'),
(17,'SF Vanilla'),
(15,'Strawberry'),
(19,'Vanilla'),
(20,'Watermelon');
/*!40000 ALTER TABLE `flavor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuItem`
--

DROP TABLE IF EXISTS `menuItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menuItem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `popular` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_menuItem_name` (`name`),
  KEY `ix_menuItem_description` (`description`),
  KEY `ix_menuItem_popular` (`popular`),
  KEY `ix_menuItem_price` (`price`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`popular` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`popular` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`popular` in (0,1)),
  CONSTRAINT `CONSTRAINT_4` CHECK (`popular` in (0,1)),
  CONSTRAINT `CONSTRAINT_5` CHECK (`popular` in (0,1)),
  CONSTRAINT `CONSTRAINT_6` CHECK (`popular` in (0,1)),
  CONSTRAINT `CONSTRAINT_7` CHECK (`popular` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuItem`
--

LOCK TABLES `menuItem` WRITE;
/*!40000 ALTER TABLE `menuItem` DISABLE KEYS */;
INSERT INTO `menuItem` VALUES
(1,'Black Coffee','Hot or iced, available in decaf',2,0),
(2,'Cafe Mocha','Half coffee, half hot chocolate, all good',3,0),
(3,'The Huskalatte','Creamy coffee with flavor of choice',3,0),
(4,'The Huskaccino','Cool, icy, coffee slushy-what more could you want?',3,0),
(5,'Cold Brew','Try Vanilla Cream',2,0),
(6,'Hot Chocolate','Add a flavor, available iced or frozen',2,0),
(7,'Chai Tea Latte','A spicy, smooth, and soothing drink, available hot or iced',3,0),
(8,'Iced Tea','Sweet lemon tea served over ice',2,0),
(9,'Huskie Palmer','A sweet blend of lemonade and iced tea over ice. Available iced or frozen',2,0),
(10,'Lemonade','Sweet and summery',2,0),
(11,'Frozen Strawberry Lemonade','Frozen Lemonade with a twist',3,1),
(12,'Black Tea','',2,0),
(13,'Chai Tea','',3,0),
(14,'Chamomile Tea','',2,0),
(15,'Earl Grey Tea','The Mr. Schmit special',2,1),
(16,'English Breakfast','',2,0),
(17,'Green Tea','',2,0),
(18,'Lemon Tea','',2,0),
(19,'Mint Tea','',2,0),
(20,'Orange Tea','',2,0),
(21,'Peppermint Tea','Often called pepperminTEA',2,0);
/*!40000 ALTER TABLE `menuItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) DEFAULT NULL,
  `roomnum_id` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `complete` tinyint(1) DEFAULT NULL,
  `read` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roomnum_id` (`roomnum_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `ix_order_complete` (`complete`),
  KEY `ix_order_timestamp` (`timestamp`),
  KEY `ix_order_read` (`read`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`roomnum_id`) REFERENCES `roomnum` (`id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`complete` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`complete` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`complete` in (0,1)),
  CONSTRAINT `CONSTRAINT_4` CHECK (`complete` in (0,1)),
  CONSTRAINT `CONSTRAINT_5` CHECK (`complete` in (0,1)),
  CONSTRAINT `CONSTRAINT_6` CHECK (`complete` in (0,1)),
  CONSTRAINT `CONSTRAINT_7` CHECK (`complete` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES
(1,1,NULL,NULL,0,NULL),
(2,2,NULL,NULL,0,NULL),
(3,3,NULL,NULL,0,NULL),
(4,4,NULL,'2023-01-19 17:25:06',0,'2023-01-19 17:25:06');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomnum`
--

DROP TABLE IF EXISTS `roomnum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roomnum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_roomnum_num` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomnum`
--

LOCK TABLES `roomnum` WRITE;
/*!40000 ALTER TABLE `roomnum` DISABLE KEYS */;
INSERT INTO `roomnum` VALUES
(1,'100'),
(2,'101'),
(3,'102'),
(4,'103'),
(5,'104'),
(6,'105'),
(7,'106'),
(8,'107'),
(9,'108'),
(10,'109'),
(11,'110'),
(12,'111'),
(13,'112'),
(14,'113'),
(15,'114'),
(16,'115'),
(17,'116'),
(18,'117'),
(19,'118'),
(20,'119'),
(21,'120'),
(22,'121'),
(23,'122'),
(24,'123'),
(25,'124'),
(26,'125'),
(27,'126'),
(28,'127'),
(29,'128'),
(30,'129'),
(31,'130'),
(32,'131'),
(33,'132'),
(34,'133'),
(35,'134'),
(36,'135'),
(37,'136'),
(38,'137'),
(39,'138'),
(40,'139'),
(41,'140'),
(42,'141'),
(43,'142'),
(44,'143'),
(45,'144'),
(46,'145'),
(47,'146'),
(48,'147'),
(49,'148'),
(50,'149'),
(51,'150'),
(52,'151'),
(53,'152'),
(54,'153'),
(55,'154'),
(56,'155'),
(57,'156'),
(58,'157'),
(59,'158'),
(60,'159'),
(61,'160'),
(62,'161'),
(63,'162'),
(64,'163'),
(65,'164'),
(66,'165'),
(67,'166'),
(68,'167'),
(69,'168'),
(70,'169'),
(71,'170'),
(72,'171'),
(73,'172'),
(74,'173'),
(75,'174'),
(76,'175'),
(77,'176'),
(78,'177'),
(79,'178'),
(80,'179'),
(81,'180'),
(82,'181'),
(83,'182'),
(84,'183'),
(85,'184'),
(86,'185'),
(87,'186'),
(88,'187'),
(89,'188'),
(90,'189'),
(91,'190'),
(92,'191'),
(93,'192'),
(94,'193'),
(95,'194'),
(96,'195'),
(97,'196'),
(98,'197'),
(99,'198'),
(100,'199'),
(101,'200'),
(103,'201'),
(105,'202'),
(106,'203'),
(107,'204'),
(108,'205'),
(109,'206'),
(110,'207'),
(111,'208'),
(112,'209'),
(113,'210'),
(114,'211'),
(115,'212'),
(116,'213'),
(117,'214'),
(118,'215'),
(119,'216'),
(120,'217'),
(121,'218'),
(122,'219'),
(123,'220'),
(124,'221'),
(125,'222'),
(126,'223'),
(127,'224'),
(128,'225'),
(129,'226'),
(130,'227'),
(131,'228'),
(132,'229'),
(133,'230'),
(134,'231'),
(135,'232'),
(136,'233'),
(167,'234'),
(168,'235'),
(169,'236'),
(170,'237'),
(171,'238'),
(172,'239'),
(173,'240'),
(174,'241'),
(175,'242'),
(176,'243'),
(177,'244'),
(178,'245'),
(179,'246'),
(180,'247'),
(181,'248'),
(182,'249'),
(183,'250'),
(184,'251'),
(185,'252'),
(186,'253'),
(187,'254'),
(188,'255'),
(189,'256'),
(190,'257'),
(191,'258'),
(192,'259'),
(193,'260'),
(194,'261'),
(195,'262'),
(196,'263'),
(197,'264'),
(198,'265'),
(199,'266'),
(200,'267'),
(201,'268'),
(202,'269'),
(203,'270'),
(204,'271'),
(205,'272'),
(206,'273'),
(207,'274'),
(208,'275'),
(209,'276'),
(210,'277'),
(211,'278'),
(212,'279'),
(213,'280'),
(214,'281'),
(215,'282'),
(216,'283'),
(217,'284'),
(218,'285'),
(219,'286'),
(220,'287'),
(221,'288'),
(222,'289'),
(223,'290'),
(224,'291'),
(225,'292');
/*!40000 ALTER TABLE `roomnum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp`
--

DROP TABLE IF EXISTS `temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_temp_temp` (`temp`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp`
--

LOCK TABLES `temp` WRITE;
/*!40000 ALTER TABLE `temp` DISABLE KEYS */;
INSERT INTO `temp` VALUES
(2,'Cold'),
(1,'Hot');
/*!40000 ALTER TABLE `temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isActivated` tinyint(1) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `user_type` varchar(10) DEFAULT NULL,
  `current_order_id` int(11) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_username` (`username`),
  UNIQUE KEY `ix_user_email` (`email`),
  KEY `ix_user_isActivated` (`isActivated`),
  KEY `ix_user_user_type` (`user_type`),
  KEY `current_order_id` (`current_order_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`current_order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`isActivated` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`isActivated` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`isActivated` in (0,1)),
  CONSTRAINT `CONSTRAINT_4` CHECK (`isActivated` in (0,1)),
  CONSTRAINT `CONSTRAINT_5` CHECK (`isActivated` in (0,1)),
  CONSTRAINT `CONSTRAINT_6` CHECK (`isActivated` in (0,1)),
  CONSTRAINT `CONSTRAINT_7` CHECK (`isActivated` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,1,'admin','pbkdf2:sha256:150000$v58w2mPc$abbe6d2a7e9a77b946c8a7c6d00a46f12e0a2fe1e6accc8ceebf035091e993b9','Admin',1,'nnhshalfcafapp+1@gmail.com'),
(2,1,'teacher','pbkdf2:sha256:150000$TmrzCiMN$72176dd1a240f34116a78776c405e4b585514a95bf0ddcabae7ecdbc0d11e80a','Teacher',2,'nnhshalfcafapp+2@gmail.com'),
(3,1,'barista','pbkdf2:sha256:150000$TmrzCiMN$72176dd1a240f34116a78776c405e4b585514a95bf0ddcabae7ecdbc0d11e80a','Barista',3,'nnhshalfcafapp+3@gmail.com'),
(4,1,'newtest','pbkdf2:sha256:150000$MI9cfa8W$f0e8877d1f6c3f2e0b6a7486ecdf7c079ebb73082c7ca8db156ed53abcbc6afa','Teacher',4,'skotlo@stu.naperville203.org');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-11 17:25:33

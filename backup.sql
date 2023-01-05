LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES (1,1,'admin','pbkdf2:sha256:150000$v58w2mPc$abbe6d2a7e9a77b946c8a7c6d00a46f12e0a2fe1e6accc8ceebf035091e993b9','Admin',DEFAULT,'nnhshalfcafapp+1@gmail.com'),(2,1,'teacher','pbkdf2:sha256:150000$TmrzCiMN$72176dd1a240f34116a78776c405e4b585514a95bf0ddcabae7ecdbc0d11e80a','Teacher',DEFAULT,'nnhshalfcafapp+2@gmail.com'),(3,1,'barista','pbkdf2:sha256:150000$TmrzCiMN$72176dd1a240f34116a78776c405e4b585514a95bf0ddcabae7ecdbc0d11e80a','Barista',DEFAULT,'nnhshalfcafapp+3@gmail.com');
UNLOCK TABLES;

LOCK TABLES `order` WRITE;
INSERT INTO `order` VALUES (1,1,DEFAULT,DEFAULT,0,DEFAULT),(2,2,DEFAULT,DEFAULT,0,DEFAULT),(3,3,DEFAULT,DEFAULT,0,DEFAULT);
UNLOCK TABLES;

LOCK TABLES `user` WRITE;
UPDATE `user` SET `current_order_id`=1 WHERE `id`=1;
UPDATE `user` SET `current_order_id`=2 WHERE `id`=2;
UPDATE `user` SET `current_order_id`=3 WHERE `id`=3;
UNLOCK TABLES;


LOCK TABLES `temp` WRITE;
INSERT INTO `temp` VALUES (1,'Hot'),(2,'Cold');
UNLOCK TABLES;


LOCK TABLES `flavor` WRITE;
INSERT INTO `flavor` VALUES (1,'None'),(2,'Blue Raspberry'),(3,'Butterscotch'),(4,'Caramel'),(5,'Cherry'),(6,'Cinnamon Bun'),
    (7,'Cane Sugar'),(8,'Cranberry'),(9,'French Vanilla'),(10,'Green Mint'),(11,'Hazelnut'),(12,'Lavender'),(13,'Peach'),
    (14,'Raspberry'),(15,'Strawberry'),(16,'SF Caramel'),(17,'SF Vanilla'),(18,'SF Strawberry'),(19,'Vanilla'),(20,'Watermelon');
UNLOCK TABLES;


LOCK TABLES `menuItem` WRITE;
INSERT INTO `menuItem` VALUES (1,'Black Coffee','Hot or iced, available in decaf',2,0),
(2,'Cafe Mocha','Half coffee, half hot chocolate, all good',3,0),
(3,'The Huskalatte','Creamy coffee with flavor of choice',3,0),
(4,'The Huskaccino','Cool, icy, coffee slushy-what more could you want?',3,0),
(5,'Cold Brew','Try Vanilla Cream',2,0),
(6,'Hot Chocolate','Add a flavor, available iced or frozen',2,0),
(7,'Chai Tea Latte','A spicy, smooth, and soothing drink, available hot or iced',3,0),
(8,'Iced Tea','Sweet lemon tea served over ice',2,0),(9,'Huskie Palmer','A sweet blend of lemonade and iced tea over ice. Available iced or frozen',2,0),(10,'Lemonade','Sweet and summery',2,0),(11,'Frozen Strawberry Lemonade','Frozen Lemonade with a twist',3,1),
(12,'Black Tea','',2,0),(13,'Chai Tea','',3,0),(14,'Chamomile Tea','',2,0),(15,'Earl Grey Tea','The Mr. Schmit special',2,1),(16,'English Breakfast','',2,0),(17,'Green Tea','',2,0),(18,'Lemon Tea','',2,0),(19,'Mint Tea','',2,0),(20,'Orange Tea','',2,0),(21,'Peppermint Tea','Often called pepperminTEA',2,0);
UNLOCK TABLES;

LOCK TABLES `roomnum` WRITE;
INSERT INTO `roomnum` VALUES (1, '100'), (2, '101'), (3, '102'), (4, '103'), (5, '104'), (6, '105'), (7, '106'), (8, '107'), (9, '108'), (10, '109'), (11, '110'), (12, '111'), (13, '112'), (14, '113'), (15, '114'), (16, '115'), (17, '116'), (18, '117'),(19, '118'), (20, '119'),(21,'120'), (22,'121'), (23,'122'), (24,'123'), (25,'124'), (26,'125'),  (27,'126'), (28,'127'), (29,'128'), (30,'129'), (31,'130'), (32,'131'), (33,'132'), (34,'133'), (35,'134'), (36,'135'), (37,'136'), (38,'137'), (39,'138'), (40,'139'), (41,'140'), (42,'141'), (43,'142'), (44,'143'), (45,'144'), (46,'145'), (47,'146'), (48,'147'), (49,'148'), (50,'149'), (51,'150'), (52,'151'), (53,'152'), (54,'153'), (55,'154'), (56,'155'), (57,'156'), (58,'157'), (59,'158'), (60,'159'), (61,'160'), (62,'161'), (63,'162'), (64,'163'), (65,'164'), (66,'165'), (67,'166'), (68,'167'), (69,'168'), (70,'169'), (71,'170'), (72,'171'), (73,'172'), (74,'173'), (75,'174'), (76,'175'), (77,'176'), (78,'177'), (79,'178'), (80,'179'), (81,'180'), (82,'181'), (83,'182'), (84,'183'), (85,'184'), (86,'185'), (87,'186'), (88,'187'), (89,'188'), (90,'189'), (91,'190'), (92,'191'), (93,'192'), (94,'193'), (95,'194'), (96,'195'), (97,'196'), (98,'197'), (99,'198'), (100,'199');
UNLOCK TABLES; 

LOCK TABLES `drinksToFlavor` WRITE;
INSERT INTO `drinksToFlavor` VALUES (1,'Black Coffee',1,'None',1),(2,'Black Coffee',1,'Caramel',4), (3,'Black Coffee',1,'French Vanilla',9), (4,'Black Coffee',1,'Hazelnut',11), (5,'Black Coffee',1,'Vanilla',19),
(6,'Cafe Mocha',2,'None',1), (7,'Cafe Mocha',2,'Caramel',4), (8,'Cafe Mocha',2,'Cinnamon bun',6), (9,'Cafe Mocha',2,'French Vanilla',9), (10,'Cafe Mocha',2,'Hazelnut',11), (11,'Cafe Mocha',2,'Vanilla',19),
(12,'The Huskalatte',3,'None',1), (13,'The Huskalatte',3,'Caramel',4), (14,'The Huskalatte',3,'Cinnamon bun',6), (15,'The Huskalatte',3,'French Vanilla',9), (16,'The Huskalatte',3,'Hazelnut',11), (17,'The Huskalatte',3,'Vanilla',19),
(18,'The Huskaccino',4,'None',1), (19,'The Huskaccino',4,'Caramel',4), (20,'The Huskaccino',4,'Cinnamon bun',6), (21,'The Huskaccino',4,'French Vanilla',9),
(22,'The Huskaccino',4,'Hazelnut',11), (23,'The Huskaccino',4,'Vanilla',19),
(24,'Cold Brew',5,'Vanilla',19),
(25,'Hot Chocolate',6,'None',1), (26,'Hot Chocolate',6,'Caramel',4), (27,'Hot Chocolate',6,'Cinnamon bun',6),(28,'Hot Chocolate',6,'French Vanilla',9),(29,'Hot Chocolate',6,'Hazelnut',11), (30,'Hot Chocolate',6,'Vanilla',19),
(31,'Chai Latte',7,'None',1),
(32,'Iced Tea',8,'None',1),
(33,'Huskie Palmer',9,'None',1),
(34,'Lemonade',10,'None',1), (35,'Lemonade',10,'Blue Raspberry',2),(36,'Lemonade',10,'Cherry',5),(37,'Lemonade',10,'Lavender',12),(38,'Lemonade',10,'Peach',13),(39,'Lemonade',10,'Raspberry',14),(40,'Lemonade',10,'Strawberry',15),(41,'Lemonade',10,'Watermelon',20),(42,'Frozen Strawberry Lemonade',11,'None',1),
(43,'Black Tea',12,'None',1),(44,'Chai Tea',13,'None',1),
(45,'Chamomile Tea',14,'None',1),
(46,'Earl Grey Tea',15,'None',1),
(47,'English Breakfast Tea',16,'None',1),(48,'Green Tea',17,'None',1),(49,'Lemon Tea',18,'None',1),(50,'Mint Tea',19,'None',1),(51,'Orange Tea',20,'None',1),(52,'Peppermint Tea',21,'None',1);
UNLOCK TABLES;

LOCK TABLES `HalfCaf` WRITE;
INSERT INTO `HalfCaf` VALUES (1, TRUE);
UNLOCK TABLES;
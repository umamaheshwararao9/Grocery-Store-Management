CREATE DATABASE  IF NOT EXISTS `jdbc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jdbc`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: jdbc
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `unit` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (101,'Rice',50,NULL),(102,'Wheat Flour',40,NULL),(103,'Sugar',45,NULL),(104,'Salt',20,NULL),(105,'Milk',60,NULL),(106,'Eggs',70,NULL),(107,'Bread',30,NULL),(108,'Butter',80,NULL),(109,'Cheese',90,NULL),(110,'Tea Leaves',100,NULL),(111,'Coffee',120,NULL),(112,'Cooking Oil',150,NULL),(113,'Pasta',55,NULL),(114,'Tomato Sauce',35,NULL),(115,'Canned Beans',25,NULL),(116,'Frozen Vegetables',80,NULL),(117,'Chicken Breast',200,NULL),(118,'Beef Steak',250,NULL),(119,'Pork Chops',220,NULL),(120,'Yogurt',45,NULL),(121,'Cereal',85,NULL),(122,'Oats',40,NULL),(123,'Jam',50,NULL),(124,'Honey',90,NULL),(125,'Peanut Butter',75,NULL),(126,'Noodles',40,NULL),(127,'Potatoes',30,NULL),(128,'Onions',25,NULL),(129,'Garlic',35,NULL),(130,'Ginger',50,NULL),(131,'Apples',100,NULL),(132,'Bananas',60,NULL),(133,'Oranges',80,NULL),(134,'Tomatoes',40,NULL),(135,'Lettuce',30,NULL),(136,'Carrots',25,NULL),(137,'Cucumber',20,NULL),(138,'Bell Peppers',45,NULL),(139,'Spinach',50,NULL),(140,'Mushrooms',70,NULL),(141,'Cheddar Cheese',120,NULL),(142,'Parmesan Cheese',150,NULL),(143,'Mozzarella Cheese',110,NULL),(144,'Yogurt',60,NULL),(145,'Frozen Fish',200,NULL),(146,'Salmon',250,NULL),(147,'Shrimp',300,NULL),(148,'Canned Tuna',50,NULL),(149,'Pickles',45,NULL),(150,'Ketchup',35,NULL),(151,'Mayonnaise',60,NULL),(152,'Mustard',40,NULL),(153,'Soy Sauce',30,NULL),(154,'Vinegar',20,NULL),(155,'Sugar',50,NULL),(156,'Flour',55,NULL),(157,'Yeast',25,NULL),(158,'Baking Powder',30,NULL),(159,'Pancake Mix',70,NULL),(160,'Biscuits',45,NULL),(161,'Chocolates',90,NULL),(162,'Cookies',70,NULL),(163,'Cake Mix',85,NULL),(164,'Honey',110,NULL),(165,'Almonds',150,NULL),(166,'Cashews',180,NULL),(167,'Walnuts',200,NULL),(168,'Sunflower Seeds',60,NULL),(169,'Pumpkin Seeds',75,NULL),(170,'Dried Fruits',120,NULL),(171,'Green Tea',80,NULL),(172,'Black Tea',50,NULL),(173,'Herbal Tea',90,NULL),(174,'Instant Coffee',110,NULL),(175,'Coffee Beans',150,NULL),(176,'Brown Sugar',60,NULL),(177,'Powdered Sugar',55,NULL),(178,'Cake Flour',45,NULL),(179,'Bread Crumbs',30,NULL),(180,'Tortilla Chips',70,NULL),(181,'Salsa',80,NULL),(182,'Nachos',90,NULL),(183,'Syrup',100,NULL),(184,'Marshmallows',50,NULL),(185,'Peanuts',45,NULL),(186,'Puffed Rice',35,NULL),(187,'Cornflakes',55,NULL),(188,'Granola Bars',65,NULL),(189,'Oreo Cookies',80,NULL),(190,'Ginger Ale',45,NULL),(191,'Soda',35,NULL),(192,'Fruit Juice',60,NULL),(193,'Sports Drink',50,NULL),(194,'Energy Drink',90,NULL),(195,'Milk Powder',120,NULL),(196,'Condensed Milk',75,NULL),(197,'Evaporated Milk',80,NULL),(198,'Cream',100,NULL),(199,'Butter Milk',60,NULL),(200,'Cottage Cheese',70,NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-12 23:25:05

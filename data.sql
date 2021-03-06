-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: python_mysql
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availability` (
  `tnum` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `ac1` int DEFAULT NULL,
  `ac2` int DEFAULT NULL,
  `ac3` int DEFAULT NULL,
  `slp` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
/*!40000 ALTER TABLE `availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers` (
  `passenger_name` varchar(25) NOT NULL,
  `age` int NOT NULL,
  `train_no` int NOT NULL,
  `no_of_pas` int NOT NULL,
  `class` varchar(4) DEFAULT NULL,
  `date` date NOT NULL,
  `amount` int DEFAULT NULL,
  `status` char(10) DEFAULT NULL,
  `pnr_no` int NOT NULL AUTO_INCREMENT,
  `refund` int DEFAULT NULL,
  PRIMARY KEY (`pnr_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers`
--

LOCK TABLES `passengers` WRITE;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_details`
--

DROP TABLE IF EXISTS `train_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_details` (
  `tnum` int NOT NULL AUTO_INCREMENT,
  `tname` varchar(50) DEFAULT NULL,
  `src` varchar(50) DEFAULT NULL,
  `des` varchar(50) DEFAULT NULL,
  `ac1` int DEFAULT '10',
  `ac2` int DEFAULT '20',
  `ac3` int DEFAULT '30',
  `slp` int DEFAULT '40',
  PRIMARY KEY (`tnum`)
) ENGINE=InnoDB AUTO_INCREMENT=1012 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_details`
--

LOCK TABLES `train_details` WRITE;
/*!40000 ALTER TABLE `train_details` DISABLE KEYS */;
INSERT INTO `train_details` VALUES (1001,'Shatabdi Express','Bangalore','Chennai',100,200,300,400),(1002,'Rajdhani Express','Delhi','Bangalore',150,250,350,450),(1003,'Agra Express','Agra','New Delhi',100,200,300,400),(1004,'Charminar Express','Chennai','Hyderabad',110,220,330,440),(1005,'Deccan Express','Mumbai','Pune',200,300,400,100),(1006,'East Coast Express','Howrah','Hyderabad',100,200,300,400),(1007,'Samjhauta Express','Delhi','Lahore',10,20,30,40),(1008,'Karnataka Express','Bangalore','New Delhi',100,200,300,400),(1009,'Kaziranga Express','Guwahati','Bangalore',110,220,330,440),(1010,'Gujarat Express','Ahmedabad','Mumbai',10,20,30,40);
/*!40000 ALTER TABLE `train_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_timings`
--

DROP TABLE IF EXISTS `train_timings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_timings` (
  `tnum` int NOT NULL DEFAULT '0',
  `Monday` char(20) NOT NULL DEFAULT 'Not Running',
  `Tuesday` char(20) NOT NULL DEFAULT 'Not Running',
  `Wednesday` char(20) NOT NULL DEFAULT 'Not Running',
  `Thursday` char(20) NOT NULL DEFAULT 'Not Running',
  `Friday` char(20) NOT NULL DEFAULT 'Not Running',
  `Saturday` char(20) NOT NULL DEFAULT 'Not Running',
  `Sunday` char(20) NOT NULL DEFAULT 'Not Running',
  `Timings` time NOT NULL DEFAULT '00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_timings`
--

LOCK TABLES `train_timings` WRITE;
/*!40000 ALTER TABLE `train_timings` DISABLE KEYS */;
INSERT INTO `train_timings` VALUES (1001,'Running','Running','Not Running','Not Running','Running','Not Running','Running','07:10:00'),(1002,'Not Running','Running','Not Running','Running','Not Running','Running','Running','11:00:00'),(1003,'Running','Running','Not Running','Not Running','Running','Running','Running','16:30:00'),(1004,'Not Running','Running','Not Running','Running','Not Running','Not Running','Running','12:00:00'),(1005,'Running','Running','Not Running','Not Running','Running','Running','Running','09:15:00'),(1006,'Not Running','Not Running','Running','Running','Not Running','Not Running','Running','18:00:00'),(1007,'Running','Not Running','Running','Not Running','Not Running','Not Running','Running','20:40:00'),(1008,'Not Running','Not Running','Running','Running','Running','Running','Running','08:30:00'),(1009,'Running','Not Running','Running','Not Running','Running','Running','Running','21:00:00'),(1010,'Not Running','Not Running','Running','Running','Not Running','Not Running','Running','15:20:00');
/*!40000 ALTER TABLE `train_timings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-06 10:05:49

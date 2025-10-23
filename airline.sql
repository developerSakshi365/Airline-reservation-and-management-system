-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: flight_booking
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `flight_id` int NOT NULL,
  `travel_date` date NOT NULL,
  `passengers` int NOT NULL DEFAULT '1',
  `class` varchar(20) NOT NULL DEFAULT 'Economy',
  `booking_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'CONFIRMED',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (15,5,1,'2025-09-10',1,'Economy','2025-09-08 15:29:42','CONFIRMED'),(16,7,12,'2025-09-21',1,'Economy','2025-09-08 15:32:30','CONFIRMED'),(17,7,2,'2025-09-11',5,'Business','2025-09-08 15:34:53','CANCELLED'),(18,4,4,'2025-09-13',1,'Economy','2025-09-08 17:54:40','CANCELLED'),(19,4,1,'2025-09-10',1,'Economy','2025-09-08 18:00:15','CANCELLED'),(20,4,1,'2025-09-10',1,'Economy','2025-09-09 17:54:24','CANCELLED'),(21,4,1,'2025-09-10',1,'Economy','2025-09-10 12:52:09','CANCELLED'),(22,4,1,'2025-09-15',2,'Business','2025-09-15 16:22:08','CONFIRMED'),(24,4,1,'2025-09-15',1,'Economy','2025-09-16 16:33:12','CANCELLED'),(28,11,18,'2025-09-27',1,'Economy','2025-09-16 18:06:27','CONFIRMED'),(29,4,18,'2025-09-27',2,'Business','2025-09-17 02:26:16','CANCELLED'),(30,11,2,'2025-09-11',1,'Economy','2025-09-17 02:41:45','CANCELLED'),(31,6,1,'2025-09-15',1,'Economy','2025-09-17 02:45:31','CANCELLED'),(32,12,18,'2025-09-27',1,'Economy','2025-09-17 02:52:25','CANCELLED');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_messages`
--

DROP TABLE IF EXISTS `contact_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `message` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_read` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_messages`
--

LOCK TABLES `contact_messages` WRITE;
/*!40000 ALTER TABLE `contact_messages` DISABLE KEYS */;
INSERT INTO `contact_messages` VALUES (1,'developer','pateljeevan2005@gmail.com','hii\r\n','2025-09-09 17:12:06',0),(2,'sakshi vishwakarma','vishwakarmasakshi729@gmail.com','i want to cancel my flight could you help me with that?','2025-09-09 18:16:20',0),(3,'sakshi vishwakarma','vishwakarmasakshi729@gmail.com','i want to cancel my flight could you help me with that?','2025-09-09 18:18:54',0),(4,'sakshi vishwakarma','vishwakarmasakshi729@gmail.com','i want to cancel my flight could you help me with that?','2025-09-10 12:55:35',1),(5,'Jeevan patel','pateljeevan2005@gmail.com','“I want to change my flight from Delhi to Mumbai”','2025-09-15 11:04:50',0),(6,'Jeevan patel','pateljeevan2005@gmail.com','can I cancel or reschedule my booking?','2025-09-15 11:07:36',0),(7,'Jeevan patel','pateljeevan2005@gmail.com','“Can I carry musical instruments as cabin baggage?”','2025-09-15 11:10:32',1),(8,'Jeevan patel','pateljeevan2005@gmail.com','“Can I upgrade from economy to business class after booking?”','2025-09-15 11:14:10',1),(9,'Sakshi Vishwakarma','developersakshi365@gmail.com','“How many days does it take to process a cancellation refund?”','2025-09-15 11:16:42',1),(10,'Sakshi Vishwakarma','developersakshi365@gmail.com','“Do you provide meals on domestic economy flights?”','2025-09-15 11:19:20',1),(11,'gauri shankar','gauri.shankar@sophiacollege.edu.in','hello ','2025-09-17 02:54:36',0);
/*!40000 ALTER TABLE `contact_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(20) NOT NULL,
  `airline` varchar(50) NOT NULL,
  `source` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `travel_date` date NOT NULL,
  `class` varchar(20) NOT NULL DEFAULT 'Economy',
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `duration` varchar(20) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flight_number` (`flight_number`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'AI101','Air India','Mumbai','Delhi','2025-09-15','business','06:30:00','08:30:00','2h 0m',5500.00,'2025-09-08 06:30:00'),(2,'AI202','Air India','Delhi','Bangalore','2025-09-11','Business','09:00:00','12:00:00','3h 0m',8500.00,'2025-09-08 06:35:00'),(3,'IN303','IndiGo','Chennai','Hyderabad','2025-09-12','Economy','14:00:00','15:15:00','1h 15m',4200.00,'2025-09-08 06:40:00'),(4,'SG404','SpiceJet','Bangalore','Kolkata','2025-09-13','Economy','07:45:00','11:00:00','3h 15m',6000.00,'2025-09-08 06:45:00'),(5,'VJ505','Vistara','Delhi','Goa','2025-09-14','Business','17:00:00','19:45:00','2h 45m',7500.00,'2025-09-08 06:50:00'),(6,'AI606','Air India','Goa','Mumbai','2025-09-15','Economy','08:15:00','09:30:00','1h 15m',3800.00,'2025-09-08 06:55:00'),(7,'IN707','IndiGo','Pune','Delhi','2025-09-16','Business','10:00:00','12:10:00','2h 10m',9000.00,'2025-09-08 07:00:00'),(8,'SG808','SpiceJet','Mumbai','Chennai','2025-09-17','Economy','13:30:00','16:10:00','2h 40m',6500.00,'2025-09-08 07:05:00'),(9,'VJ909','Vistara','Kolkata','Delhi','2025-09-18','Business','06:45:00','09:15:00','2h 30m',8200.00,'2025-09-08 07:10:00'),(10,'AI010','Air India','Delhi','Chennai','2025-09-19','Economy','18:00:00','20:30:00','2h 30m',5600.00,'2025-09-08 07:15:00'),(11,'IN111','IndiGo','Hyderabad','Delhi','2025-09-20','Economy','07:00:00','09:15:00','2h 15m',4800.00,'2025-09-08 07:20:00'),(12,'SG222','SpiceJet','Delhi','Mumbai','2025-09-21','Business','11:00:00','13:00:00','2h 0m',8900.00,'2025-09-08 07:25:00'),(13,'VJ333','Vistara','Mumbai','Kolkata','2025-09-22','Economy','15:30:00','18:15:00','2h 45m',6700.00,'2025-09-08 07:30:00'),(14,'AI444','Air India','Bangalore','Delhi','2025-09-23','Business','09:45:00','12:15:00','2h 30m',9100.00,'2025-09-08 07:35:00'),(15,'IN555','IndiGo','Delhi','Chennai','2025-09-24','Economy','13:20:00','15:50:00','2h 30m',5800.00,'2025-09-08 07:40:00'),(16,'SG666','SpiceJet','Kolkata','Bangalore','2025-09-25','Economy','07:40:00','10:50:00','3h 10m',6000.00,'2025-09-08 07:45:00'),(17,'VJ777','Vistara','Chennai','Delhi','2025-09-26','Business','19:00:00','21:30:00','2h 30m',9400.00,'2025-09-08 07:50:00'),(18,'AI888','Air India','Delhi','Goa','2025-09-27','Economy','06:30:00','09:15:00','2h 45m',7200.00,'2025-09-08 07:55:00'),(19,'IN999','IndiGo','Mumbai','Hyderabad','2025-09-28','Business','08:15:00','09:45:00','1h 30m',8700.00,'2025-09-08 08:00:00'),(22,'AI305','Air India','Chennai','Hydrabad','2025-09-20','economy','22:00:00','23:00:00','1h ',10000.00,'2025-09-16 16:38:37');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES (1,4,'84d0da70-629a-4ea9-9d0d-413d5bd769d6e967d14d-5f64-40b0-8671-c2b4c71e872c','2025-09-15 19:00:18',1,'2025-09-15 12:30:17'),(2,4,'4acd7437-dcb2-4a75-9515-41633a45ed84b7986c27-8501-49aa-917a-3f96b0bb1a65','2025-09-15 19:07:39',0,'2025-09-15 12:37:38'),(3,4,'8a8a1374-aacd-4236-9921-63c698772437a7c3ab15-c41a-432d-ba6f-6ae656ffb470','2025-09-15 19:15:58',1,'2025-09-15 12:45:57'),(4,5,'849e52c6-e5a3-44f8-b96c-08f1ebda03fdda19c9c7-abcb-402d-b9d3-7e95eca724c4','2025-09-17 01:00:35',0,'2025-09-16 18:30:35'),(5,7,'05a46fe5-fef4-45e9-ac40-05c3154a9086195a66ee-22b4-4b6b-8650-dc5221c177c4','2025-09-17 01:02:09',0,'2025-09-16 18:32:08'),(6,4,'9618ebca-293a-47c6-be42-cd941d5ace6a68606508-de8d-42d0-8f33-e4a9dc5be679','2025-09-17 01:04:01',1,'2025-09-16 18:34:00');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `google_id` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(20) DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `google_id` (`google_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'testuser','test@example.com','12345',NULL,'2025-09-06 08:52:27','user'),(2,'sakshi vishwakarma','developersakshi365@gmail.com','$2a$10$yfpksynsfxPZT8vHNamwzOs5oCcp2q9JEvv6jr6hsyJWlsbsBC6Ue','111152587058592491715','2025-09-06 09:35:02','admin'),(4,'normal user','vishwakarmasakshi729@gmail.com','$2a$10$6/KBTr/0wKhZaKCseacRxOePAs12221vQdSn.1kfqPrGcFXcpUJxe',NULL,'2025-09-08 11:55:35','user'),(5,'jeevan patel','jeevanpatel2005@gmail.com','$2a$10$OWYrB8EB28OoAJq0Qmlihu7fPIkneipcqqiREe0aZ2yzmQegAuRem',NULL,'2025-09-08 12:30:13','user'),(6,'maria shaikh','mariashaikh2907@gmail.com','$2a$10$.G3sJQZxZu4dnPEGAt.bwO0TB3TfAA3wVe/BoTog5xisKe9FBRxp2',NULL,'2025-09-08 12:33:41','user'),(7,'jeevan','pateljeevan2005@gmail.com','$2a$10$Rt/xjy8G.ujKpxeMX69XCOFXJIgh6G3.P5rH8ZxflcpSq/j.I3EVC',NULL,'2025-09-08 15:32:08','user'),(11,'SakshiVishwakarma_1758045926323','sakshi.vishwakarma.t23067@sophiacollege.edu.in',NULL,'109736512712673316209','2025-09-16 18:05:26','user'),(12,'Gauri Shankar Singh ','gauri.shankar@sophiacollege.edu.in','$2a$10$0QqiMaUKBH.pVpBu5zXDg.rNYRthIJHuWLot38Z.sFcMGD3NyonSy',NULL,'2025-09-17 02:51:56','user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-23 18:07:55

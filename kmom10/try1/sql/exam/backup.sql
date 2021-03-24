-- MySQL dump 10.17  Distrib 10.3.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: exam
-- ------------------------------------------------------
-- Server version	10.3.25-MariaDB-0ubuntu1

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
-- Table structure for table `hund`
--

DROP TABLE IF EXISTS `hund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hund` (
  `id` int(11) NOT NULL,
  `namn` varchar(30) COLLATE utf8_swedish_ci DEFAULT NULL,
  `url` varchar(200) COLLATE utf8_swedish_ci DEFAULT NULL,
  `ras_id` varchar(5) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ras_id` (`ras_id`),
  CONSTRAINT `hund_ibfk_1` FOREIGN KEY (`ras_id`) REFERENCES `ras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hund`
--

LOCK TABLES `hund` WRITE;
/*!40000 ALTER TABLE `hund` DISABLE KEYS */;
INSERT INTO `hund` VALUES (1,'Båtsman','https://sv.wikipedia.org/wiki/Vi_p%C3%A5_Saltkr%C3%A5kan','sb'),(2,'Bo','https://sv.wikipedia.org/wiki/Bo_(hund)','pv'),(3,'Arleekin','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),(4,'Laska','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),(5,'Zloday','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),(6,'Sunny','https://sv.wikipedia.org/wiki/Bo_(hund)','pv'),(7,'Lajka','https://sv.wikipedia.org/wiki/Lajka','br'),(8,'Skeppshunden Bamse','https://sv.wikipedia.org/wiki/Skeppshunden_Bamse','sb');
/*!40000 ALTER TABLE `hund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medlem`
--

DROP TABLE IF EXISTS `medlem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medlem` (
  `id` int(11) NOT NULL,
  `fornamn` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `alias` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `efternamn` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `ort` varchar(30) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medlem`
--

LOCK TABLES `medlem` WRITE;
/*!40000 ALTER TABLE `medlem` DISABLE KEYS */;
INSERT INTO `medlem` VALUES (1,'Barrack','the president','Obama','Washington'),(2,'Ivan','the scientist','Pavlov','Sankt Petersburg'),(3,'Millan','the whisperer','Cesar','Santa Clarita'),(4,'Hafto','the captain','Erling','Honningsvåg'),(5,'Tjorven','tjorven','Grankvist','Saltkråkan');
/*!40000 ALTER TABLE `medlem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medlem2hund`
--

DROP TABLE IF EXISTS `medlem2hund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medlem2hund` (
  `id` int(11) NOT NULL,
  `medlem_id` int(11) NOT NULL,
  `hund_id` int(11) NOT NULL,
  `registrerad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medlem_id` (`medlem_id`),
  KEY `hund_id` (`hund_id`),
  CONSTRAINT `medlem2hund_ibfk_1` FOREIGN KEY (`medlem_id`) REFERENCES `medlem` (`id`),
  CONSTRAINT `medlem2hund_ibfk_2` FOREIGN KEY (`hund_id`) REFERENCES `hund` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medlem2hund`
--

LOCK TABLES `medlem2hund` WRITE;
/*!40000 ALTER TABLE `medlem2hund` DISABLE KEYS */;
INSERT INTO `medlem2hund` VALUES (1,1,2,2008),(2,1,6,2013),(3,2,3,1922),(4,2,4,1922),(5,2,5,1923),(6,4,8,1937),(7,5,1,1964);
/*!40000 ALTER TABLE `medlem2hund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ras`
--

DROP TABLE IF EXISTS `ras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ras` (
  `id` varchar(5) COLLATE utf8_swedish_ci NOT NULL,
  `namn` varchar(30) COLLATE utf8_swedish_ci DEFAULT NULL,
  `godkand` varchar(3) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ras`
--

LOCK TABLES `ras` WRITE;
/*!40000 ALTER TABLE `ras` DISABLE KEYS */;
INSERT INTO `ras` VALUES ('br','Blandras','nej'),('pv','Portugisisk vattenhund','ja'),('sb','Sankt bernhardshund','ja'),('sc','Schäfer','ja');
/*!40000 ALTER TABLE `ras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all`(
        p_search VARCHAR(50)
    )
BEGIN
    SET @search = IFNULL(p_search, '%%');
    
    SELECT CONCAT(fornamn, ' ("' , alias, '") '  , efternamn) AS Namn,
           ort AS Ort,
            h.namn AS Hund,
            url,
            r.namn AS Ras,
            r.godkand AS Godkand,
            registrerad AS Registrerad
    FROM medlem AS m
        JOIN medlem2hund AS m2h
            ON m.id = m2h.medlem_id
        JOIN hund AS h
            ON h.id = m2h.hund_id
        JOIN ras AS r
            ON r.id = h.ras_id
    HAVING Namn LIKE @search OR
        Ort LIKE @search OR
        Hund LIKE @search OR
        url LIKE @search OR
        Ras LIKE @search OR
        Godkand LIKE @search OR
        Registrerad LIKE @search
        ORDER BY registrerad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_report`()
BEGIN
    
(
    SELECT CONCAT(fornamn, ' ("' , alias, '") '  , efternamn) AS Namn,
           ort AS Ort,
           h.namn AS Hund,
           IF(r.namn='Blandras','Blandras (X)',r.namn) AS Ras,
           registrerad AS Registrerad
    FROM hund AS h
        RIGHT JOIN ras AS r
            ON r.id = h.ras_id
        LEFT JOIN medlem2hund AS m2h
            ON h.id = m2h.hund_id
        LEFT JOIN medlem AS m
            ON m.id = m2h.medlem_id
    WHERE r.id != 'sc'
)
UNION
(
    SELECT CONCAT(fornamn, ' ("' , alias, '") '  , efternamn) AS Namn,
           ort AS Ort,
           h.namn AS Hund,
           IF(r.namn='Blandras','Blandras (X)',r.namn) AS Ras,
           registrerad AS Registrerad
    FROM hund AS h
        RIGHT JOIN ras AS r
            ON r.id = h.ras_id
        LEFT JOIN medlem2hund AS m2h
            ON h.id = m2h.hund_id
        RIGHT JOIN medlem AS m
            ON m.id = m2h.medlem_id
)
ORDER BY Ras, Registrerad DESC, Hund
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-24 16:24:55

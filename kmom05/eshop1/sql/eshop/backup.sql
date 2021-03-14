-- MySQL dump 10.17  Distrib 10.3.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: eshop
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
-- Table structure for table `bestallning`
--

DROP TABLE IF EXISTS `bestallning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestallning` (
  `bestallning_id` int(11) NOT NULL AUTO_INCREMENT,
  `kund_id` int(11) NOT NULL,
  `skapad` timestamp NOT NULL DEFAULT current_timestamp(),
  `uppdaterad` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `bestalld` timestamp NULL DEFAULT NULL,
  `skickad` timestamp NULL DEFAULT NULL,
  `raderad` timestamp NULL DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`bestallning_id`),
  KEY `kund_id` (`kund_id`),
  CONSTRAINT `bestallning_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`kund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallning`
--

LOCK TABLES `bestallning` WRITE;
/*!40000 ALTER TABLE `bestallning` DISABLE KEYS */;
/*!40000 ALTER TABLE `bestallning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bestallning_rad`
--

DROP TABLE IF EXISTS `bestallning_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestallning_rad` (
  `bestallning_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`bestallning_id`,`produkt_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `bestallning_rad_ibfk_1` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallning` (`bestallning_id`),
  CONSTRAINT `bestallning_rad_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallning_rad`
--

LOCK TABLES `bestallning_rad` WRITE;
/*!40000 ALTER TABLE `bestallning_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `bestallning_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura` (
  `faktura_id` int(11) NOT NULL AUTO_INCREMENT,
  `kund_id` int(11) NOT NULL,
  `bestallning_id` int(11) NOT NULL,
  `belopp` datetime DEFAULT NULL,
  PRIMARY KEY (`faktura_id`),
  KEY `kund_id` (`kund_id`),
  KEY `bestallning_id` (`bestallning_id`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`kund_id`),
  CONSTRAINT `faktura_ibfk_2` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallning` (`bestallning_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktura_rad`
--

DROP TABLE IF EXISTS `faktura_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura_rad` (
  `faktura_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `antal` int(11) NOT NULL,
  `pris` float NOT NULL,
  PRIMARY KEY (`faktura_id`,`produkt_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `faktura_rad_ibfk_1` FOREIGN KEY (`faktura_id`) REFERENCES `faktura` (`faktura_id`),
  CONSTRAINT `faktura_rad_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura_rad`
--

LOCK TABLES `faktura_rad` WRITE;
/*!40000 ALTER TABLE `faktura_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hylla`
--

DROP TABLE IF EXISTS `hylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hylla` (
  `hylla_id` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  PRIMARY KEY (`hylla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hylla`
--

LOCK TABLES `hylla` WRITE;
/*!40000 ALTER TABLE `hylla` DISABLE KEYS */;
INSERT INTO `hylla` VALUES ('A101'),('A201'),('B101'),('B201'),('C101'),('C201');
/*!40000 ALTER TABLE `hylla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `kund_id` int(11) NOT NULL AUTO_INCREMENT,
  `fornamn` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `efternamn` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8_swedish_ci DEFAULT NULL,
  `epost` varchar(40) COLLATE utf8_swedish_ci DEFAULT NULL,
  `fakturaadress` varchar(200) COLLATE utf8_swedish_ci DEFAULT NULL,
  `leveransadress` varchar(200) COLLATE utf8_swedish_ci DEFAULT NULL,
  `registreringsdatum` datetime DEFAULT current_timestamp(),
  `aktiv` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`kund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Mikael ','Roos','070424242','','Centrumgatan 1','','2021-03-01 00:00:00',1),(2,'John','Doe','070555555','','Skogen 1','','2021-03-02 00:00:00',1),(3,'Jane','Doe','070556556','','Skogen 1','','2021-03-03 00:00:00',1),(4,'Mumintrollet','Mumin','070111111','','Blå hus 1','','2021-03-04 00:00:00',1),(5,'Nenad','Cuturic','012345678','','Kästadalsvägen 19, Huddinge','','2021-03-01 00:00:00',1);
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logg` (
  `logg_id` int(11) NOT NULL AUTO_INCREMENT,
  `tidsstampel` timestamp NOT NULL DEFAULT current_timestamp(),
  `handelse` varchar(200) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`logg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,'2021-03-04 00:22:12','Ny produkt lades till med produktid `1`.'),(2,'2021-03-04 00:22:12','Ny produkt lades till med produktid `2`.'),(3,'2021-03-04 00:22:12','Ny produkt lades till med produktid `3`.'),(4,'2021-03-04 00:22:12','Ny produkt lades till med produktid `4`.'),(5,'2021-03-04 00:22:12','Ny produkt lades till med produktid `5`.'),(6,'2021-03-04 00:23:47','Ny produkt lades till med produktid `8`.'),(7,'2021-03-04 01:54:38','Ny produkt lades till med produktid `9`.'),(8,'2021-03-04 01:54:38','Produkten med produktid `8` inaktiverades.'),(9,'2021-03-04 11:23:22','Ny produkt lades till med produktid `10`.'),(10,'2021-03-04 12:45:06','Detaljer om produktid `9` uppdaterades.'),(11,'2021-03-04 12:45:19','Detaljer om produktid `9` uppdaterades.'),(12,'2021-03-04 12:55:39','Produkten med produktid `9` inaktiverades.'),(13,'2021-03-04 12:57:03','Produkten med produktid `5` inaktiverades.'),(14,'2021-03-04 12:58:13','Detaljer om produktid `9` uppdaterades.'),(15,'2021-03-04 12:58:33','Detaljer om produktid `9` uppdaterades.'),(16,'2021-03-04 13:00:33','Detaljer om produktid `9` uppdaterades.'),(17,'2021-03-04 13:00:50','Detaljer om produktid `9` uppdaterades.'),(18,'2021-03-04 13:01:06','Detaljer om produktid `9` uppdaterades.'),(19,'2021-03-04 13:02:13','Detaljer om produktid `9` uppdaterades.'),(20,'2021-03-04 13:02:23','Detaljer om produktid `9` uppdaterades.'),(21,'2021-03-04 13:04:48','Detaljer om produktid `9` uppdaterades.'),(22,'2021-03-04 13:08:45','Detaljer om produktid `9` uppdaterades.'),(23,'2021-03-04 13:17:12','Produkten med produktid `8` aktiverades.'),(24,'2021-03-04 13:17:14','Produkten med produktid `5` aktiverades.'),(25,'2021-03-04 13:26:29','Detaljer om produktid `10` togs bort permanent.'),(26,'2021-03-04 16:27:17','Produkten med produktid `5` inaktiverades.'),(27,'2021-03-05 00:22:40','Detaljer om produktid `4` uppdaterades.'),(28,'2021-03-05 00:23:13','Detaljer om produktid `4` uppdaterades.'),(29,'2021-03-05 00:24:04','Detaljer om produktid `4` uppdaterades.'),(30,'2021-03-05 00:25:21','Detaljer om produktid `4` uppdaterades.'),(31,'2021-03-05 00:26:01','Detaljer om produktid `2` uppdaterades.'),(32,'2021-03-05 00:27:10','Detaljer om produktid `2` uppdaterades.'),(33,'2021-03-05 00:27:36','Detaljer om produktid `2` uppdaterades.'),(34,'2021-03-05 00:29:12','Detaljer om produktid `2` uppdaterades.'),(35,'2021-03-05 00:31:45','Detaljer om produktid `2` uppdaterades.'),(36,'2021-03-05 00:35:41','Detaljer om produktid `2` uppdaterades.'),(37,'2021-03-05 00:36:48','Detaljer om produktid `1` uppdaterades.'),(38,'2021-03-05 00:37:30','Detaljer om produktid `3` uppdaterades.'),(39,'2021-03-05 00:38:40','Detaljer om produktid `4` uppdaterades.'),(40,'2021-03-05 00:48:46','Detaljer om produktid `1` uppdaterades.'),(41,'2021-03-05 00:48:54','Detaljer om produktid `1` uppdaterades.'),(42,'2021-03-05 00:49:12','Detaljer om produktid `1` uppdaterades.'),(43,'2021-03-05 00:54:09','Detaljer om produktid `1` uppdaterades.'),(44,'2021-03-05 00:54:44','Detaljer om produktid `1` uppdaterades.'),(45,'2021-03-05 00:54:52','Detaljer om produktid `1` uppdaterades.');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plocklista`
--

DROP TABLE IF EXISTS `plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plocklista` (
  `plocklista_id` int(11) NOT NULL AUTO_INCREMENT,
  `bestallning_id` int(11) NOT NULL,
  `datum` datetime DEFAULT NULL,
  PRIMARY KEY (`plocklista_id`),
  KEY `bestallning_id` (`bestallning_id`),
  CONSTRAINT `plocklista_ibfk_1` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallning` (`bestallning_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plocklista`
--

LOCK TABLES `plocklista` WRITE;
/*!40000 ALTER TABLE `plocklista` DISABLE KEYS */;
/*!40000 ALTER TABLE `plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plocklista_rad`
--

DROP TABLE IF EXISTS `plocklista_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plocklista_rad` (
  `plocklista_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `hylla_id` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`plocklista_id`,`produkt_id`,`hylla_id`),
  KEY `produkt_id` (`produkt_id`),
  KEY `hylla_id` (`hylla_id`),
  CONSTRAINT `plocklista_rad_ibfk_1` FOREIGN KEY (`plocklista_id`) REFERENCES `plocklista` (`plocklista_id`),
  CONSTRAINT `plocklista_rad_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`),
  CONSTRAINT `plocklista_rad_ibfk_3` FOREIGN KEY (`hylla_id`) REFERENCES `hylla` (`hylla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plocklista_rad`
--

LOCK TABLES `plocklista_rad` WRITE;
/*!40000 ALTER TABLE `plocklista_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `plocklista_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `produkt_id` int(11) NOT NULL AUTO_INCREMENT,
  `produktnamn` varchar(150) COLLATE utf8_swedish_ci DEFAULT NULL,
  `pris` decimal(10,2) DEFAULT NULL,
  `beskrivning` varchar(300) COLLATE utf8_swedish_ci DEFAULT NULL,
  `produktbild_lank` varchar(200) COLLATE utf8_swedish_ci DEFAULT NULL,
  `aktiv` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`produkt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES (1,'Kaffeblandning med dbwebb-krydda',49.00,'En egenbryggd kaffeblandning för aktiva studiedagara, utan paus, spetsad med dbwebb-krydda.','kaffe.png',1),(2,'Kaffemugg med dbwebb-tryck',69.00,'En vacker snövit keramisk kaffemugg med högupplöst flerfärgstryck från dbwebb.','kaffekopp.png',1),(3,'Skiva där BTHs lärarkår sjunger sånger',199.00,'BTHs samlade lärarkår sjunger studiemotiverande sångar, inkluderar länk till online spellista.','bth-skiva.png',1),(4,'Sorrento – ekologisk mald espresso',99.00,'Sorrento är vår mest syditalienska espressoblend. Rivig, kraftfull och väldigt smakrik avnjuter du med fördel Sorrento med socker, eller i mjölkdrycker såsom flat white, caffe latte, cappuccino eller machiato.','sorrento.png',1),(5,'Temugg med dbwebb-tryck',79.00,'En ståtlig matt helsvart temugg, extra stor, med grön dbwebb-logo, för sköna stunder framför datorn.','temugg.png',0),(8,'Test produkt',25.99,'Bara ett test','test.png',1),(9,'produkt9',445.00,'Ny beskrivning','bild9.png',0);
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_produkt_insert
AFTER INSERT
ON produkt
FOR EACH ROW
BEGIN
    SET @handelse = CONCAT("Ny produkt lades till med produktid `", NEW.produkt_id, "`.");
    INSERT INTO logg (`handelse`)
        VALUES (@handelse);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_produkt_update
AFTER UPDATE
ON produkt
FOR EACH ROW
BEGIN
    IF OLD.aktiv = TRUE AND NEW.aktiv = FALSE
        THEN
            SET @handelse = CONCAT("Produkten med produktid `", NEW.produkt_id, "` inaktiverades.");
            INSERT INTO logg (`handelse`)
                VALUES (@handelse);
        ELSEIF OLD.aktiv = FALSE AND NEW.aktiv = TRUE
        THEN
            SET @handelse = CONCAT("Produkten med produktid `", NEW.produkt_id, "` aktiverades.");
            INSERT INTO logg (`handelse`)
                VALUES (@handelse);
        ELSE
            SET @handelse = CONCAT("Detaljer om produktid `", NEW.produkt_id, "` uppdaterades.");
            INSERT INTO logg (`handelse`) VALUES (@handelse);
        END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_produkt_tabort
AFTER DELETE
ON produkt
FOR EACH ROW
BEGIN
     SET @handelse = CONCAT("Detaljer om produktid `", OLD.produkt_id, "` togs bort permanent.");
     INSERT INTO logg (`handelse`) VALUES (@handelse);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt2hylla`
--

DROP TABLE IF EXISTS `produkt2hylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt2hylla` (
  `produkt_id` int(11) NOT NULL,
  `hylla_id` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `antal` int(11) DEFAULT NULL,
  PRIMARY KEY (`produkt_id`,`hylla_id`),
  KEY `hylla_id` (`hylla_id`),
  CONSTRAINT `produkt2hylla_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`),
  CONSTRAINT `produkt2hylla_ibfk_2` FOREIGN KEY (`hylla_id`) REFERENCES `hylla` (`hylla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2hylla`
--

LOCK TABLES `produkt2hylla` WRITE;
/*!40000 ALTER TABLE `produkt2hylla` DISABLE KEYS */;
INSERT INTO `produkt2hylla` VALUES (1,'A101',12),(2,'B201',10),(2,'C201',10),(3,'C201',10),(4,'A201',20),(5,'B101',12);
/*!40000 ALTER TABLE `produkt2hylla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt2kategori`
--

DROP TABLE IF EXISTS `produkt2kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt2kategori` (
  `produkt_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  PRIMARY KEY (`produkt_id`,`kategori_id`),
  KEY `kategori_id` (`kategori_id`),
  CONSTRAINT `produkt2kategori_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`),
  CONSTRAINT `produkt2kategori_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `produktkategori` (`kategori_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2kategori`
--

LOCK TABLES `produkt2kategori` WRITE;
/*!40000 ALTER TABLE `produkt2kategori` DISABLE KEYS */;
INSERT INTO `produkt2kategori` VALUES (1,3),(2,1),(2,2),(3,5),(4,3),(4,6),(8,4),(9,4),(9,5);
/*!40000 ALTER TABLE `produkt2kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produktkategori`
--

DROP TABLE IF EXISTS `produktkategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produktkategori` (
  `kategori_id` int(11) NOT NULL AUTO_INCREMENT,
  `kategorinamn` varchar(30) COLLATE utf8_swedish_ci DEFAULT NULL,
  `kategoribild_lank` varchar(200) COLLATE utf8_swedish_ci DEFAULT NULL,
  `aktiv` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`kategori_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produktkategori`
--

LOCK TABLES `produktkategori` WRITE;
/*!40000 ALTER TABLE `produktkategori` DISABLE KEYS */;
INSERT INTO `produktkategori` VALUES (1,'mugg','mugg.png',1),(2,'porslin','porslin.png',1),(3,'mokabrygg','mokabrygg.png',1),(4,'te','te.png',1),(5,'skiva','skiva.png',1),(6,'espresso','espresso.png',1),(7,'bryggkaffe','bryggkaffe.png',1),(8,'test kategori','raderad.png',0);
/*!40000 ALTER TABLE `produktkategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restnotering`
--

DROP TABLE IF EXISTS `restnotering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restnotering` (
  `restnotering_id` int(11) NOT NULL AUTO_INCREMENT,
  `bestallning_id` int(11) NOT NULL,
  `datum` datetime DEFAULT NULL,
  PRIMARY KEY (`restnotering_id`),
  KEY `bestallning_id` (`bestallning_id`),
  CONSTRAINT `restnotering_ibfk_1` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallning` (`bestallning_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restnotering`
--

LOCK TABLES `restnotering` WRITE;
/*!40000 ALTER TABLE `restnotering` DISABLE KEYS */;
/*!40000 ALTER TABLE `restnotering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restnotering_rad`
--

DROP TABLE IF EXISTS `restnotering_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restnotering_rad` (
  `restnotering_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`restnotering_id`,`produkt_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `restnotering_rad_ibfk_1` FOREIGN KEY (`restnotering_id`) REFERENCES `restnotering` (`restnotering_id`),
  CONSTRAINT `restnotering_rad_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produkt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restnotering_rad`
--

LOCK TABLES `restnotering_rad` WRITE;
/*!40000 ALTER TABLE `restnotering_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `restnotering_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP PROCEDURE IF EXISTS `activate_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `activate_product`(
        p_produkt_id INT
    )
BEGIN    
    UPDATE produkt SET aktiv = TRUE
        WHERE produkt_id = p_produkt_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product`(
        p_produktnamn VARCHAR(150),
        p_pris DECIMAL(10,2),
        p_beskrivning VARCHAR(300),
        p_produktbild_lank VARCHAR(200)
    )
BEGIN
    INSERT INTO produkt(produktnamn, pris, beskrivning, produktbild_lank)
        VALUES(p_produktnamn, p_pris, p_beskrivning, p_produktbild_lank)
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product2category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product2category`(
        IN p_produkt_id INT,
        IN p_kategori_id VARCHAR(100)
    )
BEGIN
    INSERT INTO produkt2kategori(produkt_id, kategori_id)
        VALUES(p_produkt_id, p_kategori_id)
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `decrease_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `decrease_inventory`(
        IN p_produkt_id INT,
        IN p_hylla_id VARCHAR(100),
        IN p_antal INT,
        OUT fel BOOLEAN
    )
BEGIN
    SET @res = NULL;

    SELECT antal 
        FROM produkt2hylla
            WHERE produkt_id = p_produkt_id AND
                hylla_id = p_hylla_id
    INTO @res
    ;
    IF ISNULL(@res) = 0 AND @res >= p_antal THEN
        UPDATE produkt2hylla
            SET antal = antal - p_antal
                WHERE produkt_id = p_produkt_id AND
                    hylla_id = p_hylla_id
        ;
        SET fel = FALSE;
    ELSE
        SET fel = TRUE;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_categories4product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_categories4product`(p_produkt_id INT)
BEGIN
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_product`(
        p_produkt_id INT
    )
BEGIN    
    UPDATE produkt SET aktiv = FALSE
        WHERE produkt_id = p_produkt_id;
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product_permanently` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_product_permanently`(
        p_produkt_id INT
    )
BEGIN
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
    DELETE FROM produkt WHERE produkt_id = p_produkt_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_categories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_categories`()
BEGIN
    SELECT * FROM produktkategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_category`(
        p_category_id INT
    )
BEGIN
    SELECT * FROM produktkategori WHERE kategori_id = p_category_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customers`()
BEGIN
    SELECT * FROM kund;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_inventory`(
        IN search VARCHAR(100)
    )
BEGIN
    SELECT p.produkt_id AS produktid, produktnamn, hylla_id AS hylla, antal FROM produkt AS p
        JOIN produkt2hylla AS p2h
            ON p.produkt_id = p2h.produkt_id
    WHERE p.produkt_id LIKE search
        OR produktnamn LIKE search
        OR hylla_id LIKE search
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_logs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_logs`(
        p_search VARCHAR(50),
        p_number_of_lines INT
    )
BEGIN
    SET @search = IFNULL(p_search, '%%');
    
    IF ISNULL(p_number_of_lines)
    THEN
        SELECT * FROM logg
            WHERE handelse LIKE @search
            ORDER BY tidsstampel DESC
            LIMIT 20;
    ELSE
        SELECT * FROM logg
            WHERE handelse LIKE @search
            ORDER BY tidsstampel DESC
            LIMIT p_number_of_lines;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_product`(
        p_produkt_id INT
    )
BEGIN
    SELECT * FROM produkt WHERE produkt_id = p_produkt_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_products`()
BEGIN
    SELECT p.produkt_id AS id, produktnamn AS namn, IFNULL(SUM(ph.antal),0) AS antal, pris, aktiv,
            (
                SELECT  GROUP_CONCAT(pk.kategorinamn SEPARATOR ', ')
                FROM produktkategori AS pk
                    JOIN produkt2kategori AS p2k
                        ON p2k.kategori_id = pk.kategori_id
                WHERE p.produkt_id = p2k.produkt_id
            ) AS kategorier
    FROM produkt AS p
        LEFT JOIN produkt2hylla AS ph
            ON ph.produkt_id = p.produkt_id
    GROUP BY id
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_products_categories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_products_categories`(p_produkt_id INT)
BEGIN
    SELECT p.kategori_id, kategorinamn FROM produktkategori AS p
        JOIN produkt2kategori AS p2k
            ON p.kategori_id = p2k.kategori_id
    WHERE p2k.produkt_id = p_produkt_id
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_product_in_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_product_in_category`(
        p_category_id INT
    )
BEGIN
    SELECT p.produkt_id, produktnamn, produktbild_lank FROM produkt AS p
        JOIN produkt2kategori AS p2k
            ON p.produkt_id = p2k.produkt_id
    WHERE kategori_id = p_category_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_shelves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shelves`()
BEGIN
    SELECT * FROM hylla;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `increase_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `increase_inventory`(
        IN p_produkt_id INT,
        IN p_hylla_id VARCHAR(100),
        IN p_antal INT
    )
BEGIN
    SET @res = NULL;

    SELECT antal 
        FROM produkt2hylla
            WHERE produkt_id = p_produkt_id AND
                hylla_id = p_hylla_id
    INTO @res
    ;

    IF ISNULL(@res) THEN
        INSERT INTO produkt2hylla(produkt_id, hylla_id, antal)
            VALUES(p_produkt_id, p_hylla_id, p_antal)
        ;
    ELSE
        UPDATE produkt2hylla
            SET antal = antal + p_antal
                WHERE produkt_id = p_produkt_id AND
                    hylla_id = p_hylla_id
        ;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_product`(
        p_produkt_id INT,
        p_produktnamn VARCHAR(150),
        p_pris DECIMAL(10,2),
        p_beskrivning VARCHAR(300),
        p_produktbild_lank VARCHAR(200)
    )
BEGIN    
    UPDATE produkt
        SET produkt_id = p_produkt_id,
            produktnamn = p_produktnamn,
            pris = p_pris,
            beskrivning = p_beskrivning,
            produktbild_lank = p_produktbild_lank
        WHERE produkt_id = p_produkt_id
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

-- Dump completed on 2021-03-05  2:11:29

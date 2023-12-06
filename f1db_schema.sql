-- MySQL dump 10.13  Distrib 8.2.0, for macos14.0 (x86_64)
--
-- Host: localhost    Database: f1db
-- ------------------------------------------------------
-- Server version	8.2.0
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO,ANSI' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table "circuits"
--

DROP TABLE IF EXISTS circuits;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE circuits (
  circuitId int NOT NULL ,
  circuitRef varchar(255) NOT NULL DEFAULT '',
  name varchar(255) NOT NULL DEFAULT '',
  location varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL,
  lat float DEFAULT NULL,
  lng float DEFAULT NULL,
  alt int DEFAULT NULL,
  url varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (circuitId),
  UNIQUE (url)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "constructorResults"
--

DROP TABLE IF EXISTS constructorResults;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE constructorResults (
  constructorResultsId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  constructorId int NOT NULL DEFAULT '0',
  points float DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  PRIMARY KEY (constructorResultsId)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "constructors"
--

DROP TABLE IF EXISTS constructors;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE constructors (
  constructorId int NOT NULL ,
  constructorRef varchar(255) NOT NULL DEFAULT '',
  name varchar(255) NOT NULL DEFAULT '',
  nationality varchar(255) DEFAULT NULL,
  url varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (constructorId),
  UNIQUE (name)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "constructorStandings"
--

DROP TABLE IF EXISTS constructorStandings;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE constructorStandings (
  constructorStandingsId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  constructorId int NOT NULL DEFAULT '0',
  points float NOT NULL DEFAULT '0',
  position int DEFAULT NULL,
  positionText varchar(255) DEFAULT NULL,
  wins int NOT NULL DEFAULT '0',
  PRIMARY KEY (constructorStandingsId)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "drivers"
--

DROP TABLE IF EXISTS drivers CASCADE;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE drivers (
  driverId int NOT NULL ,
  driverRef varchar(255) NOT NULL DEFAULT '',
  number int DEFAULT NULL,
  code varchar(3) DEFAULT NULL,
  forename varchar(255) NOT NULL DEFAULT '',
  surname varchar(255) NOT NULL DEFAULT '',
  dob date DEFAULT NULL,
  nationality varchar(255) DEFAULT NULL,
  url varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (driverId),
  UNIQUE (url)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "driverStandings"
--

DROP TABLE IF EXISTS driverStandings;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE driverStandings (
  driverStandingsId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  driverId int NOT NULL DEFAULT '0',
  points float NOT NULL DEFAULT '0',
  position int DEFAULT NULL,
  positionText varchar(255) DEFAULT NULL,
  wins int NOT NULL DEFAULT '0',
  PRIMARY KEY (driverStandingsId)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "races"
--

DROP TABLE IF EXISTS races CASCADE;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE races (
  raceId int NOT NULL ,
  year int NOT NULL DEFAULT '0',
  round int NOT NULL DEFAULT '0',
  circuitId int NOT NULL DEFAULT '0',
  name varchar(255) NOT NULL DEFAULT '',
  date date,
  time time DEFAULT NULL,
  url varchar(255) DEFAULT NULL,
  fp1_date date DEFAULT NULL,
  fp1_time time DEFAULT NULL,
  fp2_date date DEFAULT NULL,
  fp2_time time DEFAULT NULL,
  fp3_date date DEFAULT NULL,
  fp3_time time DEFAULT NULL,
  quali_date date DEFAULT NULL,
  quali_time time DEFAULT NULL,
  sprint_date date DEFAULT NULL,
  sprint_time time DEFAULT NULL,
  PRIMARY KEY (raceId),
  UNIQUE (url)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "lapTimes"
--

DROP TABLE IF EXISTS lapTimes;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE lapTimes (
  raceId int NOT NULL,
  driverId int NOT NULL,
  lap int NOT NULL,
  position int DEFAULT NULL,
  time varchar(255) DEFAULT NULL,
  milliseconds int DEFAULT NULL,
  PRIMARY KEY (raceId,driverId,lap)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "pitStops"
--

DROP TABLE IF EXISTS pitStops;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE pitStops (
  raceId int NOT NULL,
  driverId int NOT NULL,
  stop int NOT NULL,
  lap int NOT NULL,
  time time NOT NULL,
  duration varchar(255) DEFAULT NULL,
  milliseconds int DEFAULT NULL,
  PRIMARY KEY (raceId,driverId,"stop")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "qualifying"
--

DROP TABLE IF EXISTS qualifying;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE qualifying (
  qualifyId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  driverId int NOT NULL DEFAULT '0',
  constructorId int NOT NULL DEFAULT '0',
  number int NOT NULL DEFAULT '0',
  position int DEFAULT NULL,
  q1 varchar(255) DEFAULT NULL,
  q2 varchar(255) DEFAULT NULL,
  q3 varchar(255) DEFAULT NULL,
  PRIMARY KEY (qualifyId)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "results"
--

DROP TABLE IF EXISTS results;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE results (
  resultId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  driverId int NOT NULL DEFAULT '0',
  constructorId int NOT NULL DEFAULT '0',
  number int DEFAULT NULL,
  grid int NOT NULL DEFAULT '0',
  position int DEFAULT NULL,
  positionText varchar(255) NOT NULL DEFAULT '',
  positionOrder int NOT NULL DEFAULT '0',
  points float NOT NULL DEFAULT '0',
  laps int NOT NULL DEFAULT '0',
  time varchar(255) DEFAULT NULL,
  milliseconds int DEFAULT NULL,
  fastestLap int DEFAULT NULL,
  rank int DEFAULT '0',
  fastestLapTime varchar(255) DEFAULT NULL,
  fastestLapSpeed varchar(255) DEFAULT NULL,
  statusId int NOT NULL DEFAULT '0',
  PRIMARY KEY (resultId)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "seasons"
--

DROP TABLE IF EXISTS seasons;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE seasons (
  year int NOT NULL DEFAULT '0',
  url varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("year"),
  UNIQUE (url)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "sprintResults"
--

DROP TABLE IF EXISTS sprintResults;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE sprintResults (
  sprintResultId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  driverId int NOT NULL DEFAULT '0',
  constructorId int NOT NULL DEFAULT '0',
  number int NOT NULL DEFAULT '0',
  grid int NOT NULL DEFAULT '0',
  position int DEFAULT NULL,
  positionText varchar(255) NOT NULL DEFAULT '',
  positionOrder int NOT NULL DEFAULT '0',
  points float NOT NULL DEFAULT '0',
  laps int NOT NULL DEFAULT '0',
  time varchar(255) DEFAULT NULL,
  milliseconds int DEFAULT NULL,
  fastestLap int DEFAULT NULL,
  fastestLapTime varchar(255) DEFAULT NULL,
  statusId int NOT NULL DEFAULT '0',
  PRIMARY KEY (sprintResultId)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "status"
--

DROP TABLE IF EXISTS status;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE status (
  statusId int NOT NULL ,
  status varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (statusId)
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-05 10:15:15

-- MySQL dump 10.13  Distrib 8.2.0, for macos14.0 (x86_64)
--
-- Host: localhost    Database: f1db
-- ------------------------------------------------------
-- Server version	8.2.0

--
-- Table structure for table "circuits"
--

DROP TABLE IF EXISTS circuits;

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

--
-- Table structure for table "constructorResults"
--

DROP TABLE IF EXISTS constructorResults;

CREATE TABLE constructorResults (
  constructorResultsId int NOT NULL ,
  raceId int NOT NULL DEFAULT '0',
  constructorId int NOT NULL DEFAULT '0',
  points float DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  PRIMARY KEY (constructorResultsId)
);

--
-- Table structure for table "constructors"
--

DROP TABLE IF EXISTS constructors;
CREATE TABLE constructors (
  constructorId int NOT NULL ,
  constructorRef varchar(255) NOT NULL DEFAULT '',
  name varchar(255) NOT NULL DEFAULT '',
  nationality varchar(255) DEFAULT NULL,
  url varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (constructorId),
  UNIQUE (name)
);

--
-- Table structure for table "constructorStandings"
--

DROP TABLE IF EXISTS constructorStandings;

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

--
-- Table structure for table "drivers"
--

DROP TABLE IF EXISTS drivers CASCADE;

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

--
-- Table structure for table "driverStandings"
--

DROP TABLE IF EXISTS driverStandings;

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

--
-- Table structure for table "races"
--

DROP TABLE IF EXISTS races CASCADE;
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

--
-- Table structure for table "lapTimes"
--

DROP TABLE IF EXISTS lapTimes;

CREATE TABLE lapTimes (
  raceId int NOT NULL,
  driverId int NOT NULL,
  lap int NOT NULL,
  position int DEFAULT NULL,
  time varchar(255) DEFAULT NULL,
  milliseconds int DEFAULT NULL,
  PRIMARY KEY (raceId,driverId,lap)
);

--
-- Table structure for table "pitStops"
--

DROP TABLE IF EXISTS pitStops;

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

--
-- Table structure for table "qualifying"
--

DROP TABLE IF EXISTS qualifying;

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

--
-- Table structure for table "results"
--

DROP TABLE IF EXISTS results;

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

--
-- Table structure for table "seasons"
--

DROP TABLE IF EXISTS seasons;

CREATE TABLE seasons (
  year int NOT NULL DEFAULT '0',
  url varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("year"),
  UNIQUE (url)
);

--
-- Table structure for table "sprintResults"
--

DROP TABLE IF EXISTS sprintResults;

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

--
-- Table structure for table "status"
--

DROP TABLE IF EXISTS status;

CREATE TABLE status (
  statusId int NOT NULL ,
  status varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (statusId)
);


-- Dump completed on 2023-12-05 10:15:15

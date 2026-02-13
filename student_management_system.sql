-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: student_management_system
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `admission_inquiry`
--

DROP TABLE IF EXISTS `admission_inquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admission_inquiry` (
  `inquiry_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `program_id` int NOT NULL,
  `inquiry_date` date DEFAULT NULL,
  `status` enum('New','Contacted','Converted','Rejected') DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`inquiry_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `admission_inquiry_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_inquiry`
--

LOCK TABLES `admission_inquiry` WRITE;
/*!40000 ALTER TABLE `admission_inquiry` DISABLE KEYS */;
INSERT INTO `admission_inquiry` VALUES (1,'Rahul',NULL,'Kumar','rahul@mail.com','9011111111',1,'2023-01-10','Converted',NULL),(2,'Neha',NULL,'Gupta','neha@mail.com','9011111112',1,'2023-01-12','Contacted',NULL),(3,'Aman',NULL,'Verma','aman@mail.com','9011111113',3,'2023-02-01','Converted',NULL),(4,'Priti',NULL,'Joshi','priti@mail.com','9011111114',2,'2023-02-05','Rejected',NULL),(5,'Kunal',NULL,'Mehta','kunal@mail.com','9011111115',4,'2023-02-10','New',NULL),(6,'Riya',NULL,'Sharma','riya@mail.com','9011111116',1,'2023-03-01','Converted',NULL),(7,'Sahil',NULL,'Patel','sahil@mail.com','9011111117',3,'2023-03-05','Contacted',NULL),(8,'Anjali',NULL,'Rao','anjali@mail.com','9011111118',2,'2023-03-10','New',NULL),(9,'Varun',NULL,'Kapoor','varun@mail.com','9011111119',1,'2023-04-01','Converted',NULL),(10,'Sneha',NULL,'Malik','sneha@mail.com','9011111120',4,'2023-04-05','New',NULL);
/*!40000 ALTER TABLE `admission_inquiry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `inquiry_id` int NOT NULL,
  `program_id` int NOT NULL,
  `application_number` varchar(30) DEFAULT NULL,
  `application_date` date DEFAULT NULL,
  `status` enum('Applied','Withdrawn','Under Review','Document Verification','Interview Scheduled','Accepted','Rejected','Waitlisted') DEFAULT NULL,
  `entrance_exam_score` decimal(5,2) DEFAULT NULL,
  `entrance_exam_date` date DEFAULT NULL,
  `entrance_exam_status` enum('Not Taken','Scheduled','Passed','Failed') DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `application_number` (`application_number`),
  KEY `inquiry_id` (`inquiry_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`inquiry_id`) REFERENCES `admission_inquiry` (`inquiry_id`),
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_document`
--

DROP TABLE IF EXISTS `application_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_document` (
  `document_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `document_path` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `uploaded_date` date DEFAULT NULL,
  `verified_by` int DEFAULT NULL,
  `verification_date` date DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `application_id` (`application_id`),
  KEY `verified_by` (`verified_by`),
  CONSTRAINT `application_document_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  CONSTRAINT `application_document_ibfk_2` FOREIGN KEY (`verified_by`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_document`
--

LOCK TABLES `application_document` WRITE;
/*!40000 ALTER TABLE `application_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendanceemployee`
--

DROP TABLE IF EXISTS `attendanceemployee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendanceemployee` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `biometric_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `attendanceemployee_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendanceemployee`
--

LOCK TABLES `attendanceemployee` WRITE;
/*!40000 ALTER TABLE `attendanceemployee` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendanceemployee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendancestudent`
--

DROP TABLE IF EXISTS `attendancestudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendancestudent` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `offering_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `student_id` (`student_id`),
  KEY `offering_id` (`offering_id`),
  CONSTRAINT `attendancestudent_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `attendancestudent_ibfk_2` FOREIGN KEY (`offering_id`) REFERENCES `course_offering` (`offering_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendancestudent`
--

LOCK TABLES `attendancestudent` WRITE;
/*!40000 ALTER TABLE `attendancestudent` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendancestudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `building_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `classroom_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int DEFAULT NULL,
  `room_number` varchar(255) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`classroom_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `classroom_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) DEFAULT NULL,
  `credits` float DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_offering`
--

DROP TABLE IF EXISTS `course_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_offering` (
  `offering_id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `program_id` int DEFAULT NULL,
  `semester_id` int DEFAULT NULL,
  `academic_year` varchar(255) DEFAULT NULL,
  `cycle` varchar(255) DEFAULT NULL,
  `day_pattern` varchar(255) DEFAULT NULL,
  `faculty_id` int DEFAULT NULL,
  `unit_block` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`offering_id`),
  KEY `type_id` (`type_id`),
  KEY `program_id` (`program_id`),
  KEY `semester_id` (`semester_id`),
  KEY `faculty_id` (`faculty_id`),
  CONSTRAINT `course_offering_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `course_type` (`type_id`),
  CONSTRAINT `course_offering_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `course_offering_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`),
  CONSTRAINT `course_offering_ibfk_4` FOREIGN KEY (`faculty_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offering`
--

LOCK TABLES `course_offering` WRITE;
/*!40000 ALTER TABLE `course_offering` DISABLE KEYS */;
INSERT INTO `course_offering` VALUES (1,'Foundation Design Studio',4,1,6,'2023-2024','Cycle A','Mon-Thu',13,'Studio Block A'),(2,'Visual Communication Studio',2,1,6,'2023-2024','Cycle B','Tue-Fri',14,'Studio Block B'),(3,'Creative Coding Workshop',3,1,5,'2023-2024','Intensive','Mon-Fri',13,'Computer Lab'),(4,'Design Research Methods',1,1,5,'2023-2024','Cycle A','Wednesday',14,'Lecture Hall 2'),(5,'Public Space Design Studio',1,1,7,'2024-2025','Cycle A','Mon-Thu',15,'Studio Block C'),(6,'Drawing & Observation',2,2,6,'2023-2024','Cycle A','Mon-Tue',13,'Fine Arts Studio'),(7,'Contemporary Art Practice',2,2,6,'2023-2024','Cycle B','Wed-Fri',13,'Painting Studio'),(8,'Photography Workshop',2,2,5,'2023-2024','Intensive','Mon-Fri',14,'Media Lab'),(9,'Art History GS',2,2,5,'2023-2024','Cycle A','Thursday',16,'Lecture Hall 1'),(10,'Film & Media Studio',2,2,7,'2024-2025','Cycle A','Mon-Thu',15,'Film Studio'),(11,'Interior Design Basics',2,3,2,'2023-2024','Cycle A','Mon-Tue',13,'Design Lab 1'),(12,'UX Fundamentals',2,3,2,'2023-2024','Cycle B','Wed-Thu',14,'UX Lab'),(13,'Industry Internship',3,3,3,'2023-2024','Full Term','Full Week',13,'Industry'),(14,'Professional Practice GS',3,3,2,'2023-2024','Cycle A','Friday',14,'Lecture Hall 3'),(15,'Portfolio Development',3,3,4,'2024-2025','Cycle A','Mon-Thu',15,'Studio Block D'),(16,'Advanced Design Studio',4,4,2,'2023-2024','Cycle A','Mon-Thu',13,'Postgrad Studio'),(17,'Design Theory & Criticism',4,4,1,'2023-2024','Cycle B','Wednesday',14,'Seminar Room'),(18,'Speculative Futures Workshop',4,4,2,'2023-2024','Intensive','Mon-Fri',15,'Innovation Lab'),(19,'Research Methodology',4,4,1,'2023-2024','Cycle A','Thursday',14,'Lecture Hall PG'),(20,'Thesis Studio',5,4,3,'2024-2025','Cycle A','Mon-Thu',15,'Thesis Studio');
/*!40000 ALTER TABLE `course_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_type`
--

DROP TABLE IF EXISTS `course_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  `credits` int DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_type`
--

LOCK TABLES `course_type` WRITE;
/*!40000 ALTER TABLE `course_type` DISABLE KEYS */;
INSERT INTO `course_type` VALUES (1,'Studio - 4 Credits',4),(2,'Workshop',3),(3,'Interim',4),(4,'Studio - 2 Credits',2),(5,'General Studies (GS)',3);
/*!40000 ALTER TABLE `course_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cumulativeresult`
--

DROP TABLE IF EXISTS `cumulativeresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cumulativeresult` (
  `student_id` int NOT NULL,
  `overall_gpa` float DEFAULT NULL,
  `overall_pass_fail` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `cumulativeresult_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cumulativeresult`
--

LOCK TABLES `cumulativeresult` WRITE;
/*!40000 ALTER TABLE `cumulativeresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `cumulativeresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,1,'Sneha',NULL,'Jacob','MDes','Design Systems','admin1@uni.edu','900000001'),(2,2,'Ravi',NULL,'Sharma','MFA','Visual Design','fac1@uni.edu','900000002'),(3,3,'Anita',NULL,'Iyer','MDes','UX','fac2@uni.edu','900000003'),(4,9,'Karan',NULL,'Mehta','PhD','Media','fac3@uni.edu','900000009');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_sabbatical`
--

DROP TABLE IF EXISTS `employee_sabbatical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_sabbatical` (
  `sabbatical_id` int NOT NULL AUTO_INCREMENT,
  `history_id` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expected_return_date` date DEFAULT NULL,
  `actual_return_date` date DEFAULT NULL,
  `reason` text,
  `status` varchar(255) DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  PRIMARY KEY (`sabbatical_id`),
  KEY `history_id` (`history_id`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `employee_sabbatical_ibfk_1` FOREIGN KEY (`history_id`) REFERENCES `employment_history` (`history_id`),
  CONSTRAINT `employee_sabbatical_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_sabbatical`
--

LOCK TABLES `employee_sabbatical` WRITE;
/*!40000 ALTER TABLE `employee_sabbatical` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_sabbatical` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employment_history`
--

DROP TABLE IF EXISTS `employment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employment_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `employment_type` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `employment_history_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employment_history`
--

LOCK TABLES `employment_history` WRITE;
/*!40000 ALTER TABLE `employment_history` DISABLE KEYS */;
INSERT INTO `employment_history` VALUES (1,13,'Permanent','Admin','2019-06-01',NULL,'Active'),(2,14,'Permanent','Faculty','2020-01-01',NULL,'Active'),(3,15,'Visiting','Faculty','2023-07-01',NULL,'Active'),(4,16,'Adjunct','Faculty','2022-06-01',NULL,'Completed');
/*!40000 ALTER TABLE `employment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `enrollment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `program_id` int DEFAULT NULL,
  `assigned_major_id` int DEFAULT NULL,
  `semester_id` int NOT NULL,
  `enrollment_date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `cgpa` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`enrollment_id`),
  KEY `student_id` (`student_id`),
  KEY `program_id` (`program_id`),
  KEY `assigned_major_id` (`assigned_major_id`),
  KEY `semester_id` (`semester_id`),
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `enrollment_ibfk_3` FOREIGN KEY (`assigned_major_id`) REFERENCES `major` (`major_id`),
  CONSTRAINT `enrollment_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (1,9,1,220,6,'2022-07-01','Active',NULL),(2,10,1,221,6,'2022-07-01','Active',NULL),(3,11,3,222,2,'2021-07-01','Active',NULL),(4,12,1,330,4,'2023-07-01','Active',NULL);
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `offering_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `offering_id` (`offering_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `exam_ibfk_1` FOREIGN KEY (`offering_id`) REFERENCES `course_offering` (`offering_id`),
  CONSTRAINT `exam_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_program`
--

DROP TABLE IF EXISTS `exchange_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_program` (
  `exchange_program_id` int NOT NULL AUTO_INCREMENT,
  `institution_id` int NOT NULL,
  `eligible_program_id` int NOT NULL,
  `program_name` varchar(100) DEFAULT NULL,
  `exchange_type` enum('Incoming','Outgoing') DEFAULT NULL,
  `duration_months` int DEFAULT NULL,
  `max_students` int DEFAULT NULL,
  `minimum_cgpa` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`exchange_program_id`),
  KEY `institution_id` (`institution_id`),
  KEY `eligible_program_id` (`eligible_program_id`),
  CONSTRAINT `exchange_program_ibfk_1` FOREIGN KEY (`institution_id`) REFERENCES `partner_institution` (`institution_id`),
  CONSTRAINT `exchange_program_ibfk_2` FOREIGN KEY (`eligible_program_id`) REFERENCES `program` (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_program`
--

LOCK TABLES `exchange_program` WRITE;
/*!40000 ALTER TABLE `exchange_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_student`
--

DROP TABLE IF EXISTS `exchange_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_student` (
  `exchange_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `exchange_program_id` int NOT NULL,
  `home_institution_state` varchar(50) DEFAULT NULL,
  `host_institution_state` varchar(50) DEFAULT NULL,
  `application_date` date DEFAULT NULL,
  `application_status` enum('Applied','Accepted','Rejected','Withdrawn') DEFAULT NULL,
  `cgpa_at_application` decimal(4,2) DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `expected_return_date` date DEFAULT NULL,
  `actual_return_date` date DEFAULT NULL,
  PRIMARY KEY (`exchange_id`),
  KEY `student_id` (`student_id`),
  KEY `exchange_program_id` (`exchange_program_id`),
  CONSTRAINT `exchange_student_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `exchange_student_ibfk_2` FOREIGN KEY (`exchange_program_id`) REFERENCES `exchange_program` (`exchange_program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_student`
--

LOCK TABLES `exchange_student` WRITE;
/*!40000 ALTER TABLE `exchange_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `major_id` int NOT NULL AUTO_INCREMENT,
  `program_id` int DEFAULT NULL,
  `major_code` varchar(255) DEFAULT NULL,
  `major_name` varchar(255) DEFAULT NULL,
  `description` text,
  `credits` int DEFAULT NULL,
  PRIMARY KEY (`major_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `major_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (110,3,'ID','Interior Design','Interior and spatial design',100),(111,3,'GD','Graphic Design','Graphic and visual design',100),(112,3,'UX','UX Design','User experience design',100),(220,1,'BSSD','Business Service and Systems Design','Study of systems and business services',120),(221,1,'HCD','Human Centered Design','Study of UI and UX',120),(222,1,'VSCB','Visual Communication and Strategic Branding','Study of fonts, colour, and branding',120),(223,1,'CAC','Creative Applied Computation','Study of creative coding',120),(224,1,'CE','Creative Education','Study of educational tools and toys',120),(225,1,'PSD','Public Space Design','Study of landscaping and architectural drawing',120),(226,1,'IADP','Industrial Arts and Design Practices','Product, furniture, textile design',120),(227,1,'IAIDP','Information Arts and Information Design Practices','Visualisation and character drawing',120),(330,4,'CAP','Contemporary Art Practices','Study of modern art',60),(331,4,'DMA','Digital Media Art','Study of animation',60),(332,4,'FILM','Film & Media Studies','Photography, film and media',60);
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major_minor_options`
--

DROP TABLE IF EXISTS `major_minor_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major_minor_options` (
  `major_id` int NOT NULL,
  `minor_major_id` int NOT NULL,
  PRIMARY KEY (`major_id`,`minor_major_id`),
  KEY `minor_major_id` (`minor_major_id`),
  CONSTRAINT `major_minor_options_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `major` (`major_id`),
  CONSTRAINT `major_minor_options_ibfk_2` FOREIGN KEY (`minor_major_id`) REFERENCES `major` (`major_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major_minor_options`
--

LOCK TABLES `major_minor_options` WRITE;
/*!40000 ALTER TABLE `major_minor_options` DISABLE KEYS */;
INSERT INTO `major_minor_options` VALUES (111,110),(110,111),(222,220),(223,220),(225,220),(220,221),(222,221),(223,221),(226,221),(223,222),(226,222),(220,223),(220,226),(225,226),(331,330),(332,330),(332,331),(331,332);
/*!40000 ALTER TABLE `major_minor_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major_preference`
--

DROP TABLE IF EXISTS `major_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major_preference` (
  `preference_id` int NOT NULL AUTO_INCREMENT,
  `application_id` int NOT NULL,
  `major_id` int NOT NULL,
  `preference_rank` int DEFAULT NULL,
  `allocation_status` enum('Accepted','Waitlisted','Rejected','Pending') DEFAULT NULL,
  PRIMARY KEY (`preference_id`),
  UNIQUE KEY `unique_application_rank` (`application_id`,`preference_rank`),
  KEY `major_id` (`major_id`),
  CONSTRAINT `major_preference_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  CONSTRAINT `major_preference_ibfk_2` FOREIGN KEY (`major_id`) REFERENCES `major` (`major_id`),
  CONSTRAINT `chk_preference_rank` CHECK ((`preference_rank` between 1 and 4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major_preference`
--

LOCK TABLES `major_preference` WRITE;
/*!40000 ALTER TABLE `major_preference` DISABLE KEYS */;
/*!40000 ALTER TABLE `major_preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent`
--

DROP TABLE IF EXISTS `parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parent` (
  `parent_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`parent_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `parent_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent`
--

LOCK TABLES `parent` WRITE;
/*!40000 ALTER TABLE `parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_institution`
--

DROP TABLE IF EXISTS `partner_institution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner_institution` (
  `institution_id` int NOT NULL AUTO_INCREMENT,
  `institution_name` varchar(150) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`institution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_institution`
--

LOCK TABLES `partner_institution` WRITE;
/*!40000 ALTER TABLE `partner_institution` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_institution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_history`
--

DROP TABLE IF EXISTS `password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_history` (
  `password_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `changed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`password_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_history`
--

LOCK TABLES `password_history` WRITE;
/*!40000 ALTER TABLE `password_history` DISABLE KEYS */;
INSERT INTO `password_history` VALUES (1,1,'hash1','2026-02-10 12:46:17',0),(2,1,'hash2','2026-02-10 12:46:17',1),(3,2,'hash3','2026-02-10 12:46:17',1),(4,3,'hash4','2026-02-10 12:46:17',1),(5,4,'hash5','2026-02-10 12:46:17',1),(6,5,'hash6','2026-02-10 12:46:17',1),(7,6,'hash7','2026-02-10 12:46:17',1),(8,7,'hash8','2026-02-10 12:46:17',1),(9,8,'hash9','2026-02-10 12:46:17',1),(10,9,'hash10','2026-02-10 12:46:17',1);
/*!40000 ALTER TABLE `password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `program_name` varchar(255) DEFAULT NULL,
  `program_level` varchar(255) DEFAULT NULL,
  `duration_years` int DEFAULT NULL,
  `credits_required` int DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (1,'Bachelor of Design','Undergraduate',4,120,'Four-year undergraduate program in design'),(2,'Bachelor of Fine Arts','Undergraduate',4,120,'Four-year undergraduate program in fine arts and humanities'),(3,'Bachelor of Vocation','Undergraduate',4,120,'Four-year undergraduate program in applied vocational studies'),(4,'Master of Design','Postgraduate',2,60,'Two-year postgraduate program'),(5,'Doctor of Philosophy','Postgraduate',5,60,'Doctoral research program');
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `offering_id` int DEFAULT NULL,
  `classroom_id` int DEFAULT NULL,
  `time_block` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `offering_id` (`offering_id`),
  KEY `classroom_id` (`classroom_id`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`offering_id`) REFERENCES `course_offering` (`offering_id`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `semester_id` int NOT NULL AUTO_INCREMENT,
  `program_id` int NOT NULL,
  `semester_number` int NOT NULL,
  `is_current` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`semester_id`),
  UNIQUE KEY `unique_program_semester` (`program_id`,`semester_number`),
  CONSTRAINT `semester_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (1,1,1,0),(2,1,2,0),(3,1,3,0),(4,1,4,0),(5,1,5,0),(6,1,6,1),(7,1,7,0),(8,1,8,0),(9,2,1,0),(10,2,2,0),(11,2,3,0),(12,2,4,0),(13,2,5,0),(14,2,6,1),(15,2,7,0),(16,2,8,0),(17,3,1,0),(18,3,2,1),(19,3,3,0),(20,3,4,0),(21,3,5,0),(22,3,6,0),(23,4,1,0),(24,4,2,1),(25,4,3,0),(26,4,4,0);
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semesterresult`
--

DROP TABLE IF EXISTS `semesterresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semesterresult` (
  `result_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `semester_id` int DEFAULT NULL,
  `semester_gpa` float DEFAULT NULL,
  `pass_fail` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`result_id`),
  KEY `student_id` (`student_id`),
  KEY `semester_id` (`semester_id`),
  CONSTRAINT `semesterresult_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `semesterresult_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semesterresult`
--

LOCK TABLES `semesterresult` WRITE;
/*!40000 ALTER TABLE `semesterresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `semesterresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `emergency_contact` varchar(255) DEFAULT NULL,
  `emergency_phone` varchar(255) DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `medical_conditions` text,
  `enrollment_date` date DEFAULT NULL,
  `enrollment_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,4,'Aarav',NULL,'Patel','2004-03-12','Male',NULL,'Ahmedabad','Gujarat',NULL,NULL,NULL,NULL,NULL,'2022-07-01','Active'),(2,5,'Diya',NULL,'Shah','2004-08-19','Female',NULL,'Mumbai','Maharashtra',NULL,NULL,NULL,NULL,NULL,'2022-07-01','Active'),(3,6,'Kabir',NULL,'Singh','2003-11-02','Male',NULL,'Delhi','Delhi',NULL,NULL,NULL,NULL,NULL,'2021-07-01','Active'),(4,10,'Isha',NULL,'Verma','2005-01-15','Female',NULL,'Bhopal','MP',NULL,NULL,NULL,NULL,NULL,'2023-07-01','Active');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_parent`
--

DROP TABLE IF EXISTS `student_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_parent` (
  `student_id` int NOT NULL,
  `parent_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`parent_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `student_parent_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `student_parent_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_parent`
--

LOCK TABLES `student_parent` WRITE;
/*!40000 ALTER TABLE `student_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `summative_assessment`
--

DROP TABLE IF EXISTS `summative_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `summative_assessment` (
  `assessment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `grade_point` int DEFAULT NULL,
  `student_attendance_id` int DEFAULT NULL,
  PRIMARY KEY (`assessment_id`),
  KEY `student_id` (`student_id`),
  KEY `exam_id` (`exam_id`),
  KEY `student_attendance_id` (`student_attendance_id`),
  CONSTRAINT `summative_assessment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `summative_assessment_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`),
  CONSTRAINT `summative_assessment_ibfk_3` FOREIGN KEY (`student_attendance_id`) REFERENCES `attendancestudent` (`attendance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `summative_assessment`
--

LOCK TABLES `summative_assessment` WRITE;
/*!40000 ALTER TABLE `summative_assessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `summative_assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_assessment`
--

DROP TABLE IF EXISTS `unit_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit_assessment` (
  `unit_assessment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `offering_id` int DEFAULT NULL,
  `grade_point` int DEFAULT NULL,
  `marks_obtained` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`unit_assessment_id`),
  KEY `student_id` (`student_id`),
  KEY `offering_id` (`offering_id`),
  CONSTRAINT `unit_assessment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `unit_assessment_ibfk_2` FOREIGN KEY (`offering_id`) REFERENCES `course_offering` (`offering_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_assessment`
--

LOCK TABLES `unit_assessment` WRITE;
/*!40000 ALTER TABLE `unit_assessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `unit_assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin1','admin1@uni.edu','900000001','Employee','2026-02-10 12:45:44',NULL,1),(2,'faculty1','fac1@uni.edu','900000002','Employee','2026-02-10 12:45:44',NULL,1),(3,'faculty2','fac2@uni.edu','900000003','Employee','2026-02-10 12:45:44',NULL,1),(4,'student1','stud1@uni.edu','900000004','Student','2026-02-10 12:45:44',NULL,1),(5,'student2','stud2@uni.edu','900000005','Student','2026-02-10 12:45:44',NULL,1),(6,'student3','stud3@uni.edu','900000006','Student','2026-02-10 12:45:44',NULL,1),(7,'parent1','parent1@mail.com','900000007','Parent','2026-02-10 12:45:44',NULL,1),(8,'parent2','parent2@mail.com','900000008','Parent','2026-02-10 12:45:44',NULL,1),(9,'faculty3','fac3@uni.edu','900000009','Employee','2026-02-10 12:45:44',NULL,1),(10,'student4','stud4@uni.edu','900000010','Student','2026-02-10 12:45:44',NULL,1);
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

-- Dump completed on 2026-02-10 18:55:04

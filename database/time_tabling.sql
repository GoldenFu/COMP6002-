/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : time_tabling

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2023-09-06 19:50:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `userId` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `departmentId` int(100) NOT NULL,
  `departmentName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`departmentId`),
  KEY `departmentName` (`departmentName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `studentName` varchar(255) NOT NULL,
  `staffName` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `dayOfWeek` varchar(255) NOT NULL,
  KEY `Name` (`studentName`) USING BTREE,
  KEY `111` (`location`),
  KEY `ss` (`startTime`),
  KEY `ee` (`endTime`),
  KEY `dd` (`dayOfWeek`),
  CONSTRAINT `111` FOREIGN KEY (`location`) REFERENCES `venue` (`location`),
  CONSTRAINT `Name` FOREIGN KEY (`studentName`) REFERENCES `student` (`studentName`),
  CONSTRAINT `dd` FOREIGN KEY (`dayOfWeek`) REFERENCES `timeslot` (`dayOfWeek`),
  CONSTRAINT `ee` FOREIGN KEY (`endTime`) REFERENCES `timeslot` (`endTime`),
  CONSTRAINT `ss` FOREIGN KEY (`startTime`) REFERENCES `timeslot` (`startTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staffId` int(100) NOT NULL,
  `staffName` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Phone` varchar(255) DEFAULT NULL,
  `departmentName` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`staffId`),
  KEY `staffName` (`staffName`),
  KEY `dd1` (`departmentName`),
  CONSTRAINT `dd1` FOREIGN KEY (`departmentName`) REFERENCES `department` (`departmentName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staff_unit
-- ----------------------------
DROP TABLE IF EXISTS `staff_unit`;
CREATE TABLE `staff_unit` (
  `staffName` varchar(255) DEFAULT NULL,
  `unitCode` varchar(255) DEFAULT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `unitName` varchar(255) DEFAULT NULL,
  KEY `staffName` (`staffName`),
  KEY `unitCode` (`unitCode`),
  KEY `1` (`unitName`),
  CONSTRAINT `1` FOREIGN KEY (`unitName`) REFERENCES `unit` (`unitName`),
  CONSTRAINT `staffName` FOREIGN KEY (`staffName`) REFERENCES `staff` (`staffName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `unitCode` FOREIGN KEY (`unitCode`) REFERENCES `unit` (`unitCode`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staff_user
-- ----------------------------
DROP TABLE IF EXISTS `staff_user`;
CREATE TABLE `staff_user` (
  `userId` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `staffId` int(100) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  KEY `staffId` (`staffId`),
  CONSTRAINT `staff_user_ibfk_1` FOREIGN KEY (`staffId`) REFERENCES `staff` (`staffId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentId` int(100) NOT NULL,
  `studentName` varchar(255) NOT NULL,
  `departmentName` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`studentId`),
  KEY `studentName` (`studentName`),
  KEY `dd2` (`departmentName`),
  CONSTRAINT `dd2` FOREIGN KEY (`departmentName`) REFERENCES `department` (`departmentName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for student_unit
-- ----------------------------
DROP TABLE IF EXISTS `student_unit`;
CREATE TABLE `student_unit` (
  `studentName` varchar(255) DEFAULT NULL,
  `unitName` varchar(255) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `endTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  KEY `studentName` (`studentName`),
  KEY `unitName` (`unitName`),
  CONSTRAINT `studentName` FOREIGN KEY (`studentName`) REFERENCES `student` (`studentName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `unitName` FOREIGN KEY (`unitName`) REFERENCES `unit` (`unitName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for student_user
-- ----------------------------
DROP TABLE IF EXISTS `student_user`;
CREATE TABLE `student_user` (
  `userId` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `studentId` int(100) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  KEY `studentId` (`studentId`),
  CONSTRAINT `student_user_ibfk_1` FOREIGN KEY (`studentId`) REFERENCES `student` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for timeslot
-- ----------------------------
DROP TABLE IF EXISTS `timeslot`;
CREATE TABLE `timeslot` (
  `timeSlotId` int(100) NOT NULL,
  `dayOfWeek` varchar(255) NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `unitName` varchar(255) NOT NULL,
  PRIMARY KEY (`timeSlotId`),
  KEY `startTime` (`startTime`),
  KEY `endTime` (`endTime`),
  KEY `dayOfWeek` (`dayOfWeek`),
  KEY `uni` (`unitName`),
  KEY `startTime_2` (`startTime`,`endTime`),
  CONSTRAINT `uni` FOREIGN KEY (`unitName`) REFERENCES `unit` (`unitName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `unitId` int(100) NOT NULL AUTO_INCREMENT,
  `unitCode` varchar(255) NOT NULL,
  `unitName` varchar(255) NOT NULL,
  `unitCh` int(100) NOT NULL,
  `unitCredit` int(100) NOT NULL,
  `venueName` varchar(255) NOT NULL,
  `departmentName` varchar(255) NOT NULL,
  `duration` float(100,0) NOT NULL,
  PRIMARY KEY (`unitId`),
  KEY `unitName` (`unitName`),
  KEY `unitCode` (`unitCode`),
  KEY `de` (`departmentName`),
  KEY `ve` (`venueName`),
  CONSTRAINT `de` FOREIGN KEY (`departmentName`) REFERENCES `department` (`departmentName`),
  CONSTRAINT `ve` FOREIGN KEY (`venueName`) REFERENCES `venue` (`venueName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for venue
-- ----------------------------
DROP TABLE IF EXISTS `venue`;
CREATE TABLE `venue` (
  `venueId` int(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `venueName` varchar(255) NOT NULL,
  `capacity` int(100) NOT NULL,
  `roomDetail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`venueId`),
  KEY `location` (`location`),
  KEY `venueName` (`venueName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for venue_unit
-- ----------------------------
DROP TABLE IF EXISTS `venue_unit`;
CREATE TABLE `venue_unit` (
  `unitName` varchar(255) NOT NULL,
  `venueName` varchar(255) NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  KEY `222` (`unitName`),
  KEY `333` (`startTime`,`endTime`),
  KEY `4` (`venueName`),
  CONSTRAINT `222` FOREIGN KEY (`unitName`) REFERENCES `unit` (`unitName`),
  CONSTRAINT `333` FOREIGN KEY (`startTime`, `endTime`) REFERENCES `timeslot` (`startTime`, `endTime`),
  CONSTRAINT `4` FOREIGN KEY (`venueName`) REFERENCES `venue` (`venueName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
SQLyog Community Edition- MySQL GUI v6.07
Host - 5.0.67-community-nt : Database - kb
*********************************************************************
Server version : 5.0.67-community-nt
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `kb`;

USE `kb`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `experts` */

DROP TABLE IF EXISTS `experts`;

CREATE TABLE `experts` (
  `ExpertId` varchar(11) NOT NULL,
  `Name` varchar(100) default NULL,
  `EmailId` varchar(100) NOT NULL,
  `PrimarySkills` tinytext,
  `SecondarySkills` tinytext,
  `Experience` int(3) default NULL,
  `CurrentProject` varchar(255) default NULL,
  `PreviousProject` varchar(255) default NULL,
  `PhoneNumber` varchar(20) default '0',
  PRIMARY KEY  (`EmailId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `experts` */

insert  into `experts`(`ExpertId`,`Name`,`EmailId`,`PrimarySkills`,`SecondarySkills`,`Experience`,`CurrentProject`,`PreviousProject`,`PhoneNumber`) values ('EX04','a','asagmail.com','a','a',3,'a','a','0'),('EX06','guru','guru@gmail.com','c','cpp',45,'pp','pp','0'),('EX03','Meenu','Meenu_M@gmail.com','VB,.Net','Windows 2k3 Administration',24,'Bench','Royal Hotels','991099110'),('EX01','Raj Malhotra','RajMalhotra@gmail.com','J2EE,Java','Oracle,MySQL',36,'NA','NA','0'),('EX05','sai','sai@gamil.com','a','a',3,'a','a','0'),('EX02','Sri','Srinivas@gmail.com','C','C++,oracle',48,'CodePro','NA','0');

/*Table structure for table `kbdata` */

DROP TABLE IF EXISTS `kbdata`;

CREATE TABLE `kbdata` (
  `KId` varchar(50) NOT NULL,
  `Title` varchar(255) default NULL,
  `Author` varchar(255) default NULL,
  `DateOfCreation` date default NULL,
  `DateOfSubmission` date default NULL,
  `Keywords` varchar(255) default NULL,
  `Technology` varchar(255) default NULL,
  `Reference` varchar(255) default NULL,
  `Description` text,
  `ContentType` varchar(100) default NULL COMMENT 'Knowledge Asset, Reusable Asset,Book review, Sofware Review,Others',
  `TargetUsers` varchar(100) default NULL COMMENT 'Developers,Managers,All,Analysts,Business Managers',
  `PublishedOn` date default NULL,
  `Status` varchar(50) default 'Submitted' COMMENT 'Submitted,Validated,Reviewed,Approved,Rejected,SentforModifications',
  `Remarks` text,
  `KTeamRating` double(4,2) default '0.00',
  `ReviewerId` varchar(50) default NULL,
  `ReviewerRating` double(4,2) default '0.00',
  `NoOfHits` int(5) default '0',
  `FileName` varchar(100) default NULL,
  PRIMARY KEY  (`KId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `kbdata` */

insert  into `kbdata`(`KId`,`Title`,`Author`,`DateOfCreation`,`DateOfSubmission`,`Keywords`,`Technology`,`Reference`,`Description`,`ContentType`,`TargetUsers`,`PublishedOn`,`Status`,`Remarks`,`KTeamRating`,`ReviewerId`,`ReviewerRating`,`NoOfHits`,`FileName`) values ('K001','DB connection in java','RajMalhotra','2008-01-01','2008-02-01','java,db,mysql,connection','java','NA','Demonostrates database connectivity using JDBC','Document','Developers','2008-02-02','Published','Good one',5.40,'0',4.00,70,'1.txt'),('K0010','TechHelp','TechHelp','2009-01-28','2009-01-03','mysql,c,java,cpp','TechHelp','TechHelp','TechHelp','K-Document','All',NULL,'Rejected',NULL,5.00,'R06',0.00,0,'2.txt'),('K0011','TempDoc','Ravi','2009-01-05','2009-01-05','java,mysql','J2EE','TempDoc','TempDoc','K-Document','Developers',NULL,'Published',NULL,3.00,'R06',5.00,10,'3.txt'),('K0012','Test','admin','2009-01-11','2009-01-11','Oracle,Database','Oracle','NA','sdfasdf','K-Document','All',NULL,'Published',NULL,0.00,'R03',5.00,8,'1.txt'),('K0013','Testing Basics','admin','2009-02-01','2009-02-07','Testing,basics','Testing','NA','Testing Basics','K-Document','All',NULL,'Rejected',NULL,0.00,'R08',0.00,0,'TestingBasics.txt'),('K0014','Java servlets','admin','2009-02-02','2009-02-07','java,servlets','j2ee','na','about java servlets','ReusableCode','All',NULL,'KTeam',NULL,6.00,NULL,0.00,0,'Agenda.txt'),('K0015','t','saicharangmail.com','2009-10-13','2009-10-13','t','t','t','t','K-Document','All',NULL,'Published',NULL,9.00,'R03',9.00,0,NULL),('K0016','q','qqqqqq','2009-10-13','2009-10-13','qqq','q','q','q','K-Document','All',NULL,'InReview',NULL,4.00,'R08',0.00,0,'Title.JPEG'),('K0017','sai','sai@gmail.com','2009-10-13','2009-10-13','a','a','a','a','K-Document','All',NULL,'Submitted',NULL,0.00,NULL,0.00,0,'Winter.jpg'),('K0018','let us C','yashwanth kanethkar','2009-12-17','2009-12-18','C, C++, java','C','qwerty','In this we lear','K-Document','All',NULL,'InReview',NULL,4.00,'R03',0.00,0,'trainplacement.sql'),('K0019','java 1.7','gosley','2009-01-10','2009-01-10','java','java','sun','about software ','K-Document','All',NULL,'Submitted',NULL,0.00,NULL,0.00,0,'Trainig and Placement Cell_Forms.doc'),('K002','Test Document','Ravi','2008-12-01','2008-12-08','Java,Oracle','Java,Oracle','NA','Ok','K-Document','All',NULL,'Published',NULL,0.00,'R06',6.00,13,'1.txt'),('K003','NA','Srinu','2008-12-28','2008-12-28','c++','NA','NA','NA','K-Document','All',NULL,'Published',NULL,0.00,'R06',7.00,10,'4.txt'),('K004','Sample','Srinivas','2008-12-28','2008-12-28','Sample','Sample','Sample','Sample','K-Document','Developers',NULL,'InReview',NULL,0.00,'R04',0.00,0,'1.txt'),('K005','SampleDoc','SampleDoc','2008-12-01','2008-12-28','SampleDoc','SampleDoc','SampleDoc','SampleDoc','K-Document','All',NULL,'InReview',NULL,0.00,'R03',0.00,0,'1.txt'),('K006','TestUpload','TestUpload','2009-01-31','2009-01-03','java,testing','TestUpload','TestUpload','TestUpload','ReusableCode','All',NULL,'InReview',NULL,0.00,'R03',0.00,0,'5.txt'),('K007','XYZ','admin','2009-01-31','2009-01-03','XYZ','XYZ','XYZ','XYZ','K-Document','All',NULL,'Published',NULL,6.00,NULL,4.00,15,'1.txt'),('K008','Test','admin','2009-01-21','2009-01-03','Test','Test','Test','Test','K-Document','All',NULL,'Published',NULL,2.00,NULL,3.00,12,'1.txt'),('K009','Styles','Styles','2009-01-13','2009-01-03','Styles','Styles','Styles','Styles','K-Document','All',NULL,'Published',NULL,6.00,'R03',8.00,0,'1.txt');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `UserId` varchar(25) default NULL,
  `Password` varchar(25) default NULL,
  `Auth` varchar(10) default 'User'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`UserId`,`Password`,`Auth`) values ('admin','admin','Admin'),('SriCharan','SriCharan','Reviewer'),('Rohan_Singh','Rohan_Singh','KTeam'),('Rahul01','Rahul01','KUser'),('Manohar','Manohar','KUser'),('Raj_Malhotra','Raj_Malhotra','Reviewer'),('Ramu','Ramu','KUser'),('Gopi','Gopi','KUser'),('Srinu','Srinu','KUser'),('AnandRaj01','AnandRaj01','Reviewer'),('mahesh','mahesh','KTeam'),('ramarao','ramarao','Reviewer');

/*Table structure for table `masterdata` */

DROP TABLE IF EXISTS `masterdata`;

CREATE TABLE `masterdata` (
  `SNo` int(11) NOT NULL auto_increment,
  `EmpNo` int(10) default NULL,
  `Name` varchar(100) default NULL,
  `EmailId` varchar(100) default NULL,
  `ProjectCode` varchar(100) default NULL,
  `ClientName` varchar(100) default NULL,
  `ProjectManager` varchar(100) default NULL,
  `StartDate` date default NULL,
  `EndDate` date default NULL,
  `CurrentLocation` varchar(100) default NULL,
  `BaseLocation` varchar(100) default NULL,
  `JoiningDate` date default NULL,
  `Role` varchar(100) default NULL,
  `Designation` varchar(100) default NULL,
  PRIMARY KEY  (`SNo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `masterdata` */

insert  into `masterdata`(`SNo`,`EmpNo`,`Name`,`EmailId`,`ProjectCode`,`ClientName`,`ProjectManager`,`StartDate`,`EndDate`,`CurrentLocation`,`BaseLocation`,`JoiningDate`,`Role`,`Designation`) values (1,555,'admin','admin','ABCDL','ABCD Pvt Ltd','Rohan_Singh','2007-01-01','2008-12-31','Hyderabad','Hyderabad','2006-01-01','SoftwareEngineer','SE'),(2,666,'Rohan_Singh','Rohan_Singh','DDD','DDD','Raj_Malhotra','2006-01-01','2009-01-01','Bangalore','Mumbai','2005-01-01','Analyst','ANALYST'),(3,777,'Rahul','Rahul01','BCH','NA','Rohan_Singh',NULL,NULL,'Mumbai','Mumbai','2008-01-01','SoftwareEngineer','SE'),(4,888,'Manohar','Manohar','BCH','NA','Rohan_Singh',NULL,NULL,'Mumbai','Mumbai','2008-01-01','SoftwareEngineer','SE'),(5,900,'Raju','Raju','ABCDL','ABCD Pvt Ltd','Rohan_Singh','2007-01-01','2008-12-31','Hyderabad','Hyderabad','2006-01-01','SoftwareEngineer','SE'),(6,901,'Ramu','Ramu','DDD','DDD','Raj_Malhotra','2006-01-01','2009-01-01','Bangalore','Mumbai','2005-01-01','Analyst','ANALYST'),(8,903,'Srinu','Srinu','BCH','NA','Rohan_Singh',NULL,NULL,'Mumbai','Mumbai','2008-01-01','SoftwareEngineer','SE'),(9,9,'AnandRaj','AnandRaj01','BCH','NA','NA',NULL,NULL,NULL,'Mumbai','2008-01-01','SeniorManager','SM');

/*Table structure for table `menu_base` */

DROP TABLE IF EXISTS `menu_base`;

CREATE TABLE `menu_base` (
  `MenuId` int(11) NOT NULL,
  `label` varchar(100) default NULL,
  `Description` varchar(255) default NULL,
  PRIMARY KEY  (`MenuId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `menu_base` */

insert  into `menu_base`(`MenuId`,`label`,`Description`) values (0,'None','Represents nothing'),(1,'Home','Tab'),(2,'KUser','Tab'),(3,'KTeam','Tab'),(4,'Reviewer','Tab'),(5,'Reports','Tab'),(6,'Admin ','Tab'),(7,'Search','K-User'),(8,'Submit','K-User'),(9,'FindExperts','K-User'),(10,'RegisterAsExpert','K-User'),(11,'ViewSubmissions','K-Team'),(12,'Evaluate','K-Team'),(13,'AssignReviewer','K-Team'),(14,'ViewReviewers','K-Team'),(15,'AddReviewer','K-Team'),(16,'DeleteReviewer','K-Team'),(17,'ViewSubmissions','Reviewer'),(18,'ReivewSubmissions','Reviewer'),(21,'MySubmissions','Reports'),(22,'MyRatings','Reports'),(23,'MonthlySubmissions','Reports'),(24,'MonthlyRejections','Reports'),(25,'StatusReport','Reports'),(27,'ViewUsers','Admin'),(28,'AddUser','Admin'),(29,'DeleteUser','Admin'),(30,'AddEmployee','Admin'),(31,'ViewEmployees','Admin'),(32,'DeleteEmployee','Admin');

/*Table structure for table `menu_frame_executable_mapping` */

DROP TABLE IF EXISTS `menu_frame_executable_mapping`;

CREATE TABLE `menu_frame_executable_mapping` (
  `Sno` int(11) NOT NULL auto_increment COMMENT 'serial number',
  `MenuRelationshipId` int(11) default NULL COMMENT 'FK to Menu_Base table',
  `TargetFrame` varchar(100) default NULL COMMENT 'Target frame where the corresponding executable will be displayed',
  `Executable` varchar(255) default NULL COMMENT 'This contains the jsp pages that needs to be called on Target frame when this menu is clicked',
  PRIMARY KEY  (`Sno`),
  KEY `FK_menu_frame_executable_mapping` (`MenuRelationshipId`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `menu_frame_executable_mapping` */

insert  into `menu_frame_executable_mapping`(`Sno`,`MenuRelationshipId`,`TargetFrame`,`Executable`) values (1,1,'MainFrame','Body.jsp'),(2,2,'MainFrame','Search.jsp'),(3,3,'MainFrame','ViewSubmissions.jsp?User=KTeam'),(4,4,'MainFrame','ViewSubmissions.jsp?User=Reviewer'),(5,5,'MainFrame','MySubmissions.jsp'),(6,6,'MainFrame','ViewUsers.jsp'),(7,1,'LeftPane','LeftPane.jsp?MenuId=1&Title='),(8,2,'LeftPane','LeftPane.jsp?MenuId=2&Title=K-User'),(9,3,'LeftPane','LeftPane.jsp?MenuId=3&Title=K-Team'),(10,4,'LeftPane','LeftPane.jsp?MenuId=4&Title=Reviewer'),(11,5,'LeftPane','LeftPane.jsp?MenuId=5&Title=Reports'),(12,6,'LeftPane','LeftPane.jsp?MenuId=6&Title=Admin'),(13,7,'MainFrame','Search.jsp'),(14,8,'MainFrame','Submit.jsp'),(15,9,'MainFrame','FindExperts.jsp'),(16,10,'MainFrame','RegisterAsExpert.jsp'),(17,11,'MainFrame','ViewSubmissions.jsp?User=KTeam'),(18,12,'MainFrame','Evaluate.jsp'),(19,13,'MainFrame','AssignReviewer.jsp'),(20,14,'MainFrame','ViewReviewers.jsp'),(21,15,'MainFrame','AddReviewer.jsp'),(22,16,'MainFrame','DeleteReviewer.jsp'),(23,17,'MainFrame','ViewSubmissions.jsp?User=Reviewer'),(24,18,'MainFrame','ReviewSubmissions.jsp?User=Reviewer'),(27,21,'MainFrame','MySubmissions.jsp'),(28,22,'MainFrame','MyRatings.jsp'),(29,23,'MainFrame','MonthlySubmissions.jsp'),(30,24,'MainFrame','MonthlyRejections.jsp'),(31,25,'MainFrame','StatusReport.jsp'),(33,27,'MainFrame','ViewUsers.jsp'),(34,28,'MainFrame','AddUser.jsp'),(35,29,'MainFrame','DeleteUser.jsp'),(36,30,'MainFrame','AddMasterDataEntry.jsp'),(37,31,'MainFrame','ViewMasterData.jsp'),(38,32,'MainFrame','DeleteMasterData.jsp');

/*Table structure for table `menu_role_relationship` */

DROP TABLE IF EXISTS `menu_role_relationship`;

CREATE TABLE `menu_role_relationship` (
  `MenuRelationshipId` int(11) NOT NULL,
  `Role` varchar(20) NOT NULL,
  `Description` varchar(255) default NULL,
  PRIMARY KEY  (`MenuRelationshipId`,`Role`),
  KEY `FK_menu_role_relationship` (`Role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `menu_role_relationship` */

insert  into `menu_role_relationship`(`MenuRelationshipId`,`Role`,`Description`) values (0,'Admin','Represents nothing'),(1,'Admin','Tab'),(1,'KTeam','Tab'),(1,'KUser','Tab'),(1,'Reviewer','Tab'),(2,'Admin','Tab'),(2,'KTeam','Tab'),(2,'KUser','Tab'),(2,'Reviewer','Tab'),(3,'KTeam','Tab'),(4,'Reviewer','Tab'),(5,'Admin','Tab'),(5,'KTeam','Tab'),(5,'KUser','Tab'),(5,'Reviewer','Tab'),(6,'Admin','Tab'),(7,'Admin','KUser'),(7,'KTeam','KUser'),(7,'KUser','K-User'),(7,'Reviewer','KUser'),(8,'Admin','KUser'),(8,'KTeam','KUser'),(8,'KUser','K-User'),(8,'Reviewer','KUser'),(9,'Admin','KUser'),(9,'KTeam','KUser'),(9,'KUser','K-User'),(9,'Reviewer','KUser'),(10,'Admin','KUser'),(10,'KTeam','KUser'),(10,'KUser','K-User'),(10,'Reviewer','KUser'),(11,'KTeam','K-Team'),(12,'KTeam','K-Team'),(13,'KTeam','K-Team'),(14,'KTeam','K-Team'),(15,'KTeam','K-Team'),(16,'KTeam','K-Team'),(17,'Reviewer','Reviewer'),(18,'Reviewer','Reviewer'),(21,'Admin','Reports'),(22,'Admin','Reports'),(23,'Admin','Reports'),(23,'KTeam','Reports'),(23,'KUser','Reports'),(23,'Reviewer','Reports'),(24,'Admin','Reports'),(24,'KTeam','Reports'),(24,'KUser','Reports'),(24,'Reviewer','Reports'),(25,'Admin','Reports'),(27,'Admin','Admin'),(28,'Admin','Admin'),(29,'Admin','Admin'),(30,'Admin','Admin'),(31,'Admin','Admin'),(32,'Admin','Admin');

/*Table structure for table `menuitem_relationship` */

DROP TABLE IF EXISTS `menuitem_relationship`;

CREATE TABLE `menuitem_relationship` (
  `MenuRelationshipId` int(11) NOT NULL auto_increment,
  `ParentMenuId` int(11) default NULL,
  `childMenuId` int(11) default NULL,
  `RelationshipDescription` varchar(255) default NULL,
  `MenuLevel` int(11) default '0',
  PRIMARY KEY  (`MenuRelationshipId`),
  KEY `FK_menuitem_relationship` (`ParentMenuId`),
  KEY `FK_menuitem_relationship1` (`childMenuId`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `menuitem_relationship` */

insert  into `menuitem_relationship`(`MenuRelationshipId`,`ParentMenuId`,`childMenuId`,`RelationshipDescription`,`MenuLevel`) values (1,0,1,'Home',0),(2,0,2,'KUser',0),(3,0,3,'KTeam',0),(4,0,4,'Reviewer',0),(5,0,5,'Reports',0),(6,0,6,'Admin',0),(7,2,7,NULL,0),(8,2,8,NULL,0),(9,2,9,NULL,0),(10,2,10,NULL,0),(11,3,11,NULL,0),(12,3,12,NULL,0),(13,3,13,NULL,0),(14,3,14,NULL,0),(15,3,15,NULL,0),(16,3,16,NULL,0),(17,4,17,NULL,0),(18,4,18,NULL,0),(21,5,21,NULL,0),(22,5,22,NULL,0),(23,5,23,NULL,0),(24,5,24,NULL,0),(25,5,25,NULL,0),(27,6,27,NULL,0),(28,6,28,NULL,0),(29,6,29,NULL,0),(30,6,30,NULL,0),(31,6,31,NULL,0),(32,6,32,NULL,0);

/*Table structure for table `reviewerdetails` */

DROP TABLE IF EXISTS `reviewerdetails`;

CREATE TABLE `reviewerdetails` (
  `ReviewerId` varchar(50) NOT NULL,
  `Name` varchar(100) default NULL,
  `EmailId` varchar(100) default NULL,
  `Skillset` varchar(255) default NULL,
  `Experience` int(3) default NULL,
  PRIMARY KEY  (`ReviewerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reviewerdetails` */

insert  into `reviewerdetails`(`ReviewerId`,`Name`,`EmailId`,`Skillset`,`Experience`) values ('R03','Raj Malhotra','Raj_Malhotra','Oracle 10g',48),('R05','Srivalli','S_Srivalli','MS SQL Server Administration',36),('R06','AnandRaj01','AnandRaj01','All',60),('R07','Raj_Malhotra','RAJ@GMAIL.COM','C',34),('R08','ramarao','ramarao@gmail.com','c,c++,java',15);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

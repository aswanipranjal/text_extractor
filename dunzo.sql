-- --------------------------------------------------------
-- Host:                         139.59.22.238
-- Server version:               5.7.27 - MySQL Community Server (GPL)
-- Server OS:                    Linux
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table dunzodb.item
DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `ItemCode` varchar(100) NOT NULL,
  `Description` tinytext,
  `LastModifiedOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ItemCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='MASTERDATA';

-- Dumping data for table dunzodb.item: ~0 rows (approximately)
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;

-- Dumping structure for table dunzodb.store
DROP TABLE IF EXISTS `store`;
CREATE TABLE IF NOT EXISTS `store` (
  `StoreID` varchar(50) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Address` mediumtext,
  `VATID` varchar(45) DEFAULT NULL,
  `Phone` varchar(45) DEFAULT '',
  `Fax` varchar(45) DEFAULT '',
  `EMail` varchar(100) DEFAULT NULL,
  `HomePage` varchar(100) DEFAULT NULL,
  `City` varchar(45) DEFAULT '',
  `PostCode` varchar(10) DEFAULT NULL,
  `CountryCode` varchar(45) DEFAULT 'IND',
  `LastModifiedOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`StoreID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='MASTERDATA';

-- Dumping data for table dunzodb.store: ~7 rows (approximately)
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` (`StoreID`, `Name`, `Address`, `VATID`, `Phone`, `Fax`, `EMail`, `HomePage`, `City`, `PostCode`, `CountryCode`, `LastModifiedOn`) VALUES
	('001', 'RHBUS Co., Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('002', 'Pranjal Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('003', 'Abhijeet Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('004', 'Ganesh Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('005', 'Dunzo Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('006', 'MilkMade Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('007', 'Unacademy Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 15:47:10'),
	('008', 'Bloom Private. Ltd', '238 Soi Ladprao 1', '1234567890123', '(66)2-513-7337', '(66)2-513-7338', NULL, 'http://www.venturetec.co.th', 'Bangkok', '10900', 'IND', '2019-08-03 17:24:37');
/*!40000 ALTER TABLE `store` ENABLE KEYS */;

-- Dumping structure for table dunzodb.store_attributes
DROP TABLE IF EXISTS `store_attributes`;
CREATE TABLE IF NOT EXISTS `store_attributes` (
  `StoreID` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `AttributeKey` varchar(100) DEFAULT NULL,
  `AttributeValue` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `LastModifiedOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`StoreID`) USING BTREE,
  CONSTRAINT `FK_store_attributes_store` FOREIGN KEY (`StoreID`) REFERENCES `store` (`StoreID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='MASTERDATA';

-- Dumping data for table dunzodb.store_attributes: ~0 rows (approximately)
/*!40000 ALTER TABLE `store_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_attributes` ENABLE KEYS */;

-- Dumping structure for table dunzodb.transactionlines
DROP TABLE IF EXISTS `transactionlines`;
CREATE TABLE IF NOT EXISTS `transactionlines` (
  `EntryType` varchar(20) DEFAULT 'ITEMFROMBILL',
  `LineNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ReceiptNo` varchar(20) NOT NULL,
  `ItemCode` varchar(20) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `UnitofMeasure` varchar(20) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `StoreName` varchar(100) DEFAULT NULL,
  `Price` decimal(20,5) DEFAULT '0.00000',
  `Quantity` decimal(20,5) DEFAULT '0.00000',
  `DiscountAmount` decimal(20,5) DEFAULT '0.00000',
  `NetAmount` decimal(20,5) DEFAULT '0.00000',
  `VATAmount` decimal(20,5) DEFAULT '0.00000',
  `Amount` decimal(20,5) DEFAULT '0.00000',
  `TotalDiscAmount` decimal(10,5) DEFAULT '0.00000',
  `TransDate` date DEFAULT NULL,
  `TransTime` time DEFAULT NULL,
  `imageURL` mediumtext,
  `LastModifiedOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LineNo`,`ReceiptNo`),
  KEY `Index_2` (`ReceiptNo`,`EntryType`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table dunzodb.transactionlines: ~1 rows (approximately)
/*!40000 ALTER TABLE `transactionlines` DISABLE KEYS */;
INSERT INTO `transactionlines` (`EntryType`, `LineNo`, `ReceiptNo`, `ItemCode`, `Description`, `UnitofMeasure`, `StoreID`, `StoreName`, `Price`, `Quantity`, `DiscountAmount`, `NetAmount`, `VATAmount`, `Amount`, `TotalDiscAmount`, `TransDate`, `TransTime`, `imageURL`, `LastModifiedOn`) VALUES
	('ITEMFROMBILL', 1, 'TEST', '001-01', 'Wheat', 'KG', '001', NULL, 10.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, NULL, NULL, NULL, '2019-08-03 20:39:41');
/*!40000 ALTER TABLE `transactionlines` ENABLE KEYS */;

-- Dumping structure for table dunzodb.wmsentry
DROP TABLE IF EXISTS `wmsentry`;
CREATE TABLE IF NOT EXISTS `wmsentry` (
  `EntryNo` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DocumentNo` varchar(100) NOT NULL,
  `DocumentDate` date DEFAULT NULL,
  `EntryType` varchar(45) DEFAULT 'ITEMFROMBILL',
  `ItemCode` varchar(100) DEFAULT NULL,
  `Quantity` decimal(20,5) DEFAULT '0.00000',
  `BaseUOM` varchar(20) DEFAULT NULL,
  `LastModifiedOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EntryNo`,`DocumentNo`),
  KEY `Index_3` (`ItemCode`),
  KEY `Index_4` (`ItemCode`),
  KEY `FK_wmsentry_unitofmeasure` (`BaseUOM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table dunzodb.wmsentry: ~0 rows (approximately)
/*!40000 ALTER TABLE `wmsentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `wmsentry` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

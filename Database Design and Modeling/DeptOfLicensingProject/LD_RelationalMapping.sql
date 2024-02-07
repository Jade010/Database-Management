-- This code is a translation of the ER Diagram to a Relational model

CREATE DATABASE LicensingDepartment;

CREATE TABLE Company (
	companyName VARCHAR(50) PRIMARY KEY,
	phone_num VARCHAR(15),
	driverSSN CHAR(9)
);

CREATE TABLE Driver (
	SSN CHAR(9) PRIMARY KEY,
	firstName VARCHAR(20),
	lastName VARCHAR(20),
	address VARCHAR(100),
	age INTEGER CHECK (age > 0 AND age < 120),
	license_num CHAR(10) UNIQUE,
	FOREIGN KEY (license_num) REFERENCES License(license_num)
);

CREATE TABLE Recorded (
	SSN CHAR(9),
	companyName VARCHAR(50),
	PRIMARY KEY (SSN,companyName),
	FOREIGN KEY (SSN) REFERENCES Driver(SSN),
	FOREIGN KEY (companyName) REFERENCES Company(companyName)
);

CREATE TABLE LicensingOffice (
	officeName VARCHAR(50) PRIMARY KEY,
	city VARCHAR(20)
);

CREATE TABLE LicensingOfficer(
	officer_SSN CHAR(9) PRIMARY KEY,
	firstName VARCHAR(20),
	lastName VARCHAR(20),
	off_address VARCHAR(100),
	yrsExperience INTEGER CHECK (yrsExperience >= 0)
);

CREATE TABLE Works_for (
	officer_SSN CHAR(9),
	officeName VARCHAR(50),
	PRIMARY KEY (officer_SSN,officeName),
	FOREIGN KEY (officer_SSN) REFERENCES LicensingOfficer(officer_SSN),
	FOREIGN KEY (officeName) REFERENCES LicensingOffice(officeName)
);

CREATE TABLE License (
	license_num CHAR(10) PRIMARY KEY,
	issueDate DATE,
	expiryDate DATE
);

CREATE TABLE Issues_a (
	officer_SSN CHAR(9),
	license_num CHAR(10),
	PRIMARY KEY (license_num,officer_SSN),
	FOREIGN KEY (license_num) REFERENCES License(license_num),
	FOREIGN KEY (officer_SSN) REFERENCES LicensingOfficer(officer_SSN)
);

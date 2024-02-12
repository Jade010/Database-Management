-- The relational model was created in MySQL
CREATE DATABASE JadesBootcamps;

-- Superclass entity
CREATE TABLE Users (
	UserID INT PRIMARY KEY,
	Username VARCHAR(50) UNIQUE NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(200) UNIQUE NOT NULL
);

-- Subclass entity
CREATE TABLE Instructor (
	UserID INT PRIMARY KEY,
	yearsExp INT,
	Role VARCHAR(50),
	FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Entity
CREATE TABLE Courses (
	CourseID INT PRIMARY KEY,
	Title VARCHAR(50) NOT NULL,
	Description TEXT NOT NULL,
	lastUpdated DATE
);

-- Entity relationship between Courses and Instructors
CREATE TABLE InstructorCourse (
	UserID INT,
	CourseID INT,
	PRIMARY KEY (UserID,CourseID),
	FOREIGN KEY (UserID) REFERENCES Instructor(UserID),
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
	
-- Weak entity dependent on course
CREATE TABLE Modules (
	ModuleID INT,
	CourseID INT,
	Title VARCHAR(50) NOT NULL,
	VideoURL VARCHAR(100),
	Description TEXT,
	PRIMARY KEY (ModuleID,CourseID),
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Subclass entity
CREATE TABLE Student (
	UserID INT PRIMARY KEY,
	FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Relationship between students and enrollment
CREATE TABLE Enrollment (
	UserID INT,
	CourseID INT,
	Enroll_Date DATE,
	PRIMARY KEY (UserID,CourseID),
	FOREIGN KEY (UserID) REFERENCES Student(UserID),
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Entity
CREATE TABLE Subscriptions (
	SubscriptionID INT PRIMARY KEY,
	UserID INT,
	StartDate DATE,
	EndDate DATE,
	MonthlyFee DECIMAL(10,2),
	FOREIGN KEY (UserID) REFERENCES Student(UserID)
);

-- Entity
CREATE TABLE Exam (
	ExamID INT PRIMARY KEY,
	Exam_Name VARCHAR(100) NOT NULL,
	price DECIMAL(10,2) NOT NULL
);

-- Entity
CREATE TABLE Certificates (
	CertificateID VARCHAR(20) PRIMARY KEY,
	ExamID INT,
	Cert_Name VARCHAR(50),
	issue_Date DATE,
	expiration_Date DATE,
	FOREIGN KEY (ExamID) REFERENCES Exam(ExamID)
);

-- Weak entity dependent on both Exam and Student
CREATE TABLE ExamResults (
	UserID INT,
	ExamID INT,
	Score DECIMAL(4,2),
	PassFail ENUM('Pass','Fail'),
	PRIMARY KEY (UserID,ExamID),
	FOREIGN KEY (UserID) REFERENCES Student(UserID),
	FOREIGN KEY (ExamID) REFERENCES Exam(ExamID)
);

-- Relationship entity between students and awarded certificates
CREATE TABLE AwardedCertificates (
	CertAwardID INT,
	UserID INT,
	CertificateID VARCHAR(20),
	DateAwarded DATE,
	PRIMARY KEY (CertAwardID,UserID,ExamID,CertificateID),
	FOREIGN KEY (UserID) REFERENCES Student(UserID),
	FOREIGN KEY (CertificateID) REFERENCES Certificate(CertificateID)
);

-- Trigger
DELIMITER $$
CREATE TRIGGER AwardCertificate_AFTER_INSERT
AFTER INSERT ON ExamResults
FOR EACH ROW
BEGIN
    IF NEW.PassFail = 'Pass' THEN
        INSERT INTO AwardedCertificates (UserID, CertificateID, DateAwarded)
        SELECT NEW.UserID, Certificates.CertificateID, CURDATE()
        FROM Certificates
        WHERE Certificates.ExamID = NEW.ExamID
        AND NOT EXISTS (
            SELECT 1 FROM AwardedCertificates
            WHERE UserID = NEW.UserID AND CertificateID = Certificates.CertificateID
        );
    END IF;
END$$
DELIMITER ;

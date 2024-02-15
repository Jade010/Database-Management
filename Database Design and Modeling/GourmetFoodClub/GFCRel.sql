-- Creating the database
CREATE DATABASE GourmetFoodClub;

-- Creating tables for the database
CREATE TABLE CUSTOMER (
  custID INT PRIMARY KEY,
  cust_fname CHAR(25) NOT NULL,
  cust_lname CHAR(25) NOT NULL,
  cust_phone CHAR(25) NOT NULL,
  cust_email CHAR(25) NOT NULL,
  cust_street CHAR(25) NOT NULL,
  cust_city CHAR(25) NOT NULL,
  cust_state CHAR(2) NOT NULL,
  cust_zip CHAR(5) NOT NULL
);

CREATE TABLE PARTY (
  partyID INT NOT NULL,
  hostID INT NOT NULL,
  party_date DATE NOT NULL,
  party_time TIME NOT NULL,
  CONSTRAINT pk_party PRIMARY KEY (partyID, hostID),
  CONSTRAINT fk_customer_party FOREIGN KEY (hostID) REFERENCES HOST (hostID)
);

CREATE TABLE HOST (
  hostID INT NOT NULL PRIMARY KEY,
  partyID INT NOT NULL,
  custID INT NOT NULL,
  CONSTRAINT fk_party_host FOREIGN KEY (partyID) REFERENCES PARTY (partyID),
  CONSTRAINT fk_customer_host FOREIGN KEY (custID) REFERENCES CUSTOMER (custID)
);


-- Inserting data into the tables
INSERT INTO customer VALUES (1, 'Janice', 'Brown', '503-3031', 'JBrown@yahoo.com', 'Farfield ave', 'Puyallup',
'WA', '98400');
INSERT INTO customer VALUES (2, 'Zach', 'Foster', '991-4309', 'Zfoster@yahoo.com', 'Cougar ave', 'Pullman',
'WA', '98499');
INSERT INTO customer VALUES (3, 'Carla', 'Micthell', '455-2678', 'CarlaM@yahoo.com', 'Ocean SW', 'Seattle',
'WA', '98408');

INSERT INTO party VALUES (00, 100, '09/06/2020', '06:30');
INSERT INTO party VALUES (01, , '12/14/2021', '10:30');
INSERT INTO party VALUES (02, , '01/01/2022', '12:00');

INSERT INTO host VALUES (100, 00, 2);
INSERT INTO host VALUES (200, 02, 3);
INSERT INTO host VALUES (300, 01, 1);

-- Question 1
CREATE TABLE AIRCRAFT (
  callsign CHAR(10) PRIMARY KEY,
  manufacturer CHAR(20) NOT NULL,
  model_no INT NOT NULL,
  payload INT NOT NULL,
  manufacturer_year CHAR(4) NOT NULL,
  aircraft_class CHAR(8) NOT NULL
);

INSERT INTO aircraft VALUES ('M922E', 'Airbus', 252, 10000, '2000', 'Civilian');
INSERT INTO aircraft VALUES ('N323B', 'Boeing', 373, 30000, '2003', 'Civilian');
INSERT INTO aircraft VALUES ('O123D', 'Lockheed Martin', 544, 9000, '2016', 'Military');

-- Question 2
CREATE TABLE RESTAURANT (
  restID INT PRIMARY KEY,
  rest_name CHAR(20) NOT NULL,
  rest_street CHAR(40) NOT NULL,
  rest_city CHAR(10) NOT NULL,
  rest_state CHAR(2) NOT NULL,
  rest_zip CHAR(5) NOT NULL,
  rest_capacity INT NOT NULL,
  rest_phoneno CHAR(10) NOT NULL,
  rest_foodtype CHAR(20) NOT NULL
);

INSERT INTO restaurant VALUES (1, 'Blazing Onion', '13195 Newcastle Commons Dr', 'Newcastle', 'WA', '98059', 100, '4255720304', 'American');
INSERT INTO restaurant VALUES (2, 'Cheesecake Factory', '230 Strander Blvd', 'Tukwila', 'WA', '98188', 150, '2062467300', 'American');
INSERT INTO restaurant VALUES (3, 'Dukes Seafood', '1111 Fairview Ave N', 'Seattle', 'WA', '98109', 80, '2063829963', 'Seafood');

-- Question 3
CREATE TABLE FARMER (
farmerID INT NOT NULL PRIMARY KEY,
farmer_fname CHAR(20) NOT NULL,
farmer_lname CHAR(20) NOT NULL,
farmer_street CHAR(40) NOT NULL,
farmer_city CHAR(20) NOT NULL,
farmer_state CHAR(2) NOT NULL,
farmer_zip CHAR(5) NOT NULL);

CREATE TABLE COW (
cowID INT NOT NULL PRIMARY KEY,
cow_name CHAR(20) NOT NULL,
cow_breed CHAR(20) NOT NULL,
cow_dob DATE NOT NULL,
farmerID INT NOT NULL,
CONSTRAINT fk_farmer_cow FOREIGN KEY (farmerID) REFERENCES FARMER (farmerID));

INSERT INTO farmer (farmerID, farmer_fname, farmer_lname, farmer_street, farmer_city, farmer_state, farmer_zip)
VALUE (1, 'Jane', 'Doe', '123 made up NE', 'Pullman', 'WA', '99163');
INSERT INTO farmer (farmerID, farmer_fname, farmer_lname, farmer_street, farmer_city, farmer_state, farmer_zip)
VALUE (2, 'John', 'Doe', '1111 mystery W', 'Spokane', 'WA', '99173');
INSERT INTO farmer (farmerID, farmer_fname, farmer_lname, farmer_street, farmer_city, farmer_state, farmer_zip)
VALUE (3, 'Adam', 'Doe', '1 country DR', 'Tacoma', 'WA', '98405');
INSERT INTO cow (cowID, cow_name, cow_breed, cow_dob, farmerID)
VALUE (1, 'Bessy', 'Angus', '05/04/2000', 3);
INSERT INTO cow (cowID, cow_name, cow_breed, cow_dob, farmerID)
VALUE (2, 'Bertha', 'Holstein', '08/12/2001', 1);
INSERT INTO cow (cowID, cow_name, cow_breed, cow_dob, farmerID)
VALUE (3, 'Lu', 'Highland', '11/09/2003', 2);


-- Question 4

CREATE TABLE AIRCRAFT (
aircraftID INT NOT NULL PRIMARY KEY,
make CHAR(20) NOT NULL,
model CHAR(20) NOT NULL,
year CHAR(4) NOT NULL,


CREATE TABLE FLIGHT (
flightID INT NOT NULL PRIMARY KEY,
origin CHAR(5) NOT NULL,
destination CHAR(5) NOT NULL,
dep_date DATE NOT NULL,
dep_time TIME NOT NULL,
arr_time TIME NOT NULL,
aircraftID INT NOT NULL,
CONSTRAINT fk_aircraft_flight FOREIGN KEY (aircraftID) REFERENCES AIRCRAFT (aircraftID));

CREATE TABLE PASSENGER (
passengerID INT NOT NULL PRIMARY KEY,
pass_lname CHAR(20) NOT NULL,
pass_fname CHAR(20) NOT NULL,
pass_street CHAR(40) NOT NULL,
pass_city CHAR(20) NOT NULL,
pass_state CHAR(2) NOT NULL,
pass_zip CHAR(5) NOT NULL,
pass_seatno CHAR(5) NOT NULL,
pass_class CHAR(10) NOT NULL,
flightID INT NOT NULL,
CONSTRAINT fk_flight_passenger FOREIGN KEY (flightID) REFERENCES FLIGHT (flightID));

INSERT INTO aircraft (aircraftID, make, model) VALUE (111, 'Boeing', '737');
INSERT INTO aircraft (aircraftID, make, model) VALUE (122, 'Airbus', '303');
INSERT INTO aircraft (aircraftID, make, model) VALUE (133, 'Lockheed Martin', '156');


INSERT INTO flight (flightID, origin, destination, dep_date, dep_time, arr_time, aircraftID)
VALUE (211, 'SEA', 'GEG', '01-01-2023', '08:00' , '09:10', 133);
INSERT INTO flight (flightID, origin, destination, dep_date, dep_time, arr_time, aircraftID)
VALUE (222, 'GEG', 'SEA', '05-04-2023', '06:15', '07:30', 111);
INSERT INTO flight (flightID, origin, destination, dep_date, dep_time, arr_time, aircraftID)
VALUE (233, 'SEA', 'GEG', '12-17-2023', '07:00', '08:00', 122);

INSERT INTO passenger (passengerID, pass_lname, pass_fname, pass_street, pass_city, pass_state, pass_zip, pass_seatno, pass_class, flightID)
VALUE (311, 'Johnson', 'Anna', '123 random NE', 'Spokane', 'WA', '99158', '16', 'D', 'Coach', 222);
INSERT INTO passenger (passengerID, pass_lname, pass_fname, pass_street, pass_city, pass_state, pass_zip, pass_seatno, pass_class, flightID)
VALUE (322, 'Powell', 'Steve', '544 union ave', 'Tacoma', 'WA', '98405', '2', 'A', 'First', 233);
INSERT INTO passenger (passengerID, pass_lname, pass_fname, pass_street, pass_city, pass_state, pass_zip, pass_seatno, pass_class, flightID)
VALUE (333, 'Carson', 'Mary', '1515 wheatland DR', 'Pullman', 'WA', '99163', '7', 'B', 'Business', 211);


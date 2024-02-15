-- Creating Database
CREATE DATABASE Freight;

-- Creating Tables
CREATE TABLE CUSTOMERS ( 
  customerID INT PRIMARY KEY, 
  custName CHAR(25) NOT NULL, 
  cust_email VARCHAR(30) NOT NULL, 
  cust_street VARCHAR(25) NOT NULL, 
  cust_city CHAR(20) NOT NULL, 
  cust_state CHAR(2) NOT NULL, 
  cust_zip CHAR(5) NOT NULL
); 
 
CREATE TABLE FREIGHT ( 
  ship_type INT PRIMARY KEY, 
  min_amount DECIMAL(5,2) NOT NULL, 
  max_amount DECIMAL(5,2) NOT NULL, 
  regular_delivery DECIMAL(4,2), 
  rush_delivery DECIMAL(4,2), 
  express_delivery DECIMAL(4,2)
); 
 
CREATE TABLE ORDERS ( 
  orderID INT PRIMARY KEY, 
  ship_type INT NOT NULL, 
  customerID INT NOT NULL, 
  order_date DATE NOT NULL, 
  CONSTRAINT fk_freight_orders FOREIGN KEY (ship_type) REFERENCES FREIGHT (ship_type), 
  CONSTRAINT fk_customers_orders FOREIGN KEY (customerID) REFERENCES CUSTOMERS (customerID)
); 

-- Populating Tables
INSERT INTO CUSTOMERS VALUES(0, 'Zoe Cafe', 'zoe_business@gmail.com', '123 NE', 'Pullman', 'WA', '99133'); 
INSERT INTO CUSTOMERS VALUES(1, 'Company Corp', 'company_business@gmail.com', 'Made Up', 'Tacoma', 'WA', '99163'); 
INSERT INTO CUSTOMERS VALUES(2, 'Example College', 'Example@college.edu', 'Sample', 'Seattle', 'WA', '98403'); 
 
 
INSERT INTO FREIGHT VALUES(0, 0, 15.00, 4.95, 9.95, 17.45); 
INSERT INTO FREIGHT VALUES(1, 15.01, 30.00, 5.95, 10.95, 18.45); 
INSERT INTO FREIGHT VALUES(2, 30.01, 45.00, 7.95, 12.95, 20.45); 

INSERT INTO FREIGHT VALUES(3, 45.01, 65.00, 9.95, 14.95, 22.45); 
INSERT INTO FREIGHT VALUES(4, 65.01, 90.00, 11.95, 16.95, 24.45); 
INSERT INTO FREIGHT VALUES(5, 90.01, 125.00, 13.95, 18.95, 26.45); 
INSERT INTO FREIGHT VALUES(6, 125.01, 200.00, 14.95, 19.95, 27.45); 
INSERT INTO FREIGHT VALUES(7,200.01, 999.99, 16.95, 21.95, 29.45); 
 
INSERT INTO ORDERS VALUES(0, 6, 0, '01-22-2022'); 
INSERT INTO ORDERS VALUES(1, 4, 1, '04-11-2022'); 
INSERT INTO ORDERS VALUES(2, 4, 2, '10-03-2022'); 
INSERT INTO ORDERS VALUES(3, 2, 0, '12-13-2022'); 


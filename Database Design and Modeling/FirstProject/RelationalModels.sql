-- Question 1

CREATE TABLE EMPLOYEE (
  employeeID INTEGER PRIMARY KEY,
  emp_fname CHAR(25) NOT NULL,
  emp_lname CHAR(25) NOT NULL,
  emp_dept CHAR(35) NOT NULL,
  emp_phone CHAR(12) NOT NULL,
  emp_email CHAR(100) NOT NULL
);

INSERT INTO EMPLOYEE VALUES(111, 'Allen', 'Smith', 'Marketing', '2534745092', 'Allen.smith@yahoo.com');
INSERT INTO EMPLOYEE VALUES(231, 'Jennifer', 'Johnson', 'Finance', '2535708092', 'J.johnson@yahoo.com');
INSERT INTO EMPLOYEE VALUES(125, 'Michael', 'Carson', 'Accounting', '254235128', 'Michaelc@yahoo.com');

-- Question 2
CREATE TABLE DOG (
  dogID INTEGER PRIMARY KEY,
  dog_name VARCHAR(35) NOT NULL,
  dog_breed VARCHAR(100) NOT NULL,
  dog_DOB DATE NOT NULL,
  dog_owner VARCHAR(100) NOT NULL
);

INSERT INTO DOG VALUES(1, 'Susie', 'Golden Retriever', '06/07/2008', 'Chelsea');
INSERT INTO DOG VALUES (2, 'Coco', 'Husky', '12/02/2010', 'Alex');
INSERT INTO DOG VALUES (3, 'Nina', 'Shiba Inu', '02/21/2020', 'Lauren');

-- Quesion 3
CREATE TABLE DEPARTMENT (
  dept_name CHAR(40) NOT NULL PRIMARY KEY,
  budget_code CHAR(30) NOT NULL,
  officeno CHAR(15) NOT NULL,
  dept_phone CHAR(12) NOT NULL
);

CREATE TABLE PROJECT (
  projectID INTEGER PRIMARY KEY,
  project_name VARCHAR(50) NOT NULL,
  max_hours INTEGER NOT NULL,
  strt_date DATE NOT NULL,
  end_date DATE NOT NULL,
  dept_name CHAR(40) NOT NULL,
  CONSTRAINT fk_department_project FOREIGN KEY (dept_name) REFERENCES DEPARTMENT (dept_name)
); 


INSERT INTO DEPARTMENT VALUES ('Marketing', '01012', '3', '3084559999');
INSERT INTO DEPARTMENT VALUES ('Clothing', '93034', '9', '2535088089');
INSERT INTO DEPARTMENT VALUES ('Book', '40800', '1', '5033075040');

INSERT INTO PROJECT VALUES (111, 'Project 1', '05:00:00', '06-01-2022', '08-01-2022', 'Book');
INSERT INTO PROJECT VALUES (222, 'Project 2', '08:30:00', '09-05-2023', '12-09-2023', 'Marketing');
INSERT INTO PROJECT VALUES (333, 'Project 3', '02:30:00', '11-09-2022', '01-15-2023', 'Clothing');

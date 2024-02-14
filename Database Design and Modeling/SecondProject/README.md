# Data Management Assignment 2
This is another assignment I worked on at Washington State University where I used SQL and created data models using visio. The goal of this assignment was to become familiar with single entities and one-to-many entities as well as getting a basic understanding of database management.
  
## Instructions:  

The goal of this assignment was to draw data models using visio, turn this into a relational database, and then add 3 rows to the tables based on the following information.  

1. **Aircraft:** An aircraft has a manufacturer, model number, call sign (e.g., N123D), payload, and a year of construction. Aircraft are classified as civilian or military.
2. **Restaurant:** A restaurant has a name, address, seating capacity, phone number, and style of food (e.g., French, Russian, Chinese).
3.	A farmer can have many cows, but a cow belongs to only one farmer.  For each cow the farmer keeps track of the cow’s name, breed, and date of birth.  For each farmer we need to track the farmer’s first name, last name, street address, city, state, and zip code.
4.	An aircraft can take many flights, but each flight is on only one aircraft.  A flight can have many passengers, but a passenger can be on only one flight at a time.  For each aircraft we want to track the make, model, and year manufactured.  For each flight we want to track the origin, destination, date, departure time, and arrival time.  For each passenger we want to track the passenger’s last name, first name, street address, city, state, zip code, seat number, and class (e.g. first, business, or coach). 


## File Structure and Contents
1. [DataModel.pdf](https://github.com/Jade010/SQL/blob/main/Database%20Design%20and%20Modeling/FirstProject/DataModel.pdf)
    - Contains the Entity-Relationship (ER) diagram created in Visio based on the instructions above. This diagram details all relevant entities, their attributes, and constraints.
3. [RelationalModels.sql](https://github.com/Jade010/SQL/blob/main/Database%20Design%20and%20Modeling/FirstProject/RelationalModels.sql)
    - Translates the Entity-Relationship (ER) diagram into a relational model and includes SQL scripts for creating the database. This also includes the code used to insert 3 rows into each example.

## Skills
- Data modeling
- Visio
- SSMS
- Relational Models
- CREATE TABLE () and INSERT INTO () functions
- Constraints

## Scenario
The department of drivers’ licensing has asked you to design its database. Here is the information gathered:

1. Drivers are identified by their SSN. For each driver, the name, address, and age must be recorded. 
2. Licensing officers are identified by their SSN. For each licensing officer, the name, address, and years of experience must be recorded. 
3. Each licensing office is identified by its name and the city it is in. An office’s name can be assumed to be unique within the city.  
4. Licensing officers work for the licensing office. Each office should be associated with at least one officer.  
5. Every driver has one licensing officer. Every licensing officer has at least one license that they are responsible for issuing. 
6. A company is identified by name and has a phone number. For each company, a corresponding driver must be recorded. If a company is deleted, you need not keep track of its corresponding driver. 
7. Licensing offices issue driver licenses to the public. Each case is handled by a licensing officer. A licensing officer can handle multiple licensing cases. 
8. Each license has a license number, an issued date, and an expiry date associated with it. Each license is given to a driver in a certain licensing office. The license number is unique within the entire department. The uniqueness of the license number must be respected by all offices.

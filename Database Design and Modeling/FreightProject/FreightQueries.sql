-- Q1. How many orders are there for each shipping type in the ORDERS table?
SELECT count(orderID) as orders, ship_type 
FROM ORDERS 
GROUP BY ship_type; 

-- Q2. How many orders has each customer placed?
SELECT CUSTOMERS.custName, count(ORDERS.orderID) as orders 
FROM ORDERS JOIN CUSTOMERS 
ON CUSTOMERS.customerID = ORDERS.customerID 
GROUP BY Customers.custName; 
 
-- Q3. What are the details of all freight records where the minimum amount is between $15.00 and $90.00?
SELECT * 
FROM FREIGHT 
WHERE min_amount between 15.00 AND 90.00; 

-- Q4. Which orders have a total minimum freight charge of more than $50.00, based on their shipping type?
SELECT orderID, sum(FREIGHT.min_amount) 
FROM ORDERS, FREIGHT 
WHERE ORDERS.ship_type = FREIGHT.ship_type 
GROUP BY orderID 
HAVING sum(FREIGHT.min_amount)> 50.00; 

-- Q5. What are the regular, rush, and express delivery options available, sorted by the highest to lowest express delivery times?
SELECT regular_delivery, rush_delivery, express_delivery 
FROM FREIGHT 
ORDER BY express_delivery desc; 


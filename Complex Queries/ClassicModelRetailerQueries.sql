-- This repository contains a set of queries performed on the ClassicModel Database. 
-- The queries showcase my skills in SQL for performing data extraction, aggregation, and business analysis. 
-- The ClassicModel is a retailer of scale models of classic cars database. It's a richly structured dataset which serves well for the demonstration of SQL queries.

USE ClassicModel;

-- Q1. Prepare a list of offices sorted by country, state, and city.
SELECT Country, state, city
FROM Offices

-- Q2. How many employees are there in the comapny?
SELECT count(*)
FROM Employees

-- Q3. What is the total of payments received?
SELECT sum(amount)
FROM Payments

-- Q4. List the product lines that contain 'Cars'.
SELECT productLine
FROM ProductLines
WHERE productLine like '%Cars%'

-- Q5. Report total payments for October 28, 2004.
SELECT sum(amount)
FROM Payments
WHERE paymentDate = '2004-10-28'
 
-- Q6. Report the account representative for each customer.
SELECT customerName, salesRepEmployeeNumber, lastName, firstName
FROM Customers, Employees
WHERE Customers.salesRepEmployeeNumber = Employees.employeeNumber

-- Q7. Report total for Atelier graphique.
SELECT sum(amount)
FROM Customers, Payments
WHERE CustomerName = 'Atelier graphique' AND Customers.customerNumber = Payments.customerNumber

-- Q8. Report the total payments by date.
SELECT paymentDate, sum(amount)
FROM Payments
GROUP BY paymentDate

-- Q9. Report the products that have not been sold.
SELECT productName
FROM products
WHERE NOT EXISTS (SELECT * FROM OrderDetails WHERE Products.productCode = OrderDetails.productCode)

-- Q10. List the amount paid by each customer.
SELECT customerName, sum(amount)
FROM Customers, Payments
GROUP BY customerName;

-- Q11. List products sold by order date
SELECT orderDate, productCode
FROM OrderDetails, Orders
WHERE OrderDetails.orderNumber = Orders.orderNumber
ORDER BY OrderDate

-- Q12. List all the orders for the 1940 Ford Pickup Truck.
SELECT quantityOrdered, productName
FROM OrderDetails, Products
WHERE productName like '%1940 Ford Pickup Truck%' AND OrderDetails.productCode = Products.productCode

-- Q13. List the names of the customers and the corresponding order numbers where a particular order from that customer has a value greater than $5,000.
SELECT customerName, Orders.orderNumber, (quantityOrdered*priceEach)
FROM Customers, OrderDetails, orders
WHERE OrderDetails.orderNumber = Orders.orderNumber AND Customers.customerNumber = Orders.customerNumber AND ((quantityOrdered*priceEach) > 5000);

-- Q14. List the products that appear on all orders (if there are any).
SELECT productName
FROM Products
WHERE  NOT EXISTS (SELECT * FROM Orderdetails WHERE Products.productCode = OrderDetails.productCode);

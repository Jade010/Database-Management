-- This repository provides a wide range of SQL queries that have been executed to extract meaningful insights and perform several operations on various hypothetical databases. These SQL queries demonstrate my capability to tackle real-world scenarios using SQL. Below, I have described the purpose and functionality of each query.

-- 1 What is the average percentage markup of the MSRP on buyPrice?
SELECT (avg((MSRP-buyprice)/buyPrice)*100) as average_percent_markup
FROM Products

-- 2 How many distinct products does ClassicModels sell?
SELECT count(DISTINCT(productCode)) as amount_distinct_products
FROM Products

-- 3 Report the name and city of customers who dont have sales representatives?
SELECT customerName, city
FROM Customers
WHERE salesRepEmployeeNumber IS NULL

-- 4 What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employees's first name and last name into a single field for reporting.
SELECT CONCAT(firstName,' ', lastName)as Executive_Name, jobTitle
FROM Employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%Manager%';


-- 5 Which orders have a value greater than $5,000?
SELECT orderNumber, (quantityOrdered*priceEach) as Value
FROM OrderDetails
WHERE (quantityOrdered*priceEach)>5000
ORDER BY Value;

-- 6 Who is at the top of the orginazation (i.e., reports to no one)?
SELECT CONCAT(firstName,' ', lastName)as Executive_Name, jobTitle
FROM Employees
WHERE reportsTo IS NULL;

-- 7 Who reports to William Patterson?
SELECT CONCAT(firstName,' ', lastName) as ReportersName
FROM Employees
WHERE reportsTo 
IN (SELECT employeeNumber
	FROM Employees
	WHERE CONCAT(firstName,' ', lastName) = 'William Patterson');

-- 8 List all the products purchased by Herkku Gifts.
SELECT productName
FROM Customers, Orders, OrderDetails, Products
WHERE Customers.customerNumber = Orders.customerNumber 
		AND Orders.orderNumber = OrderDetails.orderNumber 
		AND OrderDetails.productCode = Products.productCode
		AND customerName = 'Herkku Gifts'

-- 9 Compute the commission for each sales representative, assuming the commission is 5% of the cost of an order. Sort by employee last name and first name.
SELECT CONCAT(firstName,' ', lastName) as SalesRep, sum(priceEach*quantityOrdered*0.05) as Commission
FROM Employees, OrderDetails, Orders, Customers
WHERE Employees.employeeNumber = Customers.salesRepEmployeeNumber 
		AND Customers.customerNumber = Orders.customerNumber
		AND Orders.orderNumber = OrderDetails.orderNumber
GROUP BY CONCAT(firstName,' ', lastName)

-- 10 What is the difference in days between the most recent and oldest order date in the Orders file?
SELECT datediff(day, min(Orders.orderDate), max(Orders.orderDate)) as DifferencInDays
FROM Orders
		
-- 11 Compute the average time between order date and ship date for each customer ordered by the largest difference.
SELECT Customers.customerName, avg(datediff(day, Orders.orderDate, Orders.shippedDate)) as average_Days
FROM Customers, Orders
WHERE Customers.customerNumber = Orders.customerNumber
GROUP BY customerName
ORDER BY average_Days desc

-- 12 What is the value of orders shipped in August 2004?
SELECT sum(quantityOrdered*priceEach) as value
FROM OrderDetails, Orders
WHERE OrderDetails.orderNumber = Orders.orderNumber 
		AND DATENAME(month, shippedDate) = 'August'
		AND DATENAME(year, shippedDate) = '2004'

-- 13 List the employees who report to those employees who report to Diane Murphy.
SELECT CONCAT(firstName,' ', lastName) as Employee
FROM Employees
WHERE reportsTo in (SELECT employeeNumber FROM Employees WHERE  reportsTo in 
                            (SELECT employeeNumber FROM Employees WHERE CONCAT(firstName,' ', lastName) = 'Diane Murphy'))
	
-- 14 Which payments in any month and year are more than twice the average for that month and year (i.e. compare all payments in Oct 2004 With the average payment for Oct 2004)? Order the results by the date of the payment. 
SELECT paymentDate, amount
FROM Payments 
WHERE amount < (SELECT avg(amount)*2 FROM Payments WHERE DATENAME(month, paymentDate) = DATENAME(month, paymentDate) 
                AND DATENAME(year, paymentDate) = DATENAME(year, paymentDate))
ORDER BY paymentDate


-- 15 Report for each product, the percentage value of its stock on hand as a percentage of the stock on hand for product line to which it belongs. Order the report by product line and percentage value within product line descending. Show percentaged with two decimal places.
SELECT productname, productLine, sum(quantityInStock*buyPrice)*100 as percent_value
FROM Products
GROUP BY productName,productLine
ORDER BY productLine desc, percent_value

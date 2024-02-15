-- This project involves basic querying of multiple tables using SQLite. 

-- Q1. How many orders were places in January?
SELECT COUNT(orderiD) as #orders
FROM BIT_DB.JanSales
WHERE length(orderid)
AND orderid <> 'Order ID';

-- Q2. How many of those orders were for an iPhone?
SELECT COUNT(orderid) as #orders
FROM BIT_DB.JanSales
WHERE product = 'iPhone' 
  AND length(orderid) = 6
  AND orderid <> 'Order ID';

-- Q3. Select the customer account numbers for all the orders that were placed in February.
SELECT distinct acctnum
FROM BIT_DB.customers c
  INNER JOIN BIT_DB.FebSales f ON c.order_id = f.orderid
WHERE length(orderid) = 6
  AND orderid <> 'Order ID';

-- Q4. Which product was the cheapest one sold in January, and what was the price? different formats
SELECT distinct product, price
FROM BIT_DB.JanSales
WHERE price in (SELECT MIN(price) FROM BIT_DB.JanSales);

-- Q5. List all the products sold in Los Angeles in February, and include how many of each were sold.
SELECT product, SUM(quantity)
FROM BIT_DB.FebSales
WHERE location like '%Los Angeles%'
GROUP BY product;

-- Q6. What is the total revenue for each product sold in January?
SELECT sum(quantity)*price as revenue
  , product
FROM BIT_DB.JanSales
GROUP BY product;


-- Q7. Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what was the total revenue?
SELECT SUM(quantity) as quantity
  , product
  , sum(quantity)*price as revenue
FROM BIT_DB.FebSales 
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY product;


-- Q8. How many customers ordered more than 2 products at a time, and what was the average amount spent for those customers? 
SELECT COUNT(distinct c.acctnum) as customers
  , AVG(quantity*price) as avgSpent
FROM BIT_DB.FebSales f
  LEFT JOIN BIT_DB.customers c ON f.orderid = c.order_id
WHERE f.quantity > 2
  AND length(orderid) = 6 
  AND orderid <> 'Order ID';


-- Q9. Calculate the average popularity for the artists in the Spotify data table. Then, for every artist with an average popularity of 90 or above, show their name, their average popularity, and label them as a “Top Star”.
WITH popularity_average_CTE as (
  SELECT s.artist_name
   , AVG(s.popularity) as avgPopularity
  FROM SpotifyData s 
  GROUP BY s.artist_name
)
SELECT artist_name
  , avgPopularity
  , 'Top Star' as tag
FROM popularity_average_CTE
WHERE average_popularity >= 90;

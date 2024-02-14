-- This project comprises a series of SQL queries focused on sales analysis for the fictitious company AdventureWorks. 
-- The data is retrieved from the AdventureWorksDW2014 SQL Server sample database.
-- The queries are intended to deliver insights regarding the company's resellers, customers, and geographical sales distribution.

USE [AdventureWorksDW2014];

-- What is the name of the Reseller that had the highest Dollar Sales Amount (highest total sales)?
SELECT [ResellerName], SUM([SalesAmount]) as [Total Revenue], [BusinessType], [City], [StateProvinceName], [EnglishCountryRegionName], AVG([OrderQuantity]) as [AVG # Units]
FROM [dbo].[FactResellerSales] as frs
      INNER JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      INNER JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
GROUP BY [ResellerName], [BusinessType], [City], [StateProvinceName], [EnglishCountryRegionName]
ORDER BY SUM([SalesAmount]) DESC


-- What is the name of the Reseller that had the highest average # line items per invoice?
SELECT [ResellerName]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , FORMAT(SUM(([UnitPrice] * [UnitPriceDiscountPct])*[OrderQuantity]), 'N2') as [Sale Total]
      , [BusinessType], [City], [StateProvinceName], [EnglishCountryRegionName]
FROM [dbo].[FactResellerSales] as frs
      JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
GROUP BY [ResellerName], [BusinessType], [City], [StateProvinceName], [EnglishCountryRegionName]
ORDER BY COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) DESC


-- What is the name of the city that had the highest total sales
SELECT [City], [BusinessType]
      , SUM([SalesAmount]) as [Total revenue]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
FROM [dbo].[FactResellerSales] as frs
      JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
 GROUP BY [City], [BusinessType]
 ORDER BY [City], SUM([SalesAmount]) DESC
 

-- What is the name of state or province from France that had the highest total sales?
SELECT [StateProvinceName]
      , SUM([SalesAmount]) as [Total revenue]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
FROM [dbo].[FactResellerSales] as frs
      JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
 WHERE [EnglishCountryRegionName] = 'France'
 GROUP BY [StateProvinceName]
 ORDER BY [StateProvinceName] DESC


-- Compare the total sales by country
SELECT [EnglishCountryRegionName]
      , SUM([SalesAmount]) as [Total revenue]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
FROM [dbo].[FactResellerSales] as frs
      JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
WHERE [EnglishCountryRegionName] IN ('France', 'Germany', 'United Kingdom')
GROUP BY [EnglishCountryRegionName]


SELECT [EnglishCountryRegionName]
      , SUM([SalesAmount]) as [Total revenue]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
FROM [dbo].[FactResellerSales] as frs
      JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
WHERE [EnglishCountryRegionName] IN ('France', 'Germany', 'United Kingdom')
GROUP BY [EnglishCountryRegionName]
ORDER BY SUM([SalesAmount]) DESC


SELECT [EnglishCountryRegionName]
      , SUM([SalesAmount]) as [Total revenue]
      , SUM([OrderQuantity]) as [Total # Units]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
FROM [dbo].[FactResellerSales] as frs
    JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
    JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
WHERE [EnglishCountryRegionName] = 'United States'
GROUP BY [EnglishCountryRegionName]

SELECT [EnglishCountryRegionName]
      , SUM([SalesAmount]) as [Total revenue]
      , SUM([OrderQuantity]) as [Total # Units]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
      , COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) as [AVG line items Per Invoice]
FROM [dbo].[FactResellerSales] as frs
      JOIN [dbo].[DimReseller] as r ON r.[ResellerKey] = frs.[ResellerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
GROUP BY [EnglishCountryRegionName]
ORDER BY  COUNT([SalesOrderLineNumber])/COUNT(DISTINCT([SalesOrderNumber])) DESC


-- Change to the FactInternetSales table to examine individual customers. Total the sales and units, # Invoices, and Invoice average by City in the United Kingdom
SELECT [City]
      , SUM([SalesAmount]) as [Total revenue]
      , SUM([OrderQuantity]) as [Total # Units]
      , COUNT(DISTINCT([SalesOrderNumber])) as [Total Invoices]
FROM [dbo].[FactInternetSales] as f
      JOIN [dbo].[DimCustomer] as c ON c. [CustomerKey] = f.[CustomerKey]
      JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = c.[GeographyKey]
WHERE [EnglishCountryRegionName] = 'United Kingdom'
GROUP BY [City]
ORDER BY SUM([SalesAmount]) DESC

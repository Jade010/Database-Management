-- This repository contains an in-depth SQL analysis carried out on the AdventureWorks2019 database. The analysis primarily involves subquerying, table joining, data manipulation, and creation of local variables. The main objective is to answer various business questions and meet specific requirements by extracting meaningful insights from the data.

USE [AdventureWorks2019];

-- Which product prices are 50% more than average?
SELECT [ProductKey], [ModelName], [ProductAlternateKey], [DealerPrice]
FROM [dbo].[DimProduct]
WHERE [DealerPrice]> (SELECT AVG([DealerPrice]) FROM [dbo].[DimProduct]) * 1.5
ORDER BY [DealerPrice]


-- What are the total unit sales and revenue for each reseller in the state of Washington, sorted by the type of business and total revenue in descending order?

SELECT [StateProvinceName], [BusinessType], [ResellerKey], [ResellerName]
	, (SELECT COUNT([OrderQuantity]) FROM [dbo].[FactResellerSales] as s WHERE s.[ResellerKey] = r.[ResellerKey]) AS [Unit Sales]
	, (SELECT FORMAT(SUM([SalesAmount]), 'N0') FROM [dbo].[FactResellerSales] as s WHERE s.[ResellerKey] = r.[ResellerKey]) AS [Total Revenue]
FROM [dbo].[DimReseller] as r
INNER JOIN [dbo].[DimGeography] as g ON g.[GeographyKey] = r.[GeographyKey]
WHERE [StateProvinceName] = 'Washington'
ORDER BY [BusinessType], [Total Revenue] DESC


-- What were the unit sales for each product in either sales channel? 

SELECT [ModelName], [ProductKey], [ProductAlternateKey], [EnglishProductName]
	, ISNULL((SELECT SUM([OrderQuantity]) FROM [dbo].[FactResellerSales] as rs WHERE rs.[ProductKey] = p.[ProductKey]), 0) as [Reseller Units]
	, ISNULL((SELECT SUM([OrderQuantity]) FROM [dbo].[FactInternetSales] as i WHERE i.[ProductKey] = p.[ProductKey]), 0) as [Web Units]
FROM [dbo].[DimProduct] as p
WHERE [FinishedGoodsFlag] = 1
ORDER BY [ModelName]


-- What are the top 10 model names in terms of total units sold, broken down into Reseller Units and Web Units?

SELECT TOP (10) [ModelName]
		, SUM([Reseller Units]) as [Sum Reseller Units]
		, SUM([Web Units]) as [Sum Web Units]
	FROM [Featherman_Analytics].[dbo].[Test]
	GROUP BY [ModelName]


-- What were the unit sales for each product in either sales channel, include [Model Name]. 

SELECT [ModelName], [Color], ISNULL([Class], '') as [Class]
	, ISNULL([ProductLine], '') as [Product line]
	, ISNULL((SELECT SUM([OrderQuantity]) FROM [dbo].[FactResellerSales] as rs WHERE rs.[ProductKey] = p.[ProductKey]), 0) as [Reseller Units]
	, ISNULL((SELECT SUM([OrderQuantity]) FROM [dbo].[FactInternetSales] as i WHERE i.[ProductKey] = p.[ProductKey]), 0) as [Web Units]
FROM [dbo].[DimProduct] as p
WHERE [FinishedGoodsFlag] = 1
ORDER BY [ModelName]


-- What are the aggregated sales details for each finished product, in terms of units sold through resellers and online, while also considering the model name, color, class, and product line of each product? This sales data will be stored in a new table.

DROP TABLE [Featherman_Analytics].[dbo].[Test]
GO

SELECT [ModelName], [Color], ISNULL([Class], '') as [Class]
	, ISNULL([ProductLine], '') as [Product line]
	, ISNULL((SELECT SUM([OrderQuantity]) FROM [dbo].[FactResellerSales] as rs WHERE rs.[ProductKey] = p.[ProductKey]), 0) as [Reseller Units]
	, ISNULL((SELECT SUM([OrderQuantity]) FROM [dbo].[FactInternetSales] as i WHERE i.[ProductKey] = p.[ProductKey]), 0) as [Web Units]
INTO [Featherman_Analytics].[dbo].[Test] 
FROM [dbo].[DimProduct] as p
WHERE [FinishedGoodsFlag] = 1
ORDER BY [ModelName]


-- Which products have a DealerPrice that is 50% greater than the average DealerPrice of all products in the DimProduct table? 
-- Please provide the ProductKey, ModelName, ProductAlternateKey, and DealerPrice of these products, sorted by DealerPrice.

DECLARE @AVG as decimal(6,2) = (SELECT AVG([DealerPrice]) FROM [dbo].[DimProduct])
PRINT @AVG

SELECT [ProductKey], [ModelName], [ProductAlternateKey], [DealerPrice]
FROM [dbo].[DimProduct]

WHERE [DealerPrice] > @AVG * 1.5
ORDER BY [DealerPrice]

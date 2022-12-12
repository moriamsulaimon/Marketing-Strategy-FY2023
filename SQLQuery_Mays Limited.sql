SELECT *
FROM [Mays Limited Report]


-- Checking for Null and Empty Cells

SELECT *
FROM [Mays Limited Report]
WHERE Customer_ID = ''
or Customer_ID IS NULL


-- Check columns data type

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Mays Limited Report'


-- Drop Country Column

ALTER TABLE [Mays Limited].[dbo].[Mays Limited Report]
DROP COLUMN Country


-- Calculate Number of Days to Ship Product and Create Column 

ALTER TABLE [dbo].[Mays Limited Report]
ADD Shipping_Days SMALLINT;

UPDATE [Mays Limited Report]
SET Shipping_Days = DATEDIFF(dd, Order_Date, Ship_Date) + 1
FROM [Mays Limited Report]


-- Extract Order Date Column Year, Month Day Values

ALTER TABLE [dbo].[Mays Limited Report]
ADD Order_Year SMALLINT, Order_Month SMALLINT, Order_Day SMALLINT;

UPDATE [Mays Limited Report]
SET 
Order_Year = DATEPART (YYYY, Order_Date),
Order_Month = DATEPART (Month, Order_Date),
Order_Day = DATEPART (Day, Order_Date) 
FROM [Mays Limited Report]


-- Categorising Shipping Days. If shipping days is greater than 5 days, then it is considered delayed.

ALTER TABLE [dbo].[Mays Limited Report]
Add Delayed_Shipping NVARCHAR(6)

UPDATE [Mays Limited Report]
SET Delayed_Shipping =
CASE
	WHEN Shipping_Days > 5 THEN 'True'
	ELSE 'False'
	END
FROM [Mays Limited Report]


-- Which shipping mode generated the highest profit?

SELECT Ship_Mode, SUM(Profit) AS 'Profit'
FROM [Mays Limited Report]
GROUP BY Ship_Mode 
ORDER BY SUM(Profit) DESC

-- Which shipping mode do customers prefer?

SELECT Ship_Mode, COUNT(Ship_Mode) AS 'Total'
FROM [Mays Limited Report]
GROUP BY Ship_Mode 
ORDER BY COUNT(Ship_Mode) DESC


-- What are the quantity sold per region?

SELECT Region, COUNT(Quantity) AS 'Quantity Sold'
FROM [Mays Limited Report]
GROUP BY Region 
ORDER BY COUNT(Quantity) DESC


-- Which region generated the highest profit?

SELECT Region, SUM(Profit) AS 'Profit'
FROM [Mays Limited Report]
GROUP BY Region 
ORDER BY SUM(Profit) DESC


-- What are the Profits per Category?

SELECT Category, SUM(Profit) AS 'Profit'
FROM [Mays Limited Report]
GROUP BY Category 
ORDER BY SUM(Profit) DESC


-- Which Sub Category recorded the highest loss?

SELECT Sub_Category, SUM(Sales) AS Sales, SUM(Profit) AS Profit, SUM(Sales) - SUM(Profit) AS Loss
FROM [Mays Limited Report]
GROUP BY Sub_Category 
ORDER BY SUM(Sales) - SUM(Profit) DESC


-- What is the total of delayed shipping?

SELECT Delayed_Shipping, COUNT(Delayed_Shipping) AS 'Total of Delayed Shipping'
FROM [Mays Limited Report]
GROUP BY Delayed_Shipping 
ORDER BY COUNT(Delayed_Shipping) DESC


-- What is the percentage of delayed shipping?

SELECT Delayed_Shipping, COUNT(Delayed_Shipping) * 100 / SUM(COUNT(Delayed_Shipping)) OVER () AS '% of Delayed Shipping'
FROM [Mays Limited Report]
GROUP BY Delayed_Shipping 
ORDER BY COUNT(Delayed_Shipping) * 100 / SUM(COUNT(Delayed_Shipping)) OVER () DESC


-- Which segment of customers generated the highest revenue?

SELECT Segment, SUM(Sales) AS Revenue
FROM [Mays Limited Report]
GROUP BY Segment 
ORDER BY SUM(Profit) DESC


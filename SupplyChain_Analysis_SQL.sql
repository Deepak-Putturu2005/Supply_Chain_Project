create database Supplychain_Analysis_db;

-- 1.Total Revenue
SELECT SUM(Revenue) 
AS Total_Revenue
FROM Fact_Orders;

-- 2.Gross Profit
SELECT SUM(Revenue) - SUM(COGS) 
AS Gross_Profit
FROM Fact_Orders;

-- 3.Gross Margin %
SELECT ROUND((SUM(Revenue) - SUM(COGS)) / SUM(Revenue) * 100, 1) 
AS Gross_Margin_Pct
FROM Fact_Orders;

-- 4.On-Time Delivery %
SELECT ROUND(SUM(CASE WHEN Delivery_Status = 'On-Time' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) 
AS OTD_Pct
FROM Fact_Orders;

-- 5.Average Delay Days
SELECT ROUND(AVG(Delay_Days), 1)
AS Avg_Delay_Days
FROM Fact_Orders
WHERE Delay_Days > 0;

-- 6.Order Cycle Time
SELECT ROUND(AVG(DATEDIFF(Actual_Delivery_Date, Order_Date)), 1)
AS Avg_Order_Cycle_Days
FROM Fact_Orders;

-- 7.Shipping Cost % of Revenue
SELECT ROUND(SUM(Shipping_Cost) / SUM(Revenue) * 100, 1)
AS Shipping_Cost_Pct
FROM Fact_Orders;

-- 8.Average Transit Time by Mode
SELECT Ship_Mode,ROUND(AVG(Transit_Days), 1) 
AS Avg_Transit_Days
FROM Fact_Orders
GROUP BY Ship_Mode;

-- 9.Revenue per Customer
SELECT ROUND(SUM(Revenue) / COUNT(DISTINCT Customer_ID), 2)
AS Revenue_Per_Customer
FROM Fact_Orders;

-- 10.Delayed Orders by Carrier
SELECT Carrier,COUNT(*) AS Delayed_Orders
FROM Fact_Orders
WHERE Delivery_Status <> 'On-Time'
GROUP BY Carrier
ORDER BY Delayed_Orders DESC;
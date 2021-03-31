use TSQLV4

--1. Use a derived table to build a query that returns the number of distinct products per year that each
--customer ordered. Use internal aliasing. Use a variable to set the customer number. For example, if
--the customer ID is 1234, the query should report the number of distinct products ordered by customer
--1234 for the years 2014, 2015, and 2016.

SELECT o.custID, YEAR(o.orderDate) AS orderyear, COUNT(DISTINCT od.productID) AS NumProd_Ordered 
FROM sales.orders o 
INNER JOIN sales.orderDetails od 
ON o.orderID = od.orderID 
GROUP BY o.custID, YEAR(o.orderDate)
ORDER BY o.custID, YEAR(o.orderDate);

--2. Use multiple common table expressions to build a query that returns the number of distinct products
--per year that each country's customers ordered. Use external aliasing. Use a variable to set the country
--name. For example, if the country name is France, the query should report the number of distinct
--products ordered by French customers for the years 2014, 2015, and 2016.

DECLARE @country AS NVARCHAR(15) = 'France'; 
WITH CTE AS
(
SELECT c.country, YEAR(o.orderDate) AS orderyear, COUNT(DISTINCT od.productID) AS NumProd_Ordered 
FROM sales.orders o 
    INNER JOIN sales.orderDetails od 
    ON o.orderID = od.orderID 
    INNER JOIN sales.customers c
    ON o.custID = c.custID
GROUP BY c.country, YEAR(o.orderDate)
)
SELECT * FROM CTE WHERE country = @country;

--3. Create a view that shows, for each year, the total dollar amount spent by customers in each country
--for all the years in the database.

DROP VIEW IF EXISTS Sales.CustTotal
GO
CREATE VIEW Sales.CustTotal
AS

SELECT c.country, YEAR(o.orderDate) AS orderyear, SUM(od.unitPrice * od.qty) AS Total_$
FROM Sales.orders o 
INNER JOIN 
sales.orderDetails od 
ON o.orderID = od.orderID 
INNER JOIN sales.Customers c 
ON o.custID = c.custID 
GROUP BY c.country, YEAR(orderdate);
GO

SELECT country, orderyear, Total_$ FROM Sales.CustTotal ORDER BY orderyear, Total_$ DESC;


--4. Create an inline table valued function that accepts as a parameter a country name and returns a table
--with the distinct products ordered by customers from that country. Products are to be identied by
--both product ID and product name.

USE TSQLV4;
DROP FUNCTION IF EXISTS sales.prod;
GO
CREATE FUNCTION sales.prod
(@country AS NVARCHAR(15))
RETURNS TABLE
AS
RETURN
SELECT p.productID, p.productName, o2.country
FROM sales.orders o
INNER JOIN sales.orderDetails od
ON o.orderID = od.orderID
INNER JOIN production.products p
ON od.productID = p.productID
INNER JOIN sales.customers o2
ON o2.custId = o.custID
WHERE country = @country
GROUP BY p.productID, p.productName, o2.country;
GO

SELECT * FROM sales.prod('USA') ORDER BY productID ASC;





--5. Use the CROSS APPLY operator to create a query showing the top three products shipped to customers
--in each country. Your report should contain the name of the country, the product id, the product name,
--and the number of products shipped to customers in that country.



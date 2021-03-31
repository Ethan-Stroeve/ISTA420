-- Name: Ethan Stroeve
-- File: Lab06-stroeve.sql
-- Date: February 8, 2021

use TSQLV4

-- 1. Find employees ids who have orders in both January 2016 and February 2016.

select o.empid 
from Sales.Orders o 
where o.orderdate like '2016-01-%'
intersect
select o1.empid
from Sales.Orders o1 
where o1.orderdate like '2016-02-%';

-- 2. Find employees ids who have orders in both January 2016 or February 2016.

select o.empid 
from Sales.Orders o 
where o.orderdate like '2016-01-%'
union
select o1.empid
from Sales.Orders o1 
where o1.orderdate like '2016-02-%';

-- 3. Find employees ids who have orders in 2016 but not 2014.

select o.empid 
from Sales.Orders o 
where o.orderdate like '2016-%-%'
except
select o1.empid
from Sales.Orders o1 
where o1.orderdate like '2014-%-%';

-- 4. citys and countrys where we both customers and employees

select e.city, e.country from HR.Employees e 
intersect
select c.city, c.country from Sales.Customers c;

-- 5. citys and countrys where we either customers or employees

select e.city, e.country from HR.Employees e 
union
select c.city, c.country from Sales.Customers c;

-- 6. citys and countrys where we have customers not employees

select c.city, c.country from Sales.Customers c
except
select e.city, e.country from HR.Employees e;

-- 7. citys and countrys where we have employees not customers

select e.city, e.country from HR.Employees e 
except
select c.city, c.country from Sales.Customers c;

-- 7. citys and countrys where we have employees but not customers and 
-- cities and coutrys where we have customers but not employees

(select e.city, e.country from HR.Employees e 
union
select c.city, c.country from Sales.Customers c)
except
(select e.city, e.country from HR.Employees e 
intersect
select c.city, c.country from Sales.Customers c)
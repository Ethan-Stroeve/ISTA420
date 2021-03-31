-- Name: Ethan Stroeve
-- File: EX6-stroeve.sql
-- Date: Februrary 16, 2021

CREATE DATABASE Cars;

USE Cars; 

DROP TABLE IF EXISTS customers; 

CREATE TABLE Customers (
	custid int NOT NULL PRIMARY KEY,
	companyName varchar(50),
	lastName varchar(35),
	firstName varchar(35),
	phone varchar(20),
	addressLine1 varchar(50),
	addressLine2 varchar(50),
	city varchar(50),
	state_ varchar(30),
	postalCode varchar(20),
	country varchar(20),
	salesRepid varchar(50),
	creditLimit float(30) 
);

BULK INSERT customers FROM 'C:\Users\ethan\MSSAData\Customers.csv'
WITH 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

SELECT * FROM customers;

-----------------------------------------------
-----------------------------------------------

USE Cars; 

DROP TABLE IF EXISTS employees; 

CREATE TABLE employees (
	empid int NOT NULL PRIMARY KEY,
	lastName varchar(25),
	firstName varchar(25),
	extenstion varchar(10),
	email varchar(50),
	officeCode int,
	reportsTo varchar(20),
	jobTitle varchar (45)

);

BULK INSERT employees FROM 'C:\Users\ethan\MSSAData\Employees.csv'
WITH 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);


SELECT * FROM employees;

-----------------------------------------------
-----------------------------------------------

USE Cars; 

DROP TABLE IF EXISTS offices; 

CREATE TABLE offices (
	officeid int NOT NULL PRIMARY KEY,
	City varchar(25),
	Phone varchar(35),
	addressLine1 varchar(35),
	addressLine2 varchar(20),
	state_ varchar(15),
	country varchar(25),
	postalCode varchar(20),
	territory varchar(15)
);

BULK INSERT offices FROM 'C:\Users\ethan\MSSAData\offices.csv'
WITH 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

SELECT * FROM Offices;
-----------------------------------------------
-----------------------------------------------
USE Cars;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
	productid varchar(50) PRIMARY KEY,
	productName varchar(80),
	productLine varchar(30),
	productScale varchar(50),
	productVendor varchar(50),
	productDescription varchar(max),
	qtyInStock int, 
	buyPrice money, 
	MSRP money
);

BULK INSERT products FROM 'C:\Users\ethan\MSSAData\products.csv'
WITH 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);


SELECT * FROM products;
-----------------------------------------------
-----------------------------------------------
USE Cars;

DROP TABLE IF EXISTS orderDetails;

CREATE TABLE OrderDetails (
	 orderid int,
	 productid varchar(50), 
	 qty int, 
	 price money, 
	 orderLineNumber int
	 constraint pk_orderdetails 
		primary key (orderid, productid),
	constraint fk_orderdetails_products
		foreign key (productid)
		references products (productid),
	constraint fk_orderdetails_orders
		foreign key (orderid)
		references orders (orderid)
); 

BULK INSERT orderDetails FROM 'C:\Users\ethan\MSSAData\OrderDetails.csv'
WITH 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

SELECT * FROM OrderDetails;

-----------------------------------------------
-----------------------------------------------
USE Cars;

DROP TABLE IF EXISTS orders;

CREATE TABLE Orders (
	Orderid int NOT NULL PRIMARY KEY, 
	orderDate varchar(50), 
	requiredDate varchar(50), 
	shippedDate varchar(50), 
	orderStatus varchar(50),
	comments varchar(max), 
	custid int FOREIGN KEY REFERENCES customers(custid)
);

BULK INSERT orders FROM 'C:\Users\ethan\MSSAData\Orders.csv'
with 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

SELECT * FROM orders;
-----------------------------------------------
-----------------------------------------------
USE Cars; 

DROP TABLE IF exists payments;

CREATE table Payments (
	custid int FOREIGN KEY REFERENCES customers(custid),
	checkNumber varchar(50) NOT NULL PRIMARY KEY,
	paymentDate datetime, 
	amount money
); 

BULK INSERT payments FROM 'C:\Users\ethan\MSSAData\Payments.csv'
with 
(
	FORMAT = 'csv',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

SELECT * FROM payments;

--(a) How many distinct products does ClassicModels sell?
select COUNT(distinct productid) as distinctproducts from products;

--(b) Report the name and city of customers who don't have sales representatives?
select firstName, lastName from Customers where salesRepid = 'NULL';

--(c) What are the names of executives with VP or Manager in their title? Use the CONCAT function
--to combine the employee's rst name and last name into a single eld for reporting.
select concat(firstName, ' ', lastName) as name from employees where jobtitle like '%VP%' or jobTitle like  '%Manager%';

--(d) Which orders have a value greater than $5,000?
select orderid, price from orderdetails where price > 5000;

--(e) Report the account representative for each customer.
select custid, companyname, firstname, lastname, salesrepid from customers;

--(f) Report total payments for Atelier graphique.
select count(p.amount) as totalpayments from customers c
join
Payments p on c.custid = p.custid
where companyName like 'Atelier graphique'

--(g) Report the total payments by date
select c.custid, p.amount, paymentDate from customers c
join
Payments p on c.custid = p.custid
where companyName like 'Atelier graphique'

--(h) Report the products that have not been sold.
select p.productid, p.productname from products p
left join OrderDetails o on o.productid = p.productid
where o.productid is NULL;

--(i) List the amount paid by each customer.
select c.companyName, .custid, sum(p.amount) from customers c
join
Payments p on c.custid = p.custid
group by c.custid, c.companyName;


--(j) List products sold by order date.

--(k) List the order dates in descending order for orders for the 1940 Ford Pickup Truck.

--(l) List the names of customers and their corresponding order number where a particular order from
--that customer has a value greater than $25,000?

--(m) Compute the commission for each sales representative, assuming the commission is 5% of the
--value of an order. Sort by employee last name and rst name.

--(n) What is the dierence in days between the most recent and oldest order date in the Orders le?

--(o) Compute the average time between order date and ship date for each customer ordered by the
--largest dierence.








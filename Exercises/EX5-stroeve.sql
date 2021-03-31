--Name: Ethan Stroeve
--File: EXR5-stroeve.sql
--Date: February 9, 2021

USE TSQLV4;

select * from dbo.presidents
delete dbo.presidents

-- 1. Create an appropriate table schema.

DROP TABLE IF EXISTS dbo.presidents;

CREATE TABLE dbo.presidents  (
	id varchar (2) not null,
	lastname varchar(20),
	firstname varchar(20),
	middlename varchar(20),
	orderofpres varchar(22),
	dateofbirth varchar(22),
	dateofdeath varchar(22),
	pob varchar (50),
	sob varchar (30),
	hs varchar (30),
	party varchar (100),
	datestart varchar(22),
	dateleft varchar(22),
	assattemp varchar(21),
	assass varchar(21),
	religion varchar(30),
	imagepath varchar(50)
);

-- 2. Insert the CSV data into the table you just created.

BULK INSERT dbo.presidents FROM 'C:\Users\ethan\MSSA2021\Database\US_Presidents.txt'
WITH
(
	DataFileType = 'char',
	FieldTerminator = ',',
	RowTerminator = '\n',
	format = 'csv'
);

SELECT * FROM dbo.presidents;

-- 3. Delete the column that contains the path to the images.

ALTER TABLE dbo.presidents
DROP COLUMN imagepath;

-- 4. Delete the first record from your table using the output clause. This is the header.

DELETE FROM dbo.presidents 
OUTPUT 
deleted.ID, 
deleted.LastName, 
deleted.FirstName, 
deleted.MiddleName, 
deleted.OrderofPres, 
deleted.DateofBirth, 
deleted.DateofDeath, 
deleted.pob, 
deleted.sob,
deleted.hs,
deleted.Party,
deleted.DateLeft,
deleted.assattemp, 
deleted.religion
where ID = 'ID';

alter table dbo.presidents
 add constraint PK_presidents primary key (ID);



-- 5. Bring the data up to date by updating the last row. Use the output clause.

UPDATE dbo.presidents
SET dateleft = '1/20/2017'
WHERE id LIKE '44';

-- 6. Bring the data up to date by adding a new row. Use the output clause.

INSERT INTO dbo.presidents (id, lastname, firstname, middlename, orderofpres,
dateofbirth, pob, sob, hs, party, datestart, dateleft, assattemp, assass, religion)
VALUES(45, 'Trump', 'Donald', 'John', 45, '06/14/1946', 'New York City', 'New York',
'New York', 'Republican', '01/20/2017', '01/20/2021', 'True', 'False', 'Christian');

INSERT INTO dbo.presidents (id, lastname, firstname, middlename, orderofpres,
dateofbirth, pob, sob, hs, party, datestart, assattemp, assass, religion)
VALUES(46, 'Biden Jr.', 'Joseph', 'Robinette', 46, '11/20/1942', 'scranton', 'Pennsylvania',
'Pennsylvania', 'Democratic', '01/20/2021', 'False', 'False', 'Catholic');

-- 7. How many presidents from each state belonged to the various political parties? Aggregate by party
-- and state. Note that this will in eect be a pivot table.

SELECT hs, party, COUNT(party)
FROM dbo.presidents
GROUP BY hs, party;

-- 8. Create a report showing the number of days each president was in office.

SELECT id, lastname, firstname, DATEDIFF(DAY, datestart, dateleft) AS daysInOffice
FROM dbo.presidents;

-- 9. Create a report showing the age (in years) of each present when he took office.

SELECT id, lastname, firstname, DATEDIFF(YEAR, dateofbirth, datestart) AS Agetookoffice
FROM dbo.presidents;

-- 10. See if there is any correlation between a president's party and
-- reported religion, or lack of reported religion

SELECT Party, religion, COUNT(religion) AS numOfReligion
FROM dbo.presidents
GROUP BY party, religion;

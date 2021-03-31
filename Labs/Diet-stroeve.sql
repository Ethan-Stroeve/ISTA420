-- Name: Ethan Stroeve
-- File: diet.sql
-- Date: Februrary 16, 2021

use diet;
go
drop table if exists dbo.diet;
go
create table dbo.diet(
		--foodId int identity (1,1)
		--CONSTRAINT  Pk_diet primary key,
		foods varchar(50),
		priceserving float,
		servingsize varchar(50),
		calories float,
		cholesterol float,
		totalfat float,
		sodium float,
		carbs float,
		fiber float,
		protein float,
		vitAIU float,
		vitCIU float,
		calcium float,
		iron float
);
go
Bulk insert dbo.diet from 'C:\Users\ethan\MSSAData\diet.csv'
	with
		(firstrow = 2,
		format = 'csv',
		fieldquote = '"',
		datafiletype = 'char',
		fieldterminator = ',',
		rowterminator = '\n'
		);
go
select * from dbo.diet
go
select foods, carbs, calories from dbo.diet where carbs < 10 and calories > 100;
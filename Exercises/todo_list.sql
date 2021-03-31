.echo on
.header on

-- Name: Ethan Stroeve
-- File: myfamily.sql
-- date: Jan 11, 2021

drop table if exists myfamily;

create table todo_list (
	Chore_id int primary key,
	task text,
	location int,
	mood text,
	minutes real
	);
	
	insert into todo_list values (1,'Wash the dishes','House','meh',20);
	insert into todo_list values (2,'Laundry','House','okay',20);
	insert into todo_list values (3,'Mowing','Backyard','rad',20);
	insert into todo_list values (4,'taking out trash','House','content',20);
	insert into todo_list values (5,'Meeting','Office','Professional',60);
	insert into todo_list values (6,'Software development','MSSA','Professional',240);
	insert into todo_list values (7,'Gym','planet fitness','pumped',240);
	
	select * from todo_list;
	select sum(minutes) from todo_list;
	select * from todo_list where location like 'house'
	select * from todo_list where task like 'Meeting'
-- drop view
-- drop (delete) a view from the database.

create table workers(
w_id int primary key,
name varchar(50),
age int,
salary int
);

insert into workers()
values
(1, 'Sahil', 21, 15000),
(2, 'Alen', 22, 13000),
(3, 'John', 22, 14000),
(4, 'Alex', 20, 13000),
(5, 'Mathew', 22, 14000),
(6, 'Sia', 21, 15000),
(7, 'David', 22, 16000),
(8, 'Tim', 21, 14000),
(9, 'Leo', 20, 15000),
(10, 'Tom', 21, 16000);

select * from workers;

-- create a view --
create view workers_salaries as
select w_id, salary from workers;

select * from workers_salaries;

-- drop the view -- 
drop view workers_salaries;

-- delete from view
create view workers_salaries as
select w_id, salary from workers;

delete from workers_salaries where salary < 14000;

select * from workers_salaries;

drop view workers_salaries;






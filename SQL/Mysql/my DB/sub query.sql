-- index
-- are used to find vaues within a specific column more quikly

show indexes from customers;

create index last_name_index
on customers(last_name);

select * from customers
where last_name = 'Perkins';

create index last_name_first_name_idx
on customers(last_name, first_name);

alter table customers
drop index last_name_index;

select * from customers
where last_name = 'Perkins' and first_name = 'Ann';


-- subquery
-- a query within another query


select concat(first_name,' ',last_name) as employee, hourly_pay, 
		(select avg(hourly_pay) from employees) as avg_pay
from employees;

select concat(first_name,' ',last_name) as employee, hourly_pay
from employees 
where hourly_pay > (select avg(hourly_pay) from employees);

select concat(first_name,' ',last_name) as customers
from customers
where customer_id in
(select distinct customer_id from transactions where customer_id is not null);

select concat(first_name,' ',last_name) as customers
from customers
where customer_id not in
(select distinct customer_id from transactions where customer_id is not null);


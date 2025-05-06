use mydb;

-- limit

SELECT * FROM customers
limit 2;

SELECT * FROM customers
limit 5, 1;

SELECT * FROM employees
limit 5;

-- union combines the results of 2 or more select statements, with same no of columns
select first_name, last_name from employees
union
select first_name, last_name from customers;

insert into customers values (7, 'sheldon', 'plankton'); 

select first_name, last_name from employees
union all
select first_name, last_name from customers;

delete from customers where customer_id = 7;

-- self join 
-- join another copy of a table to itself
-- used to compare rows of the same table
-- helps to display hierarchy of data

alter table customers
add referral_id int;

update customers
set referral_id = 1
where customer_id = 6;

select a.customer_id, a.first_name, a.last_name,
	   concat(b.first_name, '  ' ,b.last_name) as referred_by
from customers as a
inner join customers as b
on a.referral_id = b.customer_id;

select a.customer_id, a.first_name, a.last_name,
	   concat(b.first_name, '  ' ,b.last_name) as referred_by
from customers as a
left join customers as b
on a.referral_id = b.customer_id;

alter table employees
add supervisor_id int;

update employees
set supervisor_id = 5
where not employee_id = 1;

update employees
set supervisor_id = 1
where employee_id = 5;

select  a.first_name, a.last_name,
	   concat(b.first_name, '  ' ,b.last_name) as reports_to
from employees as a
inner join employees as b
on a.supervisor_id = b.employee_id
;

select  a.first_name, a.last_name,
	   concat(b.first_name, '  ' ,b.last_name) as reports_to
from employees as a
left join employees as b
on a.supervisor_id = b.employee_id
;
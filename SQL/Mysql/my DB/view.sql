use mydb;
-- views
-- a virtual table based on the result-set of sql statement
-- the fields in a view are fields from one or more real tables in the database
-- they are not real tables, but can be interaced with as they ere

create view employee_attendance as 
SELECT first_name, last_name 
FROM employees;


select * from employee_attendance
order by first_name asc;

alter table customers
add column email varchar(50);

update customers
set email = concat(lower(first_name),lower(last_name),'@bellybottom.com');

select * from customers;

create view customer_emails as
select email
from customers;
select * from customer_emails


# drop view employees_attendance;
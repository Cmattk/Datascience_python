# functions

select count(amount) as "Total Transactions"
from transactions;

select max(amount) as "Maximum Transaction"
from transactions;

select min(amount) as "Minimum Transaction"
from transactions;

select sum(amount) as "Sum of Transaction"
from transactions;

select concat(first_name, " " ,last_name)  as full_name
from employees;

# logical operators

alter table employees
add column job varchar (25) after hourly_pay;

select * from employees;

update employees
set job = "asst.manager"
where employee_id = 5;

select * from employees
where hire_date > "2002-02-01" and job = 'cook';

select * from employees
where job = 'cashier' OR job = 'cook';

select * from employees where not job = 'manager';

select * from employees where not job = 'manager' and not job = 'asst.manager';

select * from employees where hire_date between '2002-08-01' and '2005-01-06';

select * from employees where job in ('cook', 'cashier','asst.manager');

-- wild card characters % _
-- used to substitute one or more characters in a string

select * from employees
where first_name like 's%';

select * from employees
where hire_date like '2003%';

select * from employees
where last_name like '%r';

select * from employees
where first_name like 'sp%';

select * from employees
where job like '_ook';

select * from employees
where hire_date like '____-11-__';

select * from employees
where job like '_a%';

-- order by clause 
-- ascending or descending

select * from employees
order by last_name;

select * from employees
order by last_name desc;

select * from employees
order by hire_date;

select * from transactions
order by amount;



-- triggers = when an event happens, do something
--   ex. (insert, update, delete)
--   check data, handle errors, auditing tables

alter table employees
add column salary decimal (10,2) after hourly_pay;

update employees
set salary = hourly_pay * 2080;

create trigger before_hourly_pay_update
before update on employees
for each row
set new.salary = (new.hourly_pay * 2080);

show triggers;

update employees
set hourly_pay = hourly_pay + 1 ;

create trigger before_hourly_pay_insert
before insert on employees
for each row
set new.salary = (new.hourly_pay * 2080);

insert into employees
values (7,'Missy','Cap', 11.00, null, 'IT expert', '2007-01-01', 5, 'missycap@krubyhotel.com');

SELECT * FROM employees;

create table expenses(
	expense_id int primary key,
    expense_name varchar(50),
    expense_total decimal (10,2)
);

insert into expenses
values (1,'salaries',0), (2,'supplies', 0), (3, 'taxes', 0);

update expenses
set expense_total = (select sum(salary) from employees)
where expense_name = 'salaries';

create trigger after_salary_delete
after delete on employees
for each row
update expenses
set expense_total = expense_total - old.salary
where expense_name = 'salaries';

delete from employees
where employee_id = 7;

create trigger after_salary_insert
after insert on employees
for each row
update expenses
set expense_total = expense_total + new.salary
where expense_name = 'salaries';

insert into employees
values (7,'Missy','Cap', 11.00, null, 'IT expert', '2007-01-01', 5, 'missycap@krubyhotel.com');

create trigger after_salary_update
after update on employees
for each row
update expenses
set expense_total = expense_total + (new.salary - old.salary)
where expense_name = 'salaries';

update employees
set hourly_pay = 100
where employee_id = 1;

select * from expenses;
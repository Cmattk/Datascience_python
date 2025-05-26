--- create a view --
-- syntax: create view <name> as select <col1>, <col2>,.. from <tablename> where [conditions];

-- examples --
create view it_employees  as
select employee_id, employee_name, salary
from employees
where department = 'IT';

select * from it_employees;

--- based on multiple columns --
create view eco_employees as
select employee_id, employee_name, salary
from employees
where department = 'Finance' or department = 'Marketing';

select * from eco_employees;

--- based on multiple tables --
create view pythonenrolledview as
select s.id,s.sname, s.age
from studentdetails as s 
join enrolledin as e on s.id = e.id
join coursedetails as c on e.id = c.id
where c.name = 'Python';




-- Between Operator
-- is used to filter results within a specified range, 
-- including both boundary values.

-- Filter Employees with Salary Between 70000 and 80000
select * from employees
where salary between 70000 and 80000;


--  Filter Employees with Salary Not in the Range of 70000 to 80000
select * from employees 
where salary not between 70000 and 80000;





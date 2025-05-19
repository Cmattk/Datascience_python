-- ANY and ALL operators
-- are used in conjunction with subqueries to compare a single value to a set of values.

-- The ANY operator returns TRUE if the comparison is TRUE for at least one value in the set.
-- ALL operator returns TRUE only if the comparison is TRUE for all values in the set.

-- ANY
-- It can be used with various comparison operators like =, <, >, <=, and >=.

select * from employees;

--- find employees whose salary is greater than the salary of any employee in the 'HR' department.
select employee_name, salary
from  employees
where salary > ANY (select salary from employees where department = 'HR');

select * from employees
where salary > any (select salary from employees where department = 'IT');


-- ALL 
-- The condition is true if the comparison is true for all values in the set.
-- find employees whose salary is greater than the salary of all employees in the 'HR' department.

select employee_name, salary
from employees
where salary > ALL (select salary from employees 
where department = 'HR');


-- Combine ANY and ALL with other clauses

-- Find employees who earn more than any employee in a different department, and list their department details:
select employee_id, employee_name, department
from employees
where salary > ANY (select salary from employees);


CREATE TABLE if not exists departments (
    department_id VARCHAR(50) PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT ignore INTO departments (department_id, department_name) VALUES
('Finance', 'Finance'),
('HR', 'HR'),
('IT','IT'),
('Marketing', 'Marketing');


SELECT e.employee_id, e.employee_name, d.department_name
FROM employees as e
join departments as d on e.department = d.department_id
where e.salary > any (select salary from employees where department = 'Marketing');
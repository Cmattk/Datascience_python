-- Aggregate Functions
-- process a set of values and returns a single value.
-- includes - count(), sum(), avg(), max(), min()

-- count()
-- returns the number of rows match a specified condition. it counts all the rows that meet the criterion.

select count(*) as total_employees from employees;

select count(distinct employee_name) as total_no_employees from employees;


-- sum()
-- total sum of a numeric column

select sum(salary) as total_salary from employees;

select department, sum(salary) as total_salary_per_department
from employees
group by department;

select department, sum(salary) as total_salary_per_department
from employees
group by department
having sum(salary) > 125000;

-- avg() 
-- returns average value of a numeric column

select avg(salary) as average_salary from employees;

select department, avg(salary) as avg_salary_per_department
from employees
group by department;


-- MAX() 
-- function returns the maximum value in a set of values.

SELECT MAX(salary) AS highest_salary FROM employees;

select department ,max(salary) as max_salary_per_department
from employees
group by department;


-- min() 
SELECT MIN(salary) AS lowest_salary FROM employees;

select department ,min(salary) as min_salary_per_department
from employees
group by department;



-- the GROUP BY clause is useful operator 
-- that is used to group rows that have the same values, 
-- and can be used to push these values into summary rows, like 
-- "find the number of customers in each city" or 
-- "calculate the total number of sales per product category."

-- It is often used along with aggregate functions like SUM, COUNT, AVG, MIN, and MAX 
-- to perform calculations on grouped data.

select department, AVG(salary) as average_salary 
from employees
group by department;

-- Grouping by Multiple Columns
select department, employee_name, AVG(salary) as average_salary
from employees
group by department, employee_name;

select department, count(*) as employee_count
from employees
group by department;

SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department ORDER BY total_salary desc;

SELECT department, MIN(salary) AS min_salary
FROM employees
GROUP BY department;

select * from employees;
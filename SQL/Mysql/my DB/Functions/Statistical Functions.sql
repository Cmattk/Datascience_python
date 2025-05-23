-- Statistical Functions --
-- are built-in functions that perform statistical analysis on numerical data within a database.
-- These functions helps to summarize and understand data by calculating various statistical measures.

-- statistical functions: --
/*
    AVG()
    SUM()
    COUNT()
    MIN()
    MAX()
    STDDEV()
    VARIANCE()
*/

-- alter & update table --
ALTER table employees
ADD experience int;

UPDATE employees 
set experience =  5
WHERE employee_id IN (1, 7);

UPDATE employees 
set experience =  7
WHERE employee_id IN (2, 6);

UPDATE employees set experience =  10 WHERE employee_id = 3;
UPDATE employees set experience =  6 WHERE employee_id = 4;
UPDATE employees set experience =  8 WHERE employee_id = 5;
UPDATE employees set experience =  12 WHERE employee_id = 8;

select * from employees;

-- avg()
select 
    avg(salary) as average_salary, -- stats func
    floor(avg(salary)) as floored_average -- math func
from employees;

-- sum()
select
    department, 
    sum(salary) as 'sum of department salary'
from employees
group by department;

-- count() - count the total no of rows
select count(employee_id) as employee_count
from employees;

select
    department, 
    count(employee_id) as 'Total employees per department'
from employees
group by department;

-- min() & max()
SELECT MIN(salary) AS min_salary
FROM employees;

SELECT MAX(salary) AS max_salary
FROM employees;

-- STDDEV() - Standard Deviation - measures the amount of variation or dispersion of values.
SELECT STDDEV(salary) as stddev_salary
from employees;

select
    department, 
    STDDEV(salary) as 'stddev_salary per department'
from employees
group by department;


-- VARIANCE() - Variance - measures how much values vary from the mean.
select VARIANCE(salary) as 'variance_salary'
from employees;

select
    department,
    variance(salary) as 'variance_salary per department'
from employees
group by department;

/*
Using these functions, we can quickly calculate averages, totals, counts, and other statistics to gain insights from your data.
*/


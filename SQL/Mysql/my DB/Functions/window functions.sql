-- window functions
-- are advanced SQL capabilities that enable expensive calculations across sets of rows related to the current row.

-- These functions, in general, permit ranking, running totals, moving averages, 
-- and access to data from other rows within the same result set.

-- Unlike aggregate functions which return a single value for a group of rows, window functions return a result for each row in the result set.

-- Window Functions use the OVER() clause, which can be further customized using ORDER BY and PARTITION BY clauses.

/* syntax:
window_function_name([expression]) over (
    [partition by expression]
    [order by expression [asc/desc]]
    [rows or range frame_clause]
)

PARTITION BY: Result set is divided into partitions, and then the window function is applied.
ORDER BY: This specifies the order of the rows within each partition.
ROWS or RANGE — Defines the window of rows that should be considered for the calculation.

*/

-- row_number()
select * from employees;

select employee_id,
       department,
       salary,
       row_number() over (
        partition by department 
        order by salary desc) as row_num
from employees;      

-- rank()
select employee_id,
       department,
       salary,
       rank() over (
        partition by department 
        order by salary desc) as salary_rank,
       dense_rank() over (
        partition by department 
        order by salary desc) as salary_dense_rank
from employees;

-- RANK()	Gives gaps in ranking when salaries tie.
-- DENSE_RANK()	No gaps in ranking even if salaries tie.

-- sum()
select 
    department,
    sum(salary) over (partition by department ) as total_salary
from employees;    

SELECT
    employee_id,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) AS cumulative_salary
FROM employees;

select employee_id, department, salary,
       sum(salary) over (
        partition by department
        order by salary desc
       ) as dept_cumulative_salary
from employees;

select
    employee_id,
    salary,
    sum(salary) over (
        order by employee_id
        rows between 2 preceding and current row
    ) as sum_salary
from employees;

select
    employee_id,
    salary,
    sum(salary) over (
        order by employee_id
        range between 1 preceding and current row
    ) as sum_salary
from employees;

-- avg()
--  calculates a moving average (also called a rolling average) of employee salaries
-- using a window frame of the current row and two preceding rows, ordered by employee_id.

select
    employee_id,
    salary,
    AVG(salary) over (
        order by employee_id
        rows between 2 preceding and current row) as moving_avg
from employees;

select (60000 + 55000 + 75000) / 3 as moving_avg;

-- 5. LEAD() and LAG()
-- LEAD() and LAG() functions allow you to access subsequent or previous rows' data without the need for self-joins.

select employee_id, salary,
       lead(salary, 1) over (order by employee_id) as next_salary,
       lag(salary, 1) over (order by employee_id) as previous_salary
from employees;

/*
-- Advantages of Window Functions --
Flexibility: Apply functions across partitions of data. Very useful in reporting, analytics.
Clarity: Simplify SQL queries 
Efficiency: Accomplish complex calculations that otherwise may involve multiple joins or subqueries in an single query.
*/



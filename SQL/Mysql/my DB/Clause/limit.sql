-- The LIMIT clause in MySQL is used to specify the maximum number of rows returned by a query.

SELECT * FROM employees LIMIT 3;

-- Retrieve 3 Records Starting from the 2nd Record
select * from employees limit 1, 3;

-- Retrieve the Last 2 Records

SELECT * FROM employees
ORDER BY employee_id DESC
LIMIT 2;


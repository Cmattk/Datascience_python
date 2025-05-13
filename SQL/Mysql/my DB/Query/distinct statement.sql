CREATE TABLE employees (
     employee_id INT PRIMARY KEY,
     first_name VARCHAR(50),
     last_name VARCHAR(50),
     salary DECIMAL(10, 2) );

INSERT INTO employees VALUES
     (1, 'John', 'Doe', 50000),
     (2, 'Jane', 'Smith', 60000),
     (3, 'Robert', 'Johnson', 75000);

SELECT first_name, last_name
FROM employees;

SELECT DISTINCT department
FROM employees;

drop table employees;
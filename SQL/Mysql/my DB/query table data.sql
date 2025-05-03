SELECT last_name, first_name FROM mydb.employees WHERE employee_id > 1;
SELECT * FROM employees WHERE first_name = 'Sandy'; 
SELECT * FROM employees WHERE hourly_pay >= 15;
SELECT * FROM employees WHERE hire_date <= '2004-01-01';
SELECT * FROM employees WHERE hire_date is null;
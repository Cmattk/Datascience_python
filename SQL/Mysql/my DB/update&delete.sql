UPDATE employees
SET hourly_pay = 10.25, hire_date = '2007-03-04'
WHERE employee_id = 6;

DELETE FROM employees 
WHERE employee_id = 6;

SELECT * FROM mydb.employees;
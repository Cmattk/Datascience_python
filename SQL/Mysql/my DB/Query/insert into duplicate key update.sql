drop table employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees (employee_id, employee_name, department, salary)
VALUES
    (1, 'John Doe', 'IT', 60000.00),
    (2, 'Jane Smith', 'HR', 55000.00),
    (3, 'Bob Johnson', 'Finance', 70000.00),
    (4, 'Alice Williams', 'Marketing', 50000.00);


-- INSERT ON DUPLICATE KEY UPDATE Statement

insert into employees(employee_id,salary)
VALUES (4, 55000)
on DUPLICATE KEY UPDATE salary = 55000;

insert into employees(employee_id,salary)
VALUES (3, 55000)
on DUPLICATE KEY UPDATE salary = 75000;


SELECT * FROM `geeks4geeks`.`employees`;
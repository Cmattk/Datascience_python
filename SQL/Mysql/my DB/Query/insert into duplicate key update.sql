
CREATE TABLE if not exists employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT ignore INTO employees (employee_id, employee_name, department, salary)
VALUES
    (1, 'John Doe', 'IT', 60000.00),
    (2, 'Jane Smith', 'HR', 55000.00),
    (3, 'Bob Johnson', 'Finance', 70000.00),
    (4, 'Alice Williams', 'Marketing', 50000.00),
    (5, 'Jeff kate', 'IT', 67300.00),
    (6, 'valee amath', 'HR', 57500.00),
    (7, 'obb son', 'Finance', 77500.00),
    (8, 'cate mirales', 'Marketing', 55000.00);


-- INSERT ON DUPLICATE KEY UPDATE Statement

insert ignore into employees(employee_id,salary)
VALUES (4, 55000)
on DUPLICATE KEY UPDATE salary = 55000;

insert ignore into employees(employee_id,salary)
VALUES (3, 55000)
on DUPLICATE KEY UPDATE salary = 75000;


SELECT * FROM `geeks4geeks`.`employees`;
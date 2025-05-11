CREATE DATABASE IF NOT EXISTS myDB;
USE myDB;

CREATE TABLE employees (
    employee_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay decimal(5,2),
    hire_date DATE,
    PRIMARY KEY (employee_id)
);


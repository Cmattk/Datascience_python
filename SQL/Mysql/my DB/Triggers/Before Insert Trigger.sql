-- Before Insert Trigger
/*
CREATE TRIGGER trigger_name
BEFORE INSERT
ON table_name FOR EACH  ROW  # This specifies that the trigger is to be executed for each inserted row.
BEGIN
    -- SQL statements
END;
*/

-- EX 1: AUTO-Setting a Timestamp

create table trigger_employees(
    id int auto_increment primary key,
    name varchar(100),
    position varchar(50),
    created_at timestamp
);

CREATE TRIGGER before_emp_insert
BEFORE INSERT ON trigger_employees
FOR EACH ROW
BEGIN
    SET  NEW.created_at = NOW();
END;

INSERT INTO trigger_employees (name, position)
VALUES ('JOHN DOE','MANAGER');

SELECT * FROM trigger_employees;

DROP TRIGGER before_emp_insert;
DROP TABLE trigger_employees;

-- EX 2: DATA VALIDATION

create table trigger_employees(
    id int auto_increment primary key,
    name varchar(100),
    position varchar(50),
    salary DECIMAL(10,2)
);

CREATE TRIGGER validate_emp_salary
BEFORE INSERT ON trigger_employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END; 

INSERT INTO trigger_employees (name, position, salary)
VALUES ('JANE SMITH', 'DEVELOPER', -5000.00);

DROP TRIGGER validate_emp_salary;
DROP TABLE trigger_employees;

-- EX3: SETTING DEFAULT VALUES

create table trigger_employees(
    id int auto_increment primary key,
    name varchar(100),
    department varchar(100)
);

CREATE TRIGGER set_dafault_department
BEFORE INSERT ON trigger_employees
FOR EACH ROW
BEGIN
    IF NEW.department IS NULL 
    THEN SET NEW.department = 'GENERAL';
    END IF;
END;

INSERT INTO trigger_employees (name)
VALUES ('ERICKA DA VIN');

SELECT * FROM trigger_employees;

DROP TRIGGER set_dafault_department;
DROP TABLE trigger_employees;

/*
BEFORE INSERT triggers are much like diligent assistants 
who ensure everything is in order before a new record is added to your database

They automate the checks, validations, and modifications that need to be made in your incoming data
to ensure the integrity and consistency of data without manual intervention.
*/







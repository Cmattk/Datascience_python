-- AFTER UPDATE TRIGGER
-- Executes after the specified event.


-- USE CASES FOR AFTER UPDATE TRIGGER --
-- logging changes: The Record details the update operation for auditing purposes.
-- maintainging audit trails: Keep track of the historical changes made to rows.
-- synchronizing data: Update related tables or perform additional calculations based on the updated data.

/*
syntax:
CREATE TRIGGER trigger_name

AFTER UPDATE ON table_name

FOR EACH ROW

BEGIN

    -- Trigger body

END;
*/


-- logging changes
-- an AFTER UPDATE trigger that logs changes to the separate audit table whenever an update occurs on the employees table.

DROP TABLE trigger_employees;
DROP table employee_audit;
DROP TRIGGER log_salary_update;

CREATE TABLE trigger_employees(
    id int auto_increment primary key,
    name varchar(100),
    salary decimal(10,2)
);

INSERT INTO trigger_employees(name,salary)
VALUES 
('John Doe', 50000.00),
('Patrick Salei', 70000.00),
('Pedro Munie', 55000.00),
('Jane Smith', 60000.00);

CREATE TABLE employee_audit(
    id int auto_increment primary key,
    employee_id int,
    old_salary decimal(10, 2),
    new_salary decimal(10, 2),
    changed_at timestamp default current_timestamp
);

CREATE TRIGGER log_salary_update
AFTER UPDATE ON trigger_employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, old_salary, new_salary)
    VALUES (old.id, old.salary, new.salary);
END;


UPDATE trigger_employees
SET salary = 60000.00
WHERE name = 'John Doe';

UPDATE trigger_employees
SET salary = 65000.00
WHERE name = 'Pedro Munie';


SELECT * FROM employee_audit;


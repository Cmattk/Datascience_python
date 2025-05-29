-- BEFORE DELETE TRIGGER:
-- performs specific actions before an DELETE operation is executed on a table.
--  allows us to handle tasks such as logging deleted records,
--  enforcing business rules or validating data before it is removed from the database.
/* Syntax:
CREATE TRIGGER trigger_name
BEFORE DELETE
ON table_name
FOR EACH ROW
BEGIN
-- trigger logic
END;
*/

-- logging deleted records
DROP table trigger_employees;
drop table deleted_employees;
drop trigger del_emp_trigger;
DROP trigger delete_prevention;


/* creating table for employess */
CREATE TABLE trigger_employees(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100)
);

/* creating table from deleted employees */
CREATE TABLE deleted_employees (
    id INT,
    name VARCHAR(100),
    position VARCHAR(100),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* trigger */
CREATE TRIGGER del_emp_trigger
BEFORE DELETE ON trigger_employees
FOR EACH ROW
BEGIN
    insert into deleted_employees (id,name,position)
    values (old.id, old.name, old.position);
END;

INSERT INTO trigger_employees (name,position)
values 
('Alice','Developer'), ('Priya','Tester'),
('Charlie','Designer'), ('Ragina','Tester'),
('Chandra','Developer'), ('Bob','Manager');

SELECT * FROM trigger_employees;


DELETE FROM trigger_employees
where id < 4;

SELECT * FROM trigger_employees;
SELECT * FROM deleted_employees;


-- prevent deletion of certain records
-- e.g manager

CREATE TRIGGER delete_prevention
BEFORE DELETE ON trigger_employees
FOR EACH ROW
BEGIN
    if old.position = 'Manager'
    then 
        signal sqlstate '45000'
        set message_text = 'Managers cannot be deleted.';
    end if;
END;

DELETE FROM trigger_employees
where position = 'Manager';


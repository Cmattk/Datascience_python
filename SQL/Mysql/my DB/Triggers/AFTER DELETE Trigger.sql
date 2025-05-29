-- AFTER DELETE Trigger
-- trigger that activates automatically after a row is deleted from a specified table.
-- such as logging the deletion, updating related tables, or enforcing business rules,
-- making sure that all required actions occur in response to the delete operation.
DROP TABLE trigger_employees;

CREATE TABLE trigger_employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL
);

CREATE TABLE deletion_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action VARCHAR(50)
);

INSERT INTO trigger_employees (name,position)
value 
('Gaurav', 'Software Engineer'),
('Yuvraj', 'Project Manager');

CREATE TRIGGER after_employee_delete
AFTER DELETE ON trigger_employees
FOR EACH ROW
BEGIN
    INSERT INTO deletion_log (student_id,action)
    values (old.id,'Deleted file');
END;

delete from trigger_employees
where name = 'Yuvraj';

SELECT * FROM trigger_employees;
SELECT * FROM deletion_log;


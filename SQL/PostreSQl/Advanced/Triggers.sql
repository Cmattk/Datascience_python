-- is a powerful tool that allows automatic invocation of a function whenever a specified event occurs on a table.
-- Events that can trigger a function include INSERT, UPDATE, DELETE, or TRUNCATE.
-- Triggers help maintain data integrity and automate complex database operations.

-- A trigger is a special user-defined function associated with a table.
-- To create a new trigger, you must define a trigger function first,
-- and then bind this trigger function to a table.

-- The difference between a trigger and a user-defined function is that a trigger is automatically invoked when an event occurs.

-- Types of Triggers
-- Row-Level Triggers: Invoked once for each row affected by the event.
-- e.g an 'UPDATE' statement affecting 20 rows will invoke the row-level trigger 20 times.
-- Statement-Level Triggers: Invoked once per SQL statement, regardless of the number of rows affected.

-- Triggers can be specified to fire before or after the event:
-- BEFORE Trigger: Invoked before the event occurs. Can be used to modify or skip the operation.
-- AFTER Trigger: Invoked after the event occurs. All changes made by the event are available to the trigger.

-- Triggers offer several benefits:
-- Automation: Automatically enforce business rules and data integrity.
-- Centralized Logic: Maintain cross-functionality within the database, ensuring consistent behavior across multiple applications.
-- Historical Data: Automatically log changes to maintain a history of data modifications.

-- While triggers are powerful, they also have some drawbacks:
-- Complexity: Triggers can add complexity to the database. Users must be aware of the triggers and understand their logic to predict data changes accurately.
-- Performance Overhead: Excessive use of triggers can lead to performance issues, especially with complex or nested triggers.

-- Create the Necessary Tables
CREATE TABLE COMPANY_employees(
   ID INT PRIMARY KEY NOT NULL,
   NAME TEXT NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR(50),
   SALARY REAL
);

-- When the name of an employee changes, we log the changes in a separate table named 'employee_audits':
CREATE TABLE employees_AUDIT(
   emp_id INT NOT NULL,
   entry_date TEXT NOT NULL
);

-- Define the Trigger Function called auditlog():
CREATE OR REPLACE FUNCTION emp_auditlog()
RETURNS TRIGGER 
AS $$
BEGIN
    INSERT INTO employees_AUDIT(emp_id, entry_date)
    VALUES (NEW.ID, current_timestamp);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create and Bind the Trigger
--  create a trigger named 'example_trigger' that fires after an 'INSERT' event on the 'COMPANY' table:
CREATE TRIGGER example_trigger
AFTER INSERT ON COMPANY_employees
FOR EACH ROW
EXECUTE FUNCTION emp_auditlog();

-- insert two rows into the company employees table.
INSERT INTO COMPANY_employees (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (1, 'Salama', 25, 'Emali', 45000.00);

INSERT INTO COMPANY_employees (ID, NAME, AGE, ADDRESS, SALARY)
VALUES 
    (2, 'Opiyo', 27, 'Marakwet', 65000.00),
    (3, 'Mueni', 24, 'Kitui', 57000.00);

SELECT * FROM COMPANY_employees;
SELECT * FROM employees_AUDIT;

-- The following illustrates the syntax of creating a trigger function:
-- CREATE FUNCTION trigger_function()
--     RETURNS TRIGGER AS

-- A trigger function receives data about its calling environment through a special structure called TriggerData,
-- which contains a set of local variables.
-- Once you define a trigger function, you can bind it to one or more triggers events such as INSERT, UPDATE, and DELETE.

-- BEFORE INSERT Trigger: 
-- Automatically update created_at timestamp

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP
);

-- trigger func
CREATE OR REPLACE FUNCTION set_created_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.created_at := current_timestamp;
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;
-- trigger
CREATE TRIGGER before_insert_user
BEFORE INSERT ON users 
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

-- use
INSERT INTO users(name) VALUES ('Mathias');
SELECT * FROM users;

-- AFTER INSERT Trigger: 
-- Log insert into another table
CREATE TABLE audit_log(
    id SERIAL PRIMARY KEY,
    action TEXT,
    table_name TEXT,
    logged_at TIMESTAMP DEFAULT current_timestamp
);

CREATE OR REPLACE FUNCTION log_user_insert()
    RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_log(action, table_name)
    VALUES ('INSERT', 'users');
    RETURN NULL;
END;
$$ LANGUAGE PLPGSQL;

CREATE Trigger after_insert_user
AFTER INSERT ON users 
FOR EACH STATEMENT
EXECUTE FUNCTION log_user_insert();

INSERT INTO users(name)
VALUES ('Deji');

INSERT INTO users(name)
VALUES ('Debrah'),('Phillp');


SELECT * FROM users;

SELECT * FROM audit_log;

-- BEFORE UPDATE Trigger: 
-- Prevent changes to a specific column
CREATE OR REPLACE FUNCTION prevent_name_change()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.name IS DISTINCT FROM old.name THEN
        RAISE EXCEPTION 'Changing name is not allowed';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER no_name_change
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION  prevent_name_change();

UPDATE users
SET name = 'Kelvin'
WHERE id = 4;

-- AFTER DELETE Trigger: Archive deleted records

CREATE Table users_archive(
    id int,
    name TEXT,
    deleted_at TIMESTAMP
);

CREATE OR REPLACE FUNCTION archive_deleted_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO users_archive(id, name, deleted_at)
    VALUES (OLD.id, OLD.name, current_timestamp);
    RETURN OLD;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER after_delete_user 
AFTER DELETE ON users  
FOR EACH ROW
EXECUTE FUNCTION archive_deleted_users() ;

DELETE FROM users 
WHERE id = 4;

SELECT * FROM users;
SELECT * FROM users_archive;

--- INSTEAD OF Trigger: 
--  On a VIEW to allow inserts
CREATE VIEW active_users AS
SELECT * FROM users WHERE name IS NOT NULL;

CREATE OR REPLACE FUNCTION insert_into_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO users(name) VALUES (NEW.name);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER instead_of_insert_view
INSTEAD OF INSERT ON active_users
FOR EACH ROW
EXECUTE FUNCTION insert_into_users();


INSERT INTO active_users(name) VALUES ('Celestine');
SELECT * FROM active_users;


--- drop trigger
-- Syntax
-- DROP TRIGGER [IF EXISTS] trigger_name 
-- ON table_name [ CASCADE | RESTRICT ];

/*
CASCADE: Automatically drop objects that depend on the trigger. This option also deletes objects that depend on those dependent objects.
RESTRICT: Refuse to drop the trigger if any objects depend on it. This is the default behavior of the DROP TRIGGER statement.
*/

DROP TRIGGER IF EXISTS instead_of_insert_view
ON active_users;

--  - ALTER TRIGGER
-- Syntax
-- ALTER TRIGGER trigger_name ON table_name
-- RENAME TO new_name;
DROP TABLE my_staff;
CREATE TABLE my_staff(
    user_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username VARCHAR (50) UNIQUE NOT NULL,
    password VARCHAR (50) NOT NULL,
    email VARCHAR (355) UNIQUE NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create a function that validates the username of a staff. 
-- The username of staff must not be null and its length must be at least 3.

CREATE OR REPLACE FUNCTION check_staff_name()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.username) < 3 THEN
        RAISE EXCEPTION 'The usename cannot be less than 3 characters';
    END IF;
    IF NEW.username IS NULL THEN
        RAISE EXCEPTION 'Username cannot be NULL';
    END IF;
    IF LENGTH(NEW.password) < 6 THEN
        RAISE EXCEPTION 'password must be atleast 6 characters.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER check_username_password
BEFORE INSERT ON my_staff
FOR EACH ROW
    EXECUTE FUNCTION check_staff_name();

INSERT INTO my_staff(username, password, email)
VALUES ('do', '3456mf','doefres@vdf.xyx');

INSERT INTO my_staff(username, password, email)
VALUES ('matt ck', '458f','mattck@vdf.xyx');

SELECT tgname FROM pg_trigger WHERE tgrelid = 'my_staff'::regclass;
ALTER TRIGGER check_username_password ON my_staff
RENAME TO check_usernameAndpassword;
SELECT tgname FROM pg_trigger WHERE tgrelid = 'my_staff'::regclass;

-- if your database has multiple schemas, remember that trigger names are unique within a schema but not across the entire database.

-- Disabling a Trigger
-- there are times when you may need to temporarily disable a trigger, such as during bulk inserts, data migrations, or testing phases.

-- Only superusers or table owners can disable triggers using the ALTER TABLE statement.

-- Syntax
-- ALTER TABLE table_name
-- DISABLE TRIGGER trigger_name | ALL

ALTER TABLE my_staff
DISABLE TRIGGER check_usernameAndpassword;

INSERT INTO my_staff(username, password, email)
VALUES ('do', '3456mf','doefres@vdf.xyx');

SELECT * FROM my_staff;

-- Enabling a Trigger
-- To ensure a trigger fires, it must be enabled.
-- Syntax
-- ALTER TABLE table_name
-- ENABLE TRIGGER trigger_name |  ALL;

ALTER TABLE my_staff
ENABLE TRIGGER check_usernameAndpassword;

INSERT INTO my_staff(username, password, email)
VALUES ('matt ck', '458f','mattck@vdf.xyx');








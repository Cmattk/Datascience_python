-- - Transactions
-- is a unit of work that ensures data integrity and consistency. 
-- Transactions are fundamental when you need to add, delete, or update records.
-- Without transactions, these operations could compromise data integrity due to potential anomalies or concurrent access issues.

-- ACID properties that safeguard data integrity.
/*
Atomicity: Guarantees that all parts of a transaction are completed successfully. If any part fails, the entire transaction is rolled back (the "all or nothing" principle).
Consistency: Ensures that a transaction can only bring the database from one valid state to another, maintaining database invariants.
Isolation: Provides the illusion that each transaction is the only one interacting with the database, thereby preventing transactions from interfering with each other.
Durability: Once a transaction has been committed, it will remain so, even in the event of a system failure. This ensures that the effects of the transaction are permanently recorded in the database.
*/

-- BEGIN: Starts a transaction block.
-- COMMIT: Commits the current transaction block, making all changes made within the block permanent.
-- ROLLBACK: Cancels all changes made in the current transaction block, reverting to the state before the transaction began.

CREATE TABLE bankstatements(
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR not NULL,
    balance INT
);


INSERT INTO bankstatements
VALUES
    (1, 'Sekhar rao', 1000),
    (2, 'Abishek Yadav', 500),
    (3, 'Srinivas Goud', 1000);

SELECT * from bankstatements;    

BEGIN;
INSERT INTO bankstatements (customer_id, full_name, balance)
VALUES
    (4, 'Priya chetri', 500);
COMMIT;

BEGIN;
    UPDATE bankstatements 
        SET balance = balance - 500
        WHERE customer_id = 1;

    SELECT customer_id, full_name, balance FROM bankstatements;
    UPDATE bankstatements
        SET balance = balance + 500
        WHERE customer_id = 2;
COMMIT;

SELECT * FROM bankstatements;

-- rollback -- 
-- ROLLBACK command is used to undo the changes done in transactions.

BEGIN;
    DELETE FROM bankstatements
    WHERE customer_id = 1;
    SELECT * FROM bankstatements;
ROLLBACK;
SELECT * FROM bankstatements;

-- commit --
-- is important for saving the changes made during a transaction.
-- Without executing a COMMIT, all the data manipulation operations performed within the transaction will be lost once the session ends.
-- It ensures that the changes made to the database are permanent and visible to other users and sessions.
-- It ensures that any modifications to the database, such as inserts, updates, or deletes, are permanently stored.
-- we commit the transaction in 3 different forms
--  COMMIT TRANSACTION;
--  COMMIT;
--  END TRANSACTION;

BEGIN;
UPDATE bankstatements
    SET balance = balance - 500
    WHERE customer_id = 1;

-- display data before commiting transaction
SELECT * FROM bankstatements;

UPDATE bankstatements
    SET balance = balance + 500
    WHERE customer_id = 2;

COMMIT;

SELECT * FROM bankstatements;

-- BEGIN
-- The BEGIN command in PostgreSQL is essential for transaction management, allowing a sequence of SQL operations to be executed as a single unit of work.

-- Syntax --
-- BEGIN;
-- BEGIN TRANSACTION;

--   ROLLBACK  --
-- allows users to undo changes made during a transaction and ensuring that any errors or unexpected issues do not compromise the databases accuracy.

BEGIN;

INSERT INTO bankstatements (
    customer_id,
    full_name,
    balance
)
VALUES (5, 'Kenfry Raman', 500);

SELECT * FROM bankstatements;

COMMIT;

SELECT * FROM bankstatements;

-- using rollback
BEGIN;

UPDATE bankstatements
    SET balance = balance - 230
    WHERE customer_id = 2;

SELECT * FROM bankstatements;

UPDATE bankstatements
    SET balance = balance + 230
    WHERE customer_id =  1;

SELECT * FROM bankstatements;
ROLLBACK;

SELECT * FROM bankstatements;



----   CONSTRAINTS   -----

-- Primary Key
-- A primary key in PostgreSQL is a column (or a set of columns) that uniquely identifies each row in a table
-- Syntax: column_name Data-type PRIMARY KEY

CREATE TABLE books2 (
    book_id INTEGER PRIMARY KEY,
    title TEXT,
    price INTEGER
);

INSERT INTO books2(book_id, title, price)
VALUES
    ('101', 'Jobs', '2000'),
    ('102', 'Geeta', '250'),
    ('103', 'Ramayana', '354'),
    ('104', 'Vedas', '268');

SELECT * FROM books;

-- updating

CREATE TABLE vendors (name VARCHAR(255));

INSERT INTO vendors (NAME)
VALUES
    ('Microsoft'),
    ('IBM'),
    ('Apple'),
    ('Samsung'); 

SELECT * FROM  vendors;

ALTER TABLE vendors
ADD COLUMN ID SERIAL PRIMARY KEY;

-- Foreign Key --
-- A foreign key is a column (or a group of columns) in one table that references the primary key of another table, establishing a link between the two tables. 
-- Foreign keys play a crucial role in relational databases by establishing relationships between tables and safeguarding data integrity.

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    constraint fk_department FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

-- foreign keys come with several constraints that govern how changes in the parent table affect the child table.
-- set when creating or altering a table.

/*
ON DELETE CASCADE: It Automatically deletes any rows in the child table when the corresponding row in the parent table is deleted.
ON DELETE SET NULL: It Sets the foreign key value in the child table to NULL when the corresponding row in the parent table is deleted.
 It Updates the foreign key in the child table when the corresponding primary key in the parent table is updated.
*/

INSERT INTO departments (department_name)
VALUES ('Human Resources'), ('Finance'), ('IT');

INSERT INTO employees (employee_name, department_id)
VALUES 
('Alice', 1),
('Bob', 2),
('Charlie', 3);

SELECT * FROM departments;
SELECT * FROM employees;

SELECT e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;


-- CHECK Constraint
-- used to enforce data integrity by specifying that a value in a column must meet a specific requirement.
-- This constraint is primarily used while creating a table to ensure that the data adheres to the defined rules.
-- By using the CHECK constraint, you can define rules that the data must comply with, such as value ranges, specific formats, or logical relationships between columns.

-- syntax: variable_name data-type CHECK(condition);

CREATE TABLE workers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR (50),
    last_name VARCHAR (50),
    birth_date DATE check (birth_date > '1900-01-01'),
    joined_date DATE check (joined_date > birth_date + INTERVAL '16 years'),
    salary NUMERIC check (salary > 10000)
);

insert into workers (first_name, last_name, birth_date, joined_date, salary)
values 
('Raju', 'Kumar', '1994-01-01', '2015-07-01', 100000),
('Alice', 'Mwangi', '1990-05-12', '2008-06-15', 45000),
('Brian', 'Otieno', '1985-11-23', '2003-09-01', 52000),
('Catherine', 'Wambui', '1992-03-05', '2010-04-10', 60000),
('Daniel', 'Mutiso', '1978-07-18', '1996-08-20', 70000),
('Esther', 'Kamau', '1988-01-30', '2006-02-01', 48000);

insert into workers (first_name, last_name, birth_date, joined_date, salary)
values ('Kalekye', 'Munene', '2000-06-23', '2015-04-12', 50000);

insert into workers (first_name, last_name, birth_date, joined_date, salary)
values ('Kadija', 'Mwere', '2002-06-23', '2020-08-02', -45000);

SELECT * FROM workers;

-- UNIQUE Constraint
-- UNIQUE constraint is a powerful tool used to ensure that values stored in a column or a group of columns are unique across rows in a table.
-- This constraint is essential for maintaining data integrity, especially when certain data should not be duplicated.
-- For instance, if you're storing email addresses, you wouldn't want the same email to be associated with multiple users.
-- Syntax: UNIQUE(column); or, variable_name Data Type UNIQUE;

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR (50),
    last_name VARCHAR (50),
    email VARCHAR(50) UNIQUE
);

INSERT INTO person (first_name, last_name, email)
VALUES ('Kelly', 'Olekech', 'kellyolekech@gmail.com');
INSERT INTO person(first_name, last_name, email)
VALUES
    ('Nikhil', 'Aggarwal', 'nikhilagg@gmail.com'),
    ('Raju', 'Verma', 'rajuverma@gmail.com');
SELECT * FROM person;

INSERT INTO person (first_name, last_name, email)
VALUES ('Kele', 'Olektch', 'kellyolekech@gmail.com');

-- NOT NULL Constraint
-- NOT NULL constraint is a fundamental feature to ensure that a column cannot contain NULL values.
-- NULL is unique in that NULL is not equal to any other NULL.
-- To check if a value is NULL, use the Boolean operators IS NULL or IS NOT NULL.
-- Syntax: variable_name Data-type NOT NULL;

DROP TABLE invoice;
CREATE TABLE invoice(
    id serial primary key,
    product_id int not null,
    qty NUMERIC NOT NULL check (qty > 0),
    net_price NUMERIC check (net_price > 0)
);

INSERT INTO invoice (product_id, qty, net_price)
VALUES (1, 5, 255);

SELECT * FROM invoice;

INSERT INTO invoice (product_id, qty, net_price)
VALUES
    ('1', NULL, 255);

INSERT INTO invoice (product_id, net_price)
VALUES
    ('1', 255);

-- NOT NULL constraints are typically used for columns that must always have a value, such as primary keys, foreign keys, and essential business data fields like email addresses, usernames, and quantities.
-- NOT NULL is often combined with other constraints like UNIQUE, CHECK, and PRIMARY KEY to provide comprehensive data validation and integrity rules.




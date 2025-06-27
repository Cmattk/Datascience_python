-- index
-- essential for improving database performance, allowing faster data retrieval by creating indexes on specified columns.
-- act like pointers, significantly reducing the time required for query processing, especially on large tables.

-- Syntax
-- CREATE INDEX index_name ON table_name [USING method]
-- (
--    column_name [ASC | DESC] [NULLS {FIRST | LAST }],
--    ...
-- );

-- Index Method: Choose an index method such as 'btree', 'hash', 'gist', 'spgist', 'gin', or 'brin'. PostgreSQL defaults to 'btree'.
-- Sort Order: Specify the sort order with 'ASC' (default) or 'DESC'.
-- Nulls Order: Specify 'NULLS FIRST' or 'NULLS LAST'. 'NULLS FIRST' is the default with 'DESC', and 'NULLS LAST' is the default with 'ASC'

-- 1. Single-Column Indexes
-- A single-column index is created for just one column, which is efficient if 
-- that column is frequently used in WHERE clauses.

CREATE INDEX idx_address_phone
ON address(phone);

-- Multicolumn Indexes
-- A multicolumn index is an index on more than one column, which is 
-- beneficial if your queries frequently filter by multiple columns

CREATE INDEX idx_customer_city 
ON customer(city, country);

-- Unique Indexes
-- A unique index ensures that all values in the index are unique.
-- It’s often used on columns that require unique values, like an email or username.

CREATE UNIQUE INDEX idx_email_unique
ON users(email);

-- Partial Indexes
-- Partial indexes include only rows that meet specific criteria, which is 
-- helpful for indexing frequently queried subsets of data.

CREATE INDEX idx_active_users
ON users(status)
WHERE status = 'active';

-- Querying a Phone Number Without an Index
SELECT * FROM address
WHERE phone = '223664661973';

EXPLAIN SELECT * FROM address
WHERE phone = '223664661973';

-- Creating an Index on the Phone Column
CREATE INDEX idx_address_phone
ON address(phone);

-- drop index
-- syntax
-- DROP INDEX [ CONCURRENTLY ] [ IF EXISTS ] index_name [ CASCADE | RESTRICT ];

DROP INDEX IF EXISTS idx_actor_first_name;


SELECT * FROM actor
WHERE first_name = 'John';

CREATE INDEX idx_actor_first_name 
ON actor (first_name);

SELECT * FROM actor
WHERE first_name = 'John';

DROP INDEX IF EXISTS idx_actor_first_name;

-- use DROP INDEX CONCURRENTLY to avoid blocking other transactions:
-- DROP INDEX CONCURRENTLY idx_actor_first_name;
-- This allows other SELECT, INSERT, UPDATE, and DELETE operations to continue while the index is being dropped.

-- list indexes
-- Using the pg_indexes view

/*
'pg_indexes' view consists of five columns:
'schemaname': stores the name of the schema that contains tables and indexes.
'tablename': stores name of the table to which the index belongs.
'indexname': stores name of the index.
'tablespace': stores name of the tablespace that contains indexes.
'indexdef': stores index definition command in the form of CREATE INDEX statement.
*/

SELECT tablename, indexname, indexdef 
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'customer';

-- Using the psql command
-- \d table_name;

-- unique index
-- a UNIQUE index is used to ensure that the values in one or more columns are unique across the rows in a table.
-- This is essential for maintaining data integrity and avoiding duplicate entries.

-- 
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    email VARCHAR(255) UNIQUE
);

SELECT 
    tablename, 
    indexname, 
    indexdef 
FROM 
    pg_indexes 
WHERE 
    tablename = 'employees';

ALTER TABLE employees
ADD mobile_phone VARCHAR(20);

CREATE UNIQUE INDEX idx_employees_mobile_phone
ON employees(mobile_phone);

INSERT INTO employees(first_name, last_name, email, mobile_phone)
VALUES ('Raju', 'kumar', 'raju.kumar@geeksforgeeks.org', '(408)-555-1234');

INSERT INTO employees(first_name, last_name, email, mobile_phone)
VALUES ('Nikhil', 'Aggarwal', 'nikhil.aggarwal@gfg.org', '(408)-555-1234');

-- Partial Index
-- partial indexes can significantly speed up queries that use common WHERE conditions with constant values.
-- A partial index is an index built over a subset of a table, defined by a condition in the WHERE clause. 
-- This targeted indexing approach is especially useful when you frequently query specific subsets of data, 
-- as it reduces the overhead of indexing and scanning irrelevant rows.

-- syntax:
-- select * 
-- from table_name
-- where column_name = constant_value;
SELECT * FROM customer;
-- finds all inactive customers.
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE active = 0;

EXPLAIN SELECT customer_id, first_name, last_name, email
FROM customer
WHERE active = 0;

CREATE INDEX idx_customer_active
ON customer(active);

CREATE INDEX idx_customer_inactive
ON customer(active)
WHERE active = 0;

EXPLAIN SELECT customer_id, first_name, last_name, email
FROM customer
WHERE active = 0;

-- Index On Expression
-- Indexes on expressions are special types of indexes in PostgreSQL that store the result of an expression rather than just the column values. 
-- useful when your queries involve expressions like functions, arithmetic operations, or transformations.
-- By indexing the result of an expression, PostgreSQL can quickly retrieve the relevant rows without recalculating the expression for each row during a query.

-- Syntax
-- CREATE INDEX index_name 
-- ON table_name (expression);


-- Without an Index on Expression
SELECT 
    customer_id, 
    first_name, 
    last_name 
FROM 
    customer 
WHERE 
    last_name = 'Purdy';

EXPLAIN SELECT 
    customer_id, 
    first_name, 
    last_name 
FROM 
    customer 
WHERE 
    last_name = 'Purdy';

-- With an Index on Expression
CREATE INDEX idx_ic_last_name
ON customer(LOWER(last_name));

EXPLAIN SELECT 
    customer_id, 
    first_name, 
    last_name 
FROM 
    customer 
WHERE 
    LOWER(last_name) = 'Purdy';

-- REINDEX
-- REINDEX statement is essential for recovering corrupted indexes, which can occur due to software bugs or hardware failures. 

-- Syntax
-- REINDEX [ ( VERBOSE ) ] { INDEX | TABLE | SCHEMA | DATABASE | SYSTEM } name;

REINDEX TABLE customer;
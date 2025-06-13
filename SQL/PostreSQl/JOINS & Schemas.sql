-- Joins
--  JOIN statement is a powerful tool for combining data or rows from one or more tables based on a common field between them.
-- These common fields are typically the primary key in the first table and the foreign key in the other table(s).
-- Different types of JOINs perform complex data retrieval operations and manage relationships between tables efficiently.
-- Each type of JOIN serves a unique purpose and is useful in specific situations:
/*
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL OUTER JOIN

-- PostgreSQL special JOINs:
NATURAL JOIN
CROSS JOIN
SELF JOIN
*/

CREATE TABLE zoo1(
    id INT PRIMARY KEY,
    animal VARCHAR(100) NOT NULL
);

CREATE TABLE zoo2 (
    id INT PRIMARY KEY,
    animal VARCHAR(100) NOT NULL
);

INSERT INTO zoo1 (id, animal)
VALUES
    (1, 'Lion'),
    (2, 'Tiger'),
    (3, 'Wolf'),
    (4, 'Fox');

INSERT INTO zoo2 (id, animal)
VALUES
    (1, 'Tiger'),
    (2, 'Lion'),
    (3, 'Rhino'),
    (4, 'Panther');

SELECT * FROM zoo1;
SELECT * FROM zoo2;


-- INNER JOIN -- 
-- An INNER JOIN returns rows with matching values in both tables.
-- useful when we want only records that exist in both tables.

SELECT 
    z1.id as zoo1_id,
    z1.animal as zoo1_animal,
    z2.id as zoo2_id,
    z2.animal as zoo2_animal
FROM zoo1 as z1
INNER JOIN zoo2 as z2 
ON z1.animal = z2.animal;

SELECT
    customer.customer_id,
    first_name,
    last_name,
    email,
    amount,
    payment_date
FROM
    customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
ORDER BY customer.customer_id;

SELECT
    customer.customer_id,
    first_name,
    last_name,
    email,
    max(payment_date) as last_payment_date,
    sum(amount) AS total_amount
FROM
    customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY customer.customer_id;

--- relationship between three tables: staff, payment, and customer
SELECT
    customer.customer_id AS customer_id,
    customer.first_name AS customer_first_name,
    customer.last_name AS customer_last_name,
    customer.email AS customer_email,
    staff.first_name AS staff_first_name,
    staff.last_name  AS staff_last_name,
    amount,
    payment_date
FROM
    customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
INNER JOIN staff ON payment.staff_id = staff.staff_id
ORDER BY customer.customer_id;

-- LEFT JOIN --
-- returns all records from the left table (zoo1) and matched records from the right table (zoo2).
-- If there’s no match, the columns from the right table contain NULL values. 

SELECT 
    z1.id as zoo1_id,
    z1.animal as zoo1_animal,
    z2.id as zoo2_id,
    z2.animal as zoo2_animal
FROM zoo1 as z1
LEFT JOIN zoo2 as z2 
ON z1.animal = z2.animal;

SELECT
    film.film_id,
    film.title,
    inventory_id
FROM
    film
LEFT JOIN inventory ON inventory.film_id = film.film_id;

SELECT
    film.film_id,
    film.title,
    inventory_id
FROM
    film
LEFT JOIN inventory ON inventory.film_id = film.film_id
WHERE
    inventory.film_id IS NULL;


-- RIGHT JOIN --
-- Opposite to the LEFT JOIN.
-- It returns a complete set of rows from the right table with the matching rows if available from the left table.
-- If there is no match, the left side will have null values. 

SELECT z1.id, z1.animal, z2.id, z2.animal
FROM zoo1 AS z1
RIGHT JOIN zoo2 AS z2
ON z1.animal = z2.animal;

SELECT title, name
FROM film AS f
RIGHT JOIN language AS l 
ON l.language_id = f.film_id
WHERE name IS NOT NULL;

-- FULL OUTER JOIN --
-- returns a result set that contains all rows from both the left and right tables,
-- with the matching rows from both sides where available.
-- If there is no match, the missing side contains null values.

SELECT z1.id, z1.animal, z2.id, z2.animal
FROM zoo1 AS z1
FULL OUTER JOIN zoo2 AS z2
ON z1.animal = z2.animal;

SELECT title, first_name, last_name
FROM film AS f
FULL OUTER JOIN actor AS a 
ON a.actor_id = f.film_id;

SELECT title, name
FROM film AS f
FULL OUTER JOIN language AS l 
ON l.language_id = f.film_id
WHERE name IS NOT NULL;
---- same as right joining

-- self join --
-- join a table to itself. It enables us to perform queries that require the comparison of rows within a single table.

SELECT
    f1.title AS Film_1,
    f2.title AS Film_2,
    f1.length AS Runtime
FROM film AS f1
INNER JOIN film AS f2 
ON f1.film_id != f2.film_id AND f1.length = f2.length;


--  Schema  --
-- A schema is a way of organizing database objects like tables, views, indexes, functions, and data types.
-- Each schema provides a way to group related objects together, making the database more organized and easier to manage.
-- example, we can use separate schemas for different application modules, like sales, inventory, and hr.
-- By default, PostgreSQL creates a schema named public in every new database.

-- Use Schemas 
--  Organizing Database Objects: Schemas help us logically group related tables and other objects.
--  This is useful when our database has multiple applications, each with its own set of tables.
--  Multiple Users: Schemas allow multiple users to work with the same database without conflicting with each other.
--  Users can create their objects in different schemas.
--  Namespace Management: Using schemas allows multiple objects with the same name to coexist in a database.
--  For example, you can have a staff table in both the sales and hr schemas.

-- Syntax To access an object within a schema,
--   schema_name.object_name

-- create schema
-- Syntax: CREATE SCHEMA [IF NOT EXISTS] schema_name;

CREATE SCHEMA IF NOT EXISTS marketing;

SELECT * FROM pg_catalog.pg_namespace;


-- Creating a Schema for a User:
-- CREATE SCHEMA [IF NOT EXISTS] AUTHORIZATION user_name;

CREATE USER Mathias WITH ENCRYPTED PASSWORD '@Mathias#';

CREATE SCHEMA AUTHORIZATION Mathias;

CREATE SCHEMA IF NOT EXISTS finance AUTHORIZATION Mathias;

SELECT * FROM pg_catalog.pg_namespace;

-- DROP SCHEMA
-- Syntax
-- DROP SCHEMA [IF EXISTS] schema_name [CASCADE | RESTRICT];
-- use CASCADE to delete schema and all of its objects, and in turn, all objects that depend on those objects.

DROP SCHEMA IF EXISTS marketing;

SELECT * FROM pg_catalog.pg_namespace;

DROP SCHEMA IF EXISTS Mathias, finance;

DROP SCHEMA marketing CASCADE;

-- ALTER SCHEMA
-- modify the definition of an existing schema.

-- Syntax
-- ALTER SCHEMA schema_name
-- ACTION xyz;

ALTER SCHEMA finance
RENAME to gfg;

SELECT * FROM pg_catalog.pg_namespace;

ALTER SCHEMA gfg 
OWNER to postgres;

-- If you rename a schema that is included in the database's search path, you’ll need to update the search path accordingly. 
-- Failure to do so may result in queries failing because they can no longer find the expected schema.


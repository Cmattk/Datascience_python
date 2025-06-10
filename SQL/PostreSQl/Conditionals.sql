-- CASE
-- allows you to perform conditional operations within your SQL queries.
-- It evaluates a list of conditions and returns a result when the first condition is met.
-- If no conditions are met, it returns the result specified in the ELSE clause.

-- General CASE Expression
-- Syntax:
/*
CASE 
      WHEN condition_1  THEN result_1
      WHEN condition_2  THEN result_2
      [WHEN ...]
      [ELSE result_n]
END
*/

SELECT 
    SUM(
        CASE
        WHEN rental_rate = 0.99 THEN 1
        ELSE 0
        END
    ) AS "Mass",
    SUM(
        CASE
        WHEN rental_rate = 2.99 THEN 1
        ELSE 0
        END
    ) AS "Economic",
    SUM(
        CASE
        WHEN rental_rate = 4.99 THEN 1
        ELSE 0
        END
    ) AS "Luxury"
FROM film;

-- Simple CASE Expression
/*
CASE expression
WHEN value_1 THEN result_1
WHEN value_2 THEN result_2 
[WHEN ...]
ELSE
    result_n
END
*/

SELECT 
    SUM (
        CASE rental_rate
        WHEN 0.99 THEN 1
        ELSE 0
        END
    ) AS "MASS",
    SUM (
        CASE rental_rate
            WHEN 2.99 THEN 1 
            ELSE  0
        END
     ) AS "Economic",
     SUM (
        CASE rental_rate
        WHEN 4.99 THEN 1
        ELSE 0
        END
      ) AS "Luxury"
FROM film;

/*
CASE expression uses logical operators (AND, OR) for more complex logic.
Can be nested within each other to handle more intricate conditions and outcomes.
PostgreSQL handles NULLs uniquely, and you might need to use functions like COALESCE or IS NULL in your CASE expressions.
Complex CASE expressions can lead to performance issues, especially on large datasets. It's essential to test and optimize queries using EXPLAIN and other performance tuning tools in PostgreSQL.
*/

-- COALESCE
-- returns the first non-null argument among its parameters, making it particularly useful in SELECT statements.
-- syntax: COALESCE (argument1, argument2);

-- COALESCE evaluates each argument in the order they are provided.
-- and returns the first one that is not NULL.
-- If all arguments are NULL, COALESCE will return NULL.
-- Once COALESCE finds a non-NULL value, it stops evaluating the remaining arguments.

CREATE TABLE items(
    id SERIAL PRIMARY KEY,
    product VARCHAR (100) NOT NULL,
    price NUMERIC NOT NULL,
    discount NUMERIC
);

INSERT INTO items (product, price, discount)
VALUES 
    ('A', 1000, 10),
    ('B', 1500, 20),
    ('C', 800, 5),
    ('D', 500, NULL);

SELECT 
    product, (price - discount) AS net_price
FROM items;

-- using coalesce
SELECT COALESCE (1,2);
SELECT COALESCE (NULL,2,1);

SELECT 
    product, (price - COALESCE(discount, 0)) AS net_price
FROM items;

-- NULLIF() Function
-- compares 2 expressions and returns NULL if they are equal, otherwise returns the first expression.
-- Useful for handling conditional nulls and avoiding divide-by-zero errors.
-- Syntax: NULLIF (argument_1, argument_2);
-- returns a null value if 'argument_1' equals 'argument_2', otherwise it returns 'argument_1'.

-- NULLIF is commonly used to replace empty strings ('') or other default values with NULL in SELECT statements.

CREATE TABLE posts (
    id serial primary key,
    title VARCHAR (255) NOT NULL,
    excerpt VARCHAR (150),
    body TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

INSERT INTO posts (title, excerpt, body)
VALUES
('test post 1','test post excerpt 1','test post body 1');
INSERT INTO posts (title, excerpt, body)
VALUES
('test post 2','','test post body 2');
INSERT INTO posts (title, excerpt, body)
VALUES
('test post 3', null ,'test post body 3');

SELECT ID, title, excerpt FROM posts;

-- query with coalesce only
-- if excerpt is null it uses 1st 30 characters of the body.
SELECT id, title, COALESCE(excerpt, LEFT(body, 30))
FROM posts;


-- Using NULLIF with COALESCE for Improved Handling
SELECT id, title, 
      COALESCE(NULLIF(excerpt,''),
      LEFT(body, 30))
FROM posts;

-- CAST
-- provides an efficient way to convert data types in postgressql
-- ensuring data is in the correct format for  storage, calculation, or comparisons.
-- This function is essential in situations where the data type of a value must match the requirements of an operation or a query.

-- syntax: CAST (expression AS target_type)

SELECT CAST ('100' AS INTEGER)l;
SELECT CAST ('10C' AS INT);
SELECT CAST ('2025-02-12' AS DATE);
SELECT CAST ('20-FEB-12' AS DATE);

SELECT 
   CAST('true' AS BOOLEAN),
   CAST('false' as BOOLEAN);

-- Cast operator (::)
-- (expression::target_type)
SELECT '100':: INT;







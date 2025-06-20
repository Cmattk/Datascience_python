- CREATE FUNCTION Statement
-- custom functions that can be reused throughout our database operations.
-- These functions can accept parameters, perform operations, and return values. 

/*
Syntax

CREATE [OR REPLACE] FUNCTION function_name(param_list)
RETURNS return_type
LANGUAGE plpgsql
AS
$$
DECLARE
-- variable declaration
BEGIN
 -- logic
END;
$$;
*/

/*
Function Name: Specify the name of the function after the CREATE FUNCTION keywords. Use OR REPLACE to update an existing function.
Parameter List: Provide the function parameters within parentheses. A function can have zero or many parameters.
Return Type: Specify the data type of the returned value after the RETURNS keyword.
Language: Indicate the procedural language of the function using LANGUAGE plpgsql. PostgreSQL supports several languages, but plpgsql is commonly used for its rich feature set.
Dollar-Quoted String: Use $$ to define the function body, containing the declaration and logic.
*/

-- creates a function that counts the films whose length between the 'len_from' and 'len_to' parameters:
CREATE OR REPLACE FUNCTION get_film_count(len_from INT, len_to INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    film_count INT;
BEGIN
    SELECT COUNT(*) INTO film_count
    FROM film
    WHERE length BETWEEN len_from AND len_to;

    RETURN film_count;
END;
$$;


SELECT get_film_count(40, 90);
SELECT get_film_count(len_from => 40, len_to => 90);
/*
Function Overloading: PostgreSQL supports function overloading, meaning we can create multiple functions with the same name but different parameter lists.
Immutable, Stable, Volatile: Functions can be marked as IMMUTABLE, STABLE, or VOLATILE. Immutable functions always return the same result given the same input. Stable functions return the same result within a single table scan, and volatile functions can return different results even within a single table scan. This helps the optimizer to plan queries more efficiently.
Security Features: By default, functions execute with the privileges of the user calling the function. We can use the SECURITY DEFINER clause to have the function execute with the privileges of the user who created the function.
*/

-- Function Parameter Modes
-- Parameters enable you to supply data to a function or procedure and receive data back, making your database interactions more efficient and versatile.

-- Formal Parameters: These are the parameters declared in the function or procedure definition. They define what kind of data the function or procedure will accept and return.
-- Actual Parameters: These are the actual values or variables the calling program passes when invoking the function or procedure.

-- A Parameter mode is used to decide the behavior of the parameters.

-- 1. IN mode
-- IN mode is used to pass a value to the function or procedure.
-- IN mode act like constants; they cannot be assigned a new value within the function or procedure.
-- If no mode is specified, PostgreSQL assumes the parameter is in IN mode.

-- 2. OUT Mode
-- OUT mode is used to return a value from the function or procedure.
-- OUT mode act like uninitialized variables that must be assigned a value during the function's execution.
-- useful for functions that need to return multiple values.

-- 3. INOUT MODE
-- INOUT mode is a combination of IN and OUT modes.
-- INOUT mode are initialized with a value passed by the caller and return a possibly modified value after the function's execution.

-- function is created to find the name of the employee along with its manager id given the employee id and its manager id. 
CREATE OR REPLACE FUNCTION get_stats(
    IN eid INT,
    OUT name VARCHAR,
    INOUT mid INT)
LANGUAGE plpgsql
AS $$
BEGIN 
    SELECT full_name, manager_id
    INTO name, mid
    FROM employees
    WHERE employee_id = eid AND manager_id = mid;
END; $$;

SELECT * FROM get_stats(2,1);

-- Counting Employees Using an OUT Parameter
CREATE OR REPLACE FUNCTION empcount(
    OUT ecount INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT count(*) INTO ecount 
    FROM employees;
END; $$;

SELECT * FROM empcount();

-- Swapping Values Using INOUT Parameters
CREATE OR REPLACE FUNCTION swapper(
    INOUT x int,
    INOUT y int)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT x, y INTO y, x;
END; $$;

SELECT * FROM swapper(198, 457);

-- Function Overloading
-- it's possible to create multiple functions with the same name, provided that each function has different arguments.

-- Basic Function to Get Rental Duration
CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER)
RETURNS INTEGER 
AS $$
DECLARE rental_duration INTEGER;
BEGIN
    -- get the rate based on film_id
    SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date - rental_date))
    FROM rental
    WHERE customer_id = p_customer_id;

    RETURN rental_duration;
END; $$
LANGUAGE plpgsql;

SELECT get_rental_duration(278);

CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER, p_from_date DATE)
    RETURNS INTEGER AS $$
DECLARE 
    rental_duration integer;
BEGIN
    -- get the rental duration based on customer_id and rental date
    SELECT INTO rental_duration
                SUM( EXTRACT( DAY FROM return_date + '12:00:00' - rental_date)) 
    FROM rental 
    WHERE customer_id= p_customer_id AND 
          rental_date >= p_from_date;
     
    RETURN rental_duration;
END; $$
LANGUAGE plpgsql;

SELECT get_rental_duration(278, '2005-07-01');

-- Function Returning A Table
-- allows us execute complex queries and return structured data efficiently.
-- allows users to encapsulate logic in a reusable manner while outputting a set of records.


-- functions to return films based on title pattern.
-- all films whose titles match a specific pattern using the ILIKE operator, which 
-- performs a case-insensitive search.

CREATE OR REPLACE FUNCTION get_film (p_pattern VARCHAR)
RETURNS TABLE(
    film_title VARCHAR,
    film_release_year INT
)
AS $$
BEGIN
RETURN QUERY 
SELECT
    title,
    CAST(release_year AS INTEGER)
FROM film
WHERE title ILIKE  p_pattern ;
END;
$$

LANGUAGE 'plpgsql';

-- get all films whose title starts with Al.
SELECT * FROM get_film('Al%');

-- create a function that accepts both a title pattern and a release year. 
-- enables users to easily find relevant films without knowing the exact title.

CREATE OR REPLACE FUNCTION get_film(p_pattern VARCHAR, p_year INT)
RETURNS TABLE (
    film_title VARCHAR,
    film_release_year INT
) AS $$
DECLARE
    var_r record; -- A temporary variable to hold each row returned from the query inside the loop.
BEGIN
    FOR var_r IN (
        SELECT title, release_year
        FROM film
        WHERE title ILIKE p_pattern AND release_year = p_year
    )
    LOOP
        film_title := upper(var_r.title) ; -- Converts the title to uppercase before returning it.
        film_release_year := var_r.release_year; -- 
        RETURN NEXT; -- Adds the current row to the result set.
    END LOOP;
END; $$ 
LANGUAGE 'plpgsql'; 

-- all films whose titles contain "er" and were released in 2006.
SELECT * FROM get_film ('%er', 2006);

--  RETURN QUERY command is essential when creating functions that return a set of results.
--  It allows us to execute a query and return its results directly without the need for looping

CREATE OR REPLACE FUNCTION get_film2(p_pattern VARCHAR, p_year INT DEFAULT NULL)
RETURNS TABLE (
    film_title VARCHAR,
    film_release_year INT
)
AS $$
    SELECT UPPER(title), release_year
    FROM film
    WHERE title ILIKE p_pattern
      AND (p_year IS NULL OR release_year = p_year);
$$ LANGUAGE sql;

SELECT * FROM get_film2('%er', 2006);


-- Drop Function
-- is essential for removing functions from your database. 

-- Syntax
-- DROP FUNCTION [IF EXISTS] function_name(argument_list)
-- [CASCADE | RESTRICT];

DROP FUNCTION get_film(p_pattern VARCHAR, p_year INT);

DROP FUNCTION get_film_actors(int) CASCADE;
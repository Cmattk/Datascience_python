-- AVG()
SELECT
    customer.customer_id,
    first_name,
    last_name,
    to_char(
        AVG (amount),
        '99999999999999999D99'
    ) AS average_amount
FROM
    payment
INNER JOIN customer ON customer.customer_id = payment.customer_id
GROUP BY
    customer.customer_id
ORDER BY
    customer_id;

-- COUNT() Function
SELECT
    customer_id,
    COUNT (customer_id)
FROM
    payment
GROUP BY
    customer_id
HAVING
    COUNT (customer_id) > 40;

-- MAX() Function
SELECT
    customer_id,
    MAX (amount)
FROM
    payment
GROUP BY
    customer_id;

-- min ()
SELECT
    customer_id,
    MIN (amount)
FROM
    payment
GROUP BY
    customer_id;

-- SUM() Function
SELECT
    customer_id,
    SUM (amount) AS total
FROM
    payment
GROUP BY
    customer_id;

-- FIRST_VALUE Function
-- is a window function that retrieves the first value within an ordered set of rows, often within a specific partition. 
-- highly useful for data analysis and reporting by allowing targeted access to specific data points.

--  Syntax
--  FIRST_VALUE ( expression )  
--  OVER ( 
--    [PARTITION BY partition_expression, ... ]
--    ORDER BY sort_expression [ASC | DESC], ...
--  )

--  use the FIRST_VALUE() function to retrieve the mammal with the lowest lifespan.

CREATE TABLE Animal_groups(
    animal_id SERIAL PRIMARY KEY,
    animal_name VARCHAR (255) NOT NULL
);

CREATE TABLE Mammals(
    mammal_id SERIAL PRIMARY KEY,
    mammal_name VARCHAR (255) NOT NULL,
    lifespan DECIMAL (11, 2),
    animal_id INT NOT NULL,
    constraint animal_id_fk FOREIGN KEY (animal_id) REFERENCES Animal_groups(animal_id)
);

INSERT INTO Animal_groups(animal_name)
VALUES 
    ('Terrestrial'),
    ('Aquatic'),
    ('Winged');

INSERT INTO Mammals(mammal_name, animal_id, lifespan)
VALUES
    ('Cow', 1, 10),
    ('Dog', 1, 7),
    ('Ox', 1, 13),
    ('Wolf', 1, 11),
    ('Blue Whale', 2, 80),
    ('Dolphin', 2, 5),
    ('Sea Horse', 2, 3),
    ('Octopus', 2, 8),
    ('Bat', 3, 4),
    ('Flying Squirrels', 3, 1),
    ('Petaurus', 3, 2);

---  FIRST_VALUE() ---
SELECT 
    mammal_id, mammal_name, lifespan,
    FIRST_VALUE(mammal_name)
    OVER(
        ORDER BY lifespan
    ) as lowest_lifespan
FROM Mammals;

-- uses the FIRST_VALUE() function to return all mammals grouped by the animal group.
-- And for each animal group, it returns the mammal with the lowest lifespan.

SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    FIRST_VALUE(mammal_name)
    OVER(
        PARTITION BY animal_id
        ORDER BY lifespan
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as lowest_lifespan
FROM
Mammals;

/*
If multiple rows have the same value for the ORDER BY expression, the FIRST_VALUE() function returns the first row it encounters based on the order of the rows in the table.
The 'rows_range_clause' (e.g., ROWS BETWEEN or RANGE BETWEEN) can limit the number of rows considered within each partition. However, for FIRST_VALUE(), specifying the frame is generally not necessary unless combined with other window functions that require precise row control.
The ordering of rows within partitions directly affects the result of FIRST_VALUE(). Ensure the ORDER BY clause accurately reflects the desired sorting to get meaningful results.
NULL values affect FIRST_VALUE() results, as they are sorted last in ascending order and first in descending order. Use NULLS FIRST or NULLS LAST in the ORDER BY clause for precise control.
*/

-- LAST_VALUE Function
-- is a powerful window function used to retrieve the last value within a specified window frame of a query result set.
-- It is particularly beneficial for performing advanced data analysis and retrieving the final value in ordered partitions.

-- Retrieving the Mammal with the Longest Lifespan

SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    LAST_VALUE(mammal_name) 
    OVER(
        ORDER BY lifespan
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) longest_lifespan
FROM 
    Mammals;

-- Finding the Longest-Lived Mammal per Animal Group

SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    LAST_VALUE(mammal_name) 
    OVER(
        PARTITION BY animal_id
        ORDER BY lifespan
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) longest_lifespan
FROM 
    Mammals;

--  NTH_VALUE Function
-- allows us to retrieve the value from the nth row in an ordered set within a specified window.

--  Syntax
/*
NTH_VALUE(expression, offset) 
OVER (
    [ PARTITION BY partition_expression]
    [ ORDER BY sort_expression [ASC | DESC]
    frame_clause ]
)
*/

--  Mammal with the 2nd shortest Lifespan
SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    NTH_VALUE(mammal_name, 2)
    OVER(
        ORDER BY lifespan
        RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) as second_shortest_lifespan
FROM Mammals;

--  Mammal with the 2nd shortest Lifespan per group
SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    NTH_VALUE(mammal_name, 2)
    OVER(
        PARTITION BY animal_id
        ORDER BY lifespan
        RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING
    ) as second_shortest_lifespan
FROM Mammals;

--  Mammal with the 2nd Longest Lifespan
SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    NTH_VALUE(mammal_name, 2) 
        OVER (
            ORDER BY lifespan DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS second_longest_lifespan
FROM Mammals;

--  Mammal with the 3rd Longest Lifespan per group
SELECT 
    mammal_id,
    mammal_name,
    lifespan,
    NTH_VALUE(mammal_name, 3) 
        OVER (
            PARTITION BY animal_id
            ORDER BY lifespan DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS third_longest_lifespan
FROM Mammals;


-- ROW_NUMBER FUNCTION
-- is a crucial part of window functions
-- enabling users to assign unique sequential integers to rows within a dataset. 
-- This function is invaluable for tasks such as ranking, pagination and identifying duplicates.

-- SYNTAX:
-- ROW_NUMBER() OVER ([PARTIOTION BY partion_expression] ORDER BY order_expression)

--  Use ROW_NUMBER()
-- Pagination: help in retrieving a specific range of records.
-- Ranking: assign ranks to rows based on specific criteria.
-- Removing Duplicates: It can help identify duplicates by numbering rows within groups

SELECT 
    *,
    ROW_NUMBER() OVER (
        ORDER BY manager_id
    ) AS row_num
FROM employees;

-- ROW_NUMBER() with PARTITION BY Clause
SELECT 
    *,
    ROW_NUMBER() OVER (
        PARTITION BY manager_id
        ORDER BY employee_id
    ) AS row_num
FROM employees;

-- Combining ROW_NUMBER() with Common Table Expressions (CTE)
WITH rankedemployees as (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY manager_id
            ORDER BY full_name
        ) AS row_num
    FROM employees
)
SELECT * FROM rankedemployees
WHERE row_num = 1;

-- - CURRENT_DATE Function
-- used to retrieve the current date. It’s a simple and 
-- effective way to ensure your database operations are using the correct date, 
-- particularly for applications that need timestamp records.

-- syntax: current_date

SELECT CURRENT_DATE;

CREATE TABLE delivery(
    delivery_id SERIAL PRIMARY KEY,
    product VARCHAR(255) NOT NULL,
    delivery_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO delivery(product)
VALUES ('PS5 Slim Console');

SELECT * FROM delivery;

-- CURRENT_TIME FUNCTION
-- returns the current time and the current time zone
-- This function is handy when you need to work with time-sensitive data in your database applications.

-- syntax: CURRENT_TIME(precision)
-- precision argument sets the precision of the returned 'TIME' type value in fractional seconds.

SELECT CURRENT_TIME;
SELECT CURRENT_TIME(2);

CREATE TABLE log (
    log_id SERIAL PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at TIME DEFAULT CURRENT_TIME,
    created_on DATE DEFAULT CURRENT_DATE
);

INSERT INTO log( message )
VALUES('Testing the CURRENT_TIME function');

SELECT * FROM log;

-- We can get similar output by using by Postgresql NOW function.
SELECT NOW();



-- EXTRACT Function
-- EXTRACT() function is a powerful tool used to retrieve specific components of a date or time value. 

-- Syntax
-- EXTRACT(field FROM source)

/*
field: Specifies the date or time component you want to extract. This can be a year, month, day, quarter, or other temporal field.
source: The date or time value from which the field is extracted. This can be of type TIMESTAMP, DATE, or INTERVAL.
*/

-- Extracting the Year
SELECT extract(YEAR FROM timestamp '2020-12-31 13:30:15');
SELECT EXTRACT(MONTH FROM TIMESTAMP '2020-12-31 13:30:15');
SELECT EXTRACT(DAY FROM TIMESTAMP '2020-12-31 13:30:15');
SELECT EXTRACT(HOUR FROM TIMESTAMP '2020-12-31 13:30:15');

-- CONCAT Function
-- allows us to combine multiple strings or column values into a single output, 
-- making it a flexible tool for data manipulation.

-- Syntax: CONCAT(string_1, string_2, ...)

SELECT concat('one', '4', 'dev');

SELECT 
    actor_id, 
    UPPER(CONCAT(first_name, ' ', last_name)) as full_name,
    last_update
FROM actor limit 10;

-- NULL values (e.g., missing phone numbers) are ignored, making the CONCAT function useful for avoiding unexpected NULL results in concatenated strings.
-- The CONCAT function can be easily combined with other PostgreSQL functions like UPPER(), LOWER(), TRIM(), and more to perform complex string manipulations.



--- FORMAT FUNCTION  ---
--  is a powerful tool for string formatting by allowing developers to insert variables into strings using format specifiers like %s, %I, and %L.
--  This function is especially useful for building dynamic SQL queries and ensuring proper formatting of identifiers.

-- The format() function in PostgreSQL is used to format strings in a way similar to the printf() function in C.
-- It allows placeholders (like %s, %I, or %L) to be replaced with variable values.
-- useful in dynamically generating SQL statements, user-friendly messages or customized data outputs in queries.

-- Syntax --
-- format(format_string [, format_arg [, ... ]])
-- format_string: The string containing the format specifiers.
-- format_arg: The arguments to replace the format specifiers.

/*
The format() function supports various format specifiers to handle different data types:
Specifier	Description
%s	    Replaces with a string.
%I	    Replaces with an identifier (table or column name).
%L	    Replaces with a literal (safely quoted).
%t	    Replaces with a Boolean.
%D	    Replaces with a numeric, double-precision number.
*/

-- Example 1: Simple String Formatting.
SELECT FORMAT('Hello, %s', 'Lads!!');

SELECT 
    actor_id, 
    UPPER(FORMAT('%s %s', first_name, last_name)) as full_name,
    last_update
FROM actor limit 10;

-- UPPER FUNCTION
-- is utilized to convert a string into uppercase.

SELECT
    FORMAT ('%s %s',
        UPPER (first_name),
        UPPER (last_name)
    ) AS full_name
FROM
    staff;

SELECT UPPER('geeksforgeeks');


-- LOWER Function
-- used to convert strings, expressions, or values in a column to lowercase.

SELECT LOWER(title) FROM film;
SELECT LOWER('GEEKSFORGEEKS');
-- useful for making case-insensitive comparisons.
-- Use the CAST function to convert non-string values to strings if necessary.
-- Applicable to strings, expressions, and column values.


---  - REGEXP_MATCHES Function ---
-- It returns substrings that satisfy the pattern, making it indispensable for string manipulation, pattern matching, and data extraction tasks.
-- useful for tasks that require advanced text processing such as extracting, analyzing, or validating data based on specific patterns.

-- Syntax
-- REGEXP_MATCHES(source_string, pattern [, flags])

-- source_string: The string from which the regular expression will match and return the substrings.
-- pattern: A POSIX regular expression used to match against the source string.
-- flags (optional): Flags that modify the matching behavior. For example, 'g' (global) allows for multiple matches within the source string.

SELECT REGEXP_MATCHES('Learning #G4Gs #geekpower', '#([A-Za-z0-9_]+)','g');
SELECT REGEXP_MATCHES('ABC', '^(A)(..)$', 'g');
-- ideal for tasks like pattern recognition, text mining, and data cleaning

-- - REGEXP_REPLACE Function
--  a powerful text manipulation tool, designed to replace specific substrings within a string based on regular expression patterns. 

/*
Using REGEXP_REPLACE() can save time and simplify tasks when dealing with:

Data standardization (e.g., transforming name formats)
Data cleansing (e.g., removing unwanted characters or digits)
Complex text replacements that depend on dynamic patterns.

Syntax
REGEXP_REPLACE(source, pattern, replacement_string, [, flags])
*/

-- Rearranging Name Format
SELECT regexp_replace('Matt CK', '(.*) (.*)', '\2 \1');

-- Removing Alphabets from String
SELECT REGEXP_REPLACE('ABC12345xyz', '[[:alpha:]]', '', 'g');
-- [[:alpha:]] to match any alphabetic character (A-Z, a-z)
-- global flag 'g' ensures that all alphabetic characters are removed from the string.

-- Use of POSIX character classes ('[:alpha:]', '[:digit:]', etc.) and non-greedy matching (.*?, .+?) can provide more precise control over pattern matching behavior.

-- REPLACE() Function -- 
-- allows developers and database administrators to manipulate strings efficiently.

-- Syntax: REPLACE(source, from_text, to_text);
--  Replacing Substrings in a URL
SELECT REPLACE('Hello World', 'World', 'Kenya') as replaced_string;
SELECT REPLACE('Data Science is fun!', 'fun', 'awesome') AS replaced_string;

-- Updating Table Data with REPLACE()
CREATE TABLE posts(
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
);

INSERT INTO posts(title, url)
VALUES 
('PostgreSQL Tutorial', 'http://www.postgresqltutorial.com'), 
('PL/pgSQL', 'http://www.postgresqltutorial.com/postgresql-plpgsql/'),
('PostgreSQL Administration', 'http://www.postgresqltutorial.com/postgresql-administration/');

SELECT * FROM posts;

UPDATE posts
SET url = REPLACE(url, 'http', 'https');

-- Dollar-Quoted String Constants
-- Syntax: $tag$<string_constant>$tag$
SELECT $$
    This is a 'string' with "quotes" and a \backslash.
    $$;

DO $$
DECLARE
    film_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO film_count FROM film;
    RAISE NOTICE 'The total number of films: %', film_count;
END;
$$;


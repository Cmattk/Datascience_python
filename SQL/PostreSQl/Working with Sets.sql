-- UNION operator
-- is a powerful tool used to combine result sets from multiple queries into a single result set
-- It helps in consolidating data from different sources, making it easier to analyze and report.

-- syntax:
/*
SELECT
    column_1,
    column_2
FROM
    table_name_1
UNION
SELECT
    column_1,
    column_2
FROM
    table_name_2;    
*/

-- Both queries must return the same number of columns.
-- The corresponding columns in the queries must have compatible data types.
-- The UNION operator removes all duplicate rows from the query set.  

CREATE TABLE sales2024q1(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    amount VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE sales2024q2(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    amount VARCHAR(50),
    PRIMARY KEY (id)
);

INSERT INTO sales2024q1(name, amount)
VALUES
    ('Raju Kumar', '121232'),
    ('Nikhil Aggarwal', '254789'),
    ('Abhishek Kelenia', '365487');

INSERT INTO sales2024q2(name, amount)
VALUES
    ('Raju Kumar', '457264'),
    ('Nikhil Aggarwal', '365241'),
    ('Abhishek Kelenia', '759864');

-- Combining Data from 2 tables
SELECT * FROM sales2024q1
UNION
SELECT * FROM sales2024q2;

-- Sorting the Combined Results
SELECT * FROM sales2024q1
UNION
SELECT * FROM sales2024q2
ORDER BY 
    name ASC, 
    amount DESC
;

-- INTERSECT Operator --
-- is used to combine two or more result sets returned by SELECT statements and return the common data among the tables into a single result set.
-- This is useful for identifying overlapping data between tables.

-- syntax:
/*
SELECT
    column_list
FROM A
INTERSECT
SELECT
    column_list
FROM B;
*/

-- Column Consistency: The number of columns and their order in the SELECT clauses must be the same. 
-- Data Type Compatibility: The data types of the columns must be compatible.

CREATE TABLE agent(
    agent_id serial PRIMARY KEY,
    agent_name VARCHAR (255) NOT NULL
);

CREATE TABLE op_CHI(
    agent_id INT PRIMARY KEY,
    active_date DATE NOT NULL,
    FOREIGN KEY (agent_id) REFERENCES agent (agent_id)
);
CREATE TABLE op_PAk(
    agent_id INT PRIMARY KEY,
    active_date DATE NOT NULL,
    FOREIGN KEY (agent_id) REFERENCES agent (agent_id)
);

INSERT INTO agent(agent_name)
VALUES
    ('Tiger'),
    ('James Bond'),
    ('Jason Bourne'),
    ('Ethan Hunt'),
    ('Pathan'),
    ('Rowdy Rathore'),
    ('Milkha Singh'),
    ('Tom Hanks'),
    ('Shaban'),
    ('Razia Sultan');

INSERT INTO op_chi
VALUES
    (1, '2000-02-01'),
    (2, '2001-06-01'),
    (5, '2002-01-01'),
    (7, '2005-06-01');

INSERT INTO op_pak
VALUES
    (9, '2000-01-01'),
    (2, '2002-06-01'),
    (5, '2006-06-01'),
    (10, '2005-06-01');

-- Agents Active in Both China and Pakistan
SELECT agent_id FROM op_CHI
INTERSECT
SELECT agent_id FROM op_PAK;

-- 
SELECT agent_id FROM op_CHI
INTERSECT
SELECT agent_id FROM op_PAK
ORDER BY agent_id;

-- EXCEPT Operator -- 
-- The EXCEPT operator is a powerful tool used to return distinct rows from the first query that are not present in the output of the second query.
-- This operator is useful when you need to compare result sets of two or more queries and find the differences.

-- Finding Films Not in Inventory
SELECT film_id, title FROM film
EXCEPT
    SELECT 
        DISTINCT inventory.film_id, 
        title 
    FROM inventory
    INNER JOIN film ON film.film_id = inventory.film_id
ORDER BY title;

-- Finding Films Only in English
SELECT
    language_id,
    title
FROM
    film
WHERE
        language_id = 1
EXCEPT
    SELECT
        DISTINCT language.language_id,
        name
    FROM
        language
    INNER JOIN film ON film.language_id = language.language_id
ORDER BY title;
-- The EXCEPT operator is case-sensitive. Rows with the same values but different cases (e.g., "ABC" vs. "abc") are considered different.
-- The EXCEPT operator can be combined with other set operators like 'UNION' and 'INTERSECT' to perform complex data retrieval operations.
-- The columns being compared in the EXCEPT queries must have compatible data types. Mismatched data types will result in an error.


--  GROUPING SETS --
-- feature allows users to generate result sets that are equivalent to those produced by the UNION ALL of multiple GROUP BY clauses. 
-- This feature is highly useful for creating complex reports with multiple levels of aggregation in a single query.
-- A grouping set is essentially a set of columns by which you want to group your data. 

-- syntax:
/*
SELECT column1, column2, aggregate_function(column3)
FROM table_name
GROUP BY
    GROUPING SETS (
        (column1, column2),
        (column1),
        (column2),
        ()
);
*/

CREATE TABLE geeksforgeeks_courses(
    course_name VARCHAR NOT NULL,
    segment VARCHAR NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (course_name, segment)
);

INSERT INTO geeksforgeeks_courses(course_name, segment, quantity)
VALUES
    ('Data Structure in Python', 'Premium', 100),
    ('Algorithm Design in Python', 'Basic', 200),
    ('Data Structure in Java', 'Premium', 100),
    ('Algorithm Design in Java', 'Basic', 300);

-- Grouping by Course Name and Segment
-- It returns the number of products sold by brand and segment. 
SELECT
    course_name,
    segment,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    course_name,
    segment;

--  Grouping by Course Name
SELECT
    course_name,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    course_name;

-- Grouping by Segment
SELECT
    segment,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    segment;

-- Multiple Grouping Sets in a Single Query
SELECT
    GROUPING(course_name) as grouping_course,
    GROUPING(segment) AS grouping_segment,
    course_name,
    segment,
    SUM (quantity)
FROM geeksforgeeks_courses
GROUP BY
    GROUPING SETS(
        (course_name, segment),
        (course_name),
        (segment),
        ()
    )
ORDER BY course_name, segment;

-- cube --
-- CUBE extension of the GROUP BY clause is invaluable for multi-dimensional aggregation.
--  allows analysts and developers to easily perform in-depth analyses of data from multiple perspectives.
--  used in SQL queries to generate multiple grouping sets simultaneously.
-- useful in scenarios where one needs to analyze the data across several dimensions without running multiple queries.

-- Syntax
/*
SELECT
    column1,
    column2,
    column3,
    aggregate (column4)
FROM
    table_name
GROUP BY
    CUBE (column1, column2, column3);
*/

SELECT
    course_name,
    segment,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    CUBE(course_name, segment)
ORDER BY course_name, segment;

SELECT
    course_name,
    segment,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    course_name,
    CUBE (segment)
ORDER BY
    course_name,
    segment;

-- ROLLUP --
-- ROLLUP clause is a powerful extension to the GROUP BY clause, providing a shortcut for defining multiple grouping sets.
-- used to create subtotals and grand totals in the result set.
-- It assumes a hierarchical relationship between the columns and generates only those grouping sets that make sense within that hierarchy.

/*
Syntax

SELECT
    column1,
    column2,
    column3,
    aggregate(column4)
FROM
    table_name
GROUP BY
    ROLLUP (column1, column2, column3);
*/

SELECT
    course_name,
    segment,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    ROLLUP (course_name, segment)
ORDER BY
    course_name,
    segment;

SELECT
    segment,
    course_name,
    SUM (quantity)
FROM
    geeksforgeeks_courses
GROUP BY
    segment,
    ROLLUP (course_name)
ORDER BY
    segment,
    course_name;



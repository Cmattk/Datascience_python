-- ANY Operator
-- is a powerful tool for comparing a scalar value against a set of values returned by a subquery.
-- The ANY operator returns true if any value of the subquery meets the condition, otherwise, it returns false.

-- Finding Films with Maximum Length by Category
SELECT title FROM film
WHERE length >= ANY(
    SELECT MAX(length)
    FROM film
    INNER JOIN film_category USING (film_id)
    GROUP BY category_id
 );

SELECT
    title,
    category_id
FROM
    film
INNER JOIN film_category
    USING (film_id)
WHERE category_id = ANY (
    SELECT category_id 
    FROM category
    WHERE NAME = 'Action' OR NAME = 'Drama'
);

-- ALL Operator --
-- is a powerful tool for comparing a value with a list of values returned by a subquery.
-- This operator is essential for filtering and querying data based on comparisons with multiple values,

-- Querying Films Longer Than Average Lengths
SELECT
    film_id,
    title,
    length
FROM
    film
WHERE
    length > ALL (
        SELECT round(AVG(length), 2)
        FROM film
        GROUP BY rating
    )
ORDER BY length;

-- Querying Films with Lower Rental Rates Than Average
SELECT
    film_id,
    title,
    rental_rate
FROM
    film
WHERE
    rental_rate < ALL (
            SELECT
                ROUND(AVG (rental_rate), 2)
            FROM
                film
            GROUP BY
                rating
    )
ORDER BY
    rental_rate;

--  - EXISTS Operator
-- used to check the existence of rows in a subquery.
-- useful when working with correlated subqueries, where the inner query depends on values from the outer query.
-- The EXISTS operator returns true if the subquery returns at least one row otherwise it return false.

--  Finding Customers with Payments Over 9 USD
SELECT first_name, last_name
FROM customer AS c
WHERE EXISTS(
    SELECT 1 FROM payment as p
    WHERE p.customer_id = c.customer_id AND
    amount > 9    
)
ORDER BY first_name, last_name;

-- Finding Films Not Available in Inventory
 SELECT * FROM inventory;

SELECT title FROM film f 
WHERE NOT EXISTS(
    SELECT 1 FROM inventory i
    WHERE f.film_id = i.film_id
 ) 
ORDER BY title;

-- Common Table Expression (CTE)
-- are a powerful feature that allows us to define temporary result sets that can be referenced within other SQL statements. 
-- This includes statements like SELECT, INSERT, UPDATE, or DELETE.
-- CTEs make complex queries more readable and maintainable by breaking them into modular, reusable subqueries.

-- Syntax

-- WITH cte_name (column_list) AS (
--     CTE_query_definition
-- )
-- statement;

-- Categorizing Films by Length
WITH cte_film AS (
    SELECT 
        film_id, 
        title,
        (CASE 
            WHEN length < 30 THEN 'Short'
            WHEN length < 90 THEN 'Medium'
            ELSE 'Long'
        END) as length    
    FROM
        film
)
SELECT
    film_id,
    title,
    length
FROM 
    cte_film
WHERE
    length = 'Long'
ORDER BY 
    title;

-- Ranking Films by Length Using the RANK() Function

WITH cte_film AS (
    SELECT film_id, title, rating, length,
    RANK() OVER(
        PARTITION BY rating 
        ORDER BY length DESC 
    ) as length_rank
    FROM film
)
SELECT * FROM cte_film ;



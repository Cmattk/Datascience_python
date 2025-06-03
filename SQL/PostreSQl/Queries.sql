-- select statement
SELECT first_name, last_name FROM actor;

SELECT film_id, title, rating FROM film limit 20;

select customer_id, amount, payment_date
from payment
ORDER BY amount DESC;

-- distinct
SELECT DISTINCT rating from film;

SELECT DISTINCT first_name from customer;

SELECT DISTINCT rental_rate FROM film;

-- order by 
SELECT
    first_name,
    last_name
FROM
    customer
ORDER BY 
    first_name desc;

SELECT
    first_name,
    last_name
FROM
    customer
ORDER BY
    first_name ASC,
    last_name DESC;

SELECT first_name, LENGTH(first_name) as len
FROM customer
ORDER BY LENGTH(first_name) DESC;

-- WHERE clause
SELECT last_name, first_name
FROM customer
WHERE first_name = 'Kelly';

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    last_name = 'Cooper' OR
    first_name = 'Jo';

SELECT
    first_name,
    last_name
FROM
    customer
WHERE 
    first_name IN ('Kelly', 'Jo', ' Alexander');

-- like

select first_name, length(first_name) as len 
from customer
where 
    first_name like 'K%' AND
    length(first_name) between 3 and 7
order by len;

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name LIKE '_her%';

    SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '%er%';

SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ILIKE 'bar%';

SELECT
  message
FROM
  t
WHERE
  message LIKE '%10$%%' ESCAPE '$';
-- fetch
SELECT
    film_id,
    title 
FROM film
ORDER BY title 
FETCH FIRST 10 ROW ONLY;

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
OFFSET 5 ROWS
fetch first 10 row only;

-- NOT LIKE
SELECT
    first_name,
        last_name
FROM
    customer
WHERE
    first_name NOT LIKE 'K%';

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    first_name NOT LIKE '_her%';

-- IS NULL
SELECT
      first_name,
      last_name
FROM
      customer
WHERE
      email IS NULL;

SELECT
      title
FROM
      film
WHERE
      release_year IS NULL;

-- HAVING

SELECT
    customer_id,
    SUM (amount)
FROM
    payment
GROUP BY
    customer_id
HAVING
    SUM (amount) > 200;

SELECT
    store_id,
    COUNT (customer_id)
FROM
    customer
GROUP BY
    store_id
HAVING
    COUNT (customer_id) > 200;

-- BETWEEN
SELECT
    customer_id,
    payment_id,
    amount
FROM
    payment
WHERE
    amount BETWEEN 3 AND 5;

SELECT
    customer_id,
    payment_id,
    amount,
 payment_date
FROM
    payment
WHERE
    payment_date BETWEEN '2007-02-07' AND '2007-02-15';

-- GROUP BY
SELECT
    customer_id,
    SUM (amount) 
FROM
    payment
GROUP BY
    customer_id;

SELECT
    staff_id,
    COUNT (payment_id)
FROM
    payment
GROUP BY
    staff_id;
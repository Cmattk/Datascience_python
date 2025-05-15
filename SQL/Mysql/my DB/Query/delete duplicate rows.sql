CREATE TABLE custo (
    customer_id INT,
    customer_name VARCHAR(255),
    email VARCHAR(255)
);
INSERT INTO custo (customer_id, customer_name, email)
VALUES
    (1, 'John Doe', 'john.doe@example.com'),
    (2, 'Jane Doe', 'jane.doe@example.com'),
    (3, 'Muzamil Amin', 'Muzamilaminitoo@gmail.com'),
    (1, 'John Doe', 'john.doe@example.com'), 
    (4, 'Alice Johnson', 'alice.johnson@example.com'),
    (2, 'Jane Doe', 'jane.doe@example.com');

--- Remove Duplicate Rows from Table
WITH CTE AS (
    SELECT customer_id,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS row_num 
       FROM custo       
)
DELETE FROM custo
WHERE customer_id IN (
    SELECT customer_id FROM CTE WHERE row_num > 1
);

--- Remove Duplicate Rows Using the DISTINCT
SELECT DISTINCT customer_id FROM custo;

--- Remove Duplicate Rows Using the GROUP BY
SELECT customer_id FROM custo GROUP BY customer_id;

--- Remove Duplicate Rows Using the HAVING Clause
SELECT customer_id
FROM custo
GROUP BY customer_id
HAVING COUNT(*) > 1;

select * from custo;
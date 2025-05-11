use database myrestaurant;

CREATE TABLE old_table (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO old_table (id, name) VALUES (1, 'John'), (2, 'Alice'), (3, 'Bob');

RENAME TABLE old_table TO new_table;

SELECT * FROM new_table;

DROP table new_table;

-- RENAME Multiple Tables

CREATE TABLE old_table1 (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE old_table2 (
    id INT PRIMARY KEY,
    description TEXT
);

INSERT INTO old_table1 (id, name) VALUES (1, 'John'), (2, 'Alice');
INSERT INTO old_table2 (id, description) VALUES (1, 'Description 1'), (2, 'Description 2');

RENAME TABLE old_table1 TO new_table1, old_table2 TO new_table2;

SELECT * FROM new_table1;
SELECT * FROM new_table2;

-- Create a temporary table

CREATE temporary TABLE temp_table (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO temp_table(id,name) VALUES (1,'John'),(2,'Alice');

ALTER TABLE temp_table RENAME TO new_temp_table;

SELECT * FROM new_temp_table;

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS new_table1, new_table2;
SET foreign_key_checks = 1;


use database myrestaurant;

-- Temporary Table

CREATE TEMPORARY TABLE temp_sales (
    sale_id INT,
    product_id INT,
    sale_amount DECIMAL(10, 2)
);

INSERT INTO temp_sales (sale_id, product_id, sale_amount) VALUES
(1, 101, 150.00),
(2, 102, 200.00),
(3, 101, 250.00),
(4, 103, 300.00);

SELECT SUM(sale_amount) AS total_sales
FROM temp_sales;

-- Temporary Table Whose Structure is Based on a Normal Table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(1, 1, '2024-06-30', 150.00),
(2, 2, '2024-06-30', 200.00),
(3, 1, '2024-07-01', 250.00);

CREATE TEMPORARY TABLE temp_orders LIKE orders;

INSERT INTO temp_orders (order_id, customer_id, order_date, amount) VALUES
(4, 1, '2024-07-02', 300.00),
(5, 2, '2024-07-02', 400.00);

SELECT * FROM temp_orders;

DROP TEMPORARY TABLE IF EXISTS temp_table_name;
DROP TEMPORARY TABLE IF EXISTS temp_orders;

DROP table if exists orders;
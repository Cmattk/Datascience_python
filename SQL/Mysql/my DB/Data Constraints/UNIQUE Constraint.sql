-- UNIQUE Constraint
-- ensures that all values in a column or set of columns are distinct from one another.
-- it prevents duplicate of entries in  columns maintaining data integrity.

-- A unique constraint can contain null values  as long as the combination of values is unique.
-- It's different from a primary key since it allows null values.

-- it can be used in columns containing: 
--- email addresses, ID numbers, or product codes to ensure data integrity.

--- syntax---

---- CREATE TABLE table_name (
----  column_name data_type UNIQUE,
----  ...
---- );

-- CREATE TABLE table_name (
--   column_name1 data_type,
--   column_name2 data_type,
--   ...
--  UNIQUE (column_name1, column_name2)
-- );

-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name UNIQUE (column_name);

CREATE TABLE IF NOT EXISTS products (
    product_id int auto_increment primary key,
    product_code varchar(20) UNIQUE,
    product_name varchar(100),
    price decimal(10,2)
);

-- Drop unique constraint
-- drop index removes the unique constraint from product_code column
ALTER TABLE products
DROP  INDEX product_code;

-- ADD unique constraint

ALTER TABLE products
ADD CONSTRAINT unique_product_code UNIQUE (product_code);







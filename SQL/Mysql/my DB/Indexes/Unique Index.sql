-- Unique Index
-- a unique index is a crucial tool for ensuring that values in a specific column or a group of columns within a table are unique.

-- Creating the products table with a single-column unique index
CREATE TABLE products (
    product_Id INT PRIMARY KEY,
    product_name VARCHAR(50),
    UNIQUE (product_Id)
);

-- Inserting values into the products table
INSERT INTO products (product_Id, product_name) VALUES
(101, 'Computer'),
(102, 'Smartphone'),
(103, 'Headphones');

-- Creating the books table with a multi-column unique index
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title_name VARCHAR(100),
    author_name  VARCHAR(50),
    genre VARCHAR(30),
    UNIQUE (title_name, author_name)
);

-- Inserting values into the books table
INSERT INTO books (book_id, title_name, author_name, genre) VALUES
(101, 'East Of Eden', ' John Steinbeck', 'Classic'),
(102, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction'),
(103, 'Brave New World', 'Aldous Huxley', 'Dystopian');

 -- add a Unique Index to an existing table a single column. 
ALTER TABLE tbl_name
ADD UNIQUE INDEX index_unique_column (col_name);

ALTER TABLE tbl_name
ADD UNIQUE INDEX index_unique_columns (col1, col2, ...);


-- Removing a Unique Index
ALTER TABLE tbl_name
DROP INDEX index_unique_column;

-- Using a Unique Index in Queries
SELECT *
FROM tbl_name
WHERE column_name = 'the_value';

INSERT INTO tbl_name(column1, column2, ...)
VALUES ('value1', 'value2', ...);

UPDATE tbl_name
SET column_name = 'new_value'
WHERE unique_column = 'the_value';

DELETE FROM tbl_name
WHERE column_name = 'the_value';




-- DROP INDEX index_name ON table_name;

CREATE TABLE products_index2 (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO products_index2 (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Coffee Maker', 'Appliances', 100.00),
('Running Shoes', 'Clothing', 80.00),
('Digital Camera', 'Electronics', 500.00);


CREATE INDEX idx_category ON products_index2 (category);

SHOW INDEX FROM products_index2;

DROP INDEX idx_category ON products_index2;

-- show indexes --
SHOW INDEX FROM employees FROM geeks4geeks;

show INDEX FROM geeks4geeks.employees;



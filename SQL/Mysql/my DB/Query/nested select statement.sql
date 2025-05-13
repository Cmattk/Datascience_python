-- Create sample tables
CREATE TABLE IF NOT EXISTS products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS orders (
  order_id INT PRIMARY KEY,
  product_id INT,
  quantity INT
);

-- Insert sample data
INSERT INTO products VALUES
  (1, 'Laptop'),
  (2, 'Desk Chair'),
  (3, 'Notebook'),
  (4, 'Headphones'),
  (5, 'Monitor');

INSERT INTO orders VALUES
  (1, 1, 10),
  (2, 2, 5),
  (3, 1, 15),
  (4, 3, 8),
  (5, 4, 12),
  (6, 5, 6);


  -- Query using a Nested SELECT Statement for complex filtering 
  select p.product_id, p.product_name, o.quantity 
  from products as p join orders as o
  on p.product_id = o.product_id
  where o.quantity > (select min(quantity) from orders);

  select min(quantity) from orders;

drop table orders, products;

-- Create a simplified 'guests' table
CREATE TABLE IF NOT EXISTS guests (
  guest_id INT PRIMARY KEY, 
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  total_visits INT
);

-- Insert sample data
INSERT INTO guests (guest_id, first_name, last_name, total_visits)
VALUES
  (1, 'Judy', 'Hopps', 168),
  (2, 'Nick', 'Wilde', 1),
  (3, 'Duke', 'Weaselton', 4),
  (4, 'Tommy', 'Yax', 70),
  (5, 'Lizzie', 'Yax', 80);


select avg(total_visits) as average_visits from guests;

SELECT first_name, last_name, total_visits  FROM guests 
WHERE total_visits > ( SELECT AVG(total_visits)  FROM guests);

drop table guests;
# null
ALTER TABLE products
MODIFY price DECIMAL(4,2) NOT NULL;

INSERT INTO products
VALUE (5, 'Cookie', 0);

SELECT * FROM mydb.products;

# check 
ALTER TABLE employees
ADD CONSTRAINT check_hourly_pay CHECK(hourly_pay >= 10.00); 

INSERT INTO employees VALUES (6, 'Sheldon','Plankton', 5.00, '2006-01-23');

INSERT INTO employees VALUES (6, 'Sheldon','Plankton', 10.00, '2006-01-23');

SELECT * FROM employees;

ALTER TABLE employees
DROP CHECK check_hourly_pay;


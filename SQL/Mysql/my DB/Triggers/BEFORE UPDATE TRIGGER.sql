-- BEFORE UPDATE TRIGGER
-- is invoked before an update operation is performed on the table. 

CREATE TABLE trigger_employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2),
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON trigger_employees
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END;

INSERT INTO trigger_employees (name, position, salary) VALUES ('John Doe', 'Developer', 70000.00);
INSERT INTO trigger_employees (name, position, salary) VALUES ('Jane Smith', 'Manager', 80000.00);

SELECT * FROM trigger_employees;

-- EX 2: Enforcing Business Rules
-- We want to ensure that the price of the product cannot be negative.

CREATE TABLE trigger_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT
);

CREATE TRIGGER before_product_update
BEFORE UPDATE ON trigger_products
FOR EACH ROW
BEGIN
    if new.price < 0
    then set new.price = 0;
    end if;
end;

INSERT INTO trigger_products (name, price, stock) VALUES ('Product A', 100.00, 10);
INSERT INTO trigger_products (name, price, stock) VALUES ('Product B', 200.00, 20);

UPDATE trigger_products
SET price = -50
WHERE name = 'Product A';

SELECT * FROM trigger_products;



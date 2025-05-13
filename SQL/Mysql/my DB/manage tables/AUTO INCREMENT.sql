CREATE TABLE IF NOT EXISTS employees (    
id INT AUTO_INCREMENT,   
name VARCHAR(50),    
position VARCHAR(50),    
PRIMARY KEY (id)
);

INSERT INTO employees (name, position)
VALUES 
('Alice', 'Manager'),
('Bob', 'Developer'),
('Charlie', 'Designer')
;

ALTER TABLE employees AUTO_INCREMENT = 100;
INSERT INTO employees (name, position) VALUES ('Dave', 'Tester');

DELETE FROM employees;

INSERT INTO employees (name, position)
VALUES 
('Alice', 'Manager'),
('Bob', 'Developer'),
('Charlie', 'Designer'),
('Dave', 'Tester')
;

SELECT * FROM `myrestaurant`.`employees` LIMIT 1000;
create table first_name(
    id int,
    name varchar(50),
    salary int,
    department varchar(50)
);

insert into first_name
values
    (1, 'John Doe', 50000, 'IT'),
    (2, 'Jane Smith', 60000, 'HR'),
    (3, 'Robert Johnson', 75000, 'Finance'),
    (4, 'Alice Williams', 70000, 'Marketing');


SELECT * FROM first_name;

-- Using LOAD DATA INFILE

-- LOAD DATA INFILE '/path/to/data.txt'
-- INTO TABLE employees
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- (id, name, salary, department);


CREATE TABLE classroom (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    rollno INT,
    department VARCHAR(50)
);

INSERT INTO classroom (id, name, rollno, department)
VALUES
    (1, 'John Doe', 12, 'IT'),
    (2, 'Jane Smith', 13, 'IT'),
    (3, 'Bob Johnson', 14, 'AI'),
    (4, 'Alice Williams', 15, 'AI'),
    (5, 'Charlie Brown', 16, 'CS'),
    (6, 'Eva Davis', 17, 'IT'),
    (7, 'Frank Miller', 18, 'CS'),
    (8, 'Grace Taylor', 19, 'CS');

SELECT * from classroom;
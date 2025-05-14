use geeks4geeks;

-- INSERT IGNORE INTO table_name (column1, column2, ...)
-- VALUES (value1, value2, ...);

CREATE TABLE college(
    id INT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

INSERT IGNORE INTO college (id, name)
VALUES (1, 'John'), (2, 'Jane');

-- Using INSERT IGNORE
INSERT IGNORE INTO college (id, name)
VALUES (1, 'John'), (3, 'Mike');

-- Checking the data in the table
SELECT * FROM college;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

INSERT INTO students (id, name) VALUES (1, 'Alice');
INSERT INTO students (id, name) VALUES (2, 'Bob');
INSERT INTO students (id, name) VALUES (3, 'Charlie');

-- Attempting to insert duplicate data
-- This row will be ignored due to duplicate name 'Alice'
INSERT IGNORE INTO students (id, name) VALUES (4, 'Alice');
INSERT IGNORE INTO students (id, name) VALUES (5, 'David');

SELECT * FROM students;


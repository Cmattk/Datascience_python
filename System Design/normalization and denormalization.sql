-- Step-by-Step Example: From Unnormalized → 3NF (Normalization) → Denormalization

-- Unnormalized Table

CREATE TABLE enrollment_data (
    student_id INT,
    student_name VARCHAR(100),
    course_id INT,
    course_title VARCHAR(100),
    teacher_id INT,
    teacher_name VARCHAR(100)
);

-- table has redundacy : 
-- repeated student names, course titles, and teacher names 

-- split into tables (2NF)
-- 1. Create Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

INSERT INTO students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- 2. Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_title VARCHAR(100),
    teacher_id INT
);

INSERT INTO courses VALUES
(101, 'Mathematics', 201),
(102, 'Physics', 202),
(103, 'Chemistry', 201);

-- 3. Create Teachers Table
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100)
);

INSERT INTO teachers (teacher_id, teacher_name) VALUES
(201, 'Dr. Smith'),
(202, 'Dr. Johnson');

-- 4. Create Enrollment Table
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO enrollments VALUES
(1, 101), -- Alice → Math
(1, 102), -- Alice → Physics
(2, 103), -- Bob → Chemistry
(3, 101), -- Charlie → Math
(3, 102); -- Charlie → Physics

-- view normalized data
SELECT 
    s.student_name, 
    c.course_title, 
    t.teacher_name
FROM students as s 
JOIN enrollments as e ON s.student_id = e.student_id
JOIN courses as c ON e.course_id = c.course_id
JOIN teachers as t ON c.teacher_id = t.teacher_id;

-- 2. denormalized table
DROP TABLE IF EXISTS denormalized_enrollment_data;

CREATE TABLE denormalized_enrollment_data (
    student_id INT,
    student_name VARCHAR(100),
    course_id INT,
    course_title VARCHAR(100),
    teacher_id INT,
    teacher_name VARCHAR(100)
);

-- Insert data into denormalized table
INSERT INTO denormalized_enrollment_data (student_id, student_name, course_id, course_title, teacher_id, teacher_name)
SELECT 
    s.student_id, 
    s.student_name, 
    c.course_id, 
    c.course_title, 
    t.teacher_id, 
    t.teacher_name
FROM students AS s
JOIN enrollments AS e ON s.student_id = e.student_id
JOIN courses AS c ON e.course_id = c.course_id
JOIN teachers AS t ON c.teacher_id = t.teacher_id;

-- View denormalized data
SELECT * FROM denormalized_enrollment_data;

-- summary:
-- normalized tables           pros                   cons
-- students, courses,          less redundancy,       Requires joins (slower)
-- teachers, enrollments       better data integrity

-- denormalized table          fast reads,             more redundancy, update anomalies
--                             simple queries


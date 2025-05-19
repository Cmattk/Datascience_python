-- INTERSECT Operator
-- is used to find common records between 2 results sets
-- to use these concept in mysql we use
-- inner joins or subqueries
-- it filters unique  records and focuses on shared data

--  INTERSECT Operator using DISTINCT and INNER JOIN Clause

-- INNER JOIN is used to combine rows from either two or more tables as they are related by one column between them.

-- DISTINCT keyword plays a critical role in eliminating duplicate rows in the outcome set.

CREATE TABLE if not exists customers (
customer_id INT,
name VARCHAR(50)
);
INSERT ignore INTO customers (customer_id, name) VALUES

(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

CREATE TABLE if not exists premium_customers (
customer_id INT,
name VARCHAR(50)
);
INSERT ignore INTO premium_customers (customer_id, name) VALUES
(2, 'Bob'),
(3, 'Charlie'),
(5, 'Emma'),
(6, 'Frank');


select DISTINCT customers.customer_id, customers.name
from customers
inner join premium_customers 
on customers.customer_id = premium_customers.customer_id; 

-- INTERSECT Operator using IN and Subquery
-- subquery is a query within a query

select DISTINCT customer_id, name
from customers
where customer_id in (select customer_id from premium_customers);


-- EXISTS OPERATOR
-- used to test the existance of any record in a subquery
-- it returns true if the subquery yields one or more records

select * from g4g;

create table courses (
    id varchar(100),
    course_name varchar(100),
    duration int
);

INSERT INTO courses(id,course_name,duration)
VALUES ('vish3001','Python',30);
INSERT INTO courses(id,course_name,duration)
VALUES('sumit25','Python',30);
INSERT INTO courses(id,course_name,duration)
VALUES('vish3001','Java',40);
INSERT INTO courses(id,course_name,duration)
VALUES('aayush15','Python',30);
INSERT INTO courses(id,course_name,duration)
VALUES('neeraj20','Java',50);

SELECT * FROM courses;

select id, name from g4g
where exists (select courses.id from courses where courses.id = g4g.id);

-- EXISTS Operator With a Complex Subquery

SELECT id,name
FROM g4g 
WHERE EXISTS (SELECT courses.id FROM courses 
    WHERE courses.id = g4g.id and courses.duration = 30 );
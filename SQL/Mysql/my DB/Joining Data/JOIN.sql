-- JOIN--
-- combines rows from two or more tables based on a related column between them. 
-- It allows for efficient data retrieval by enabling the extraction of related information from multiple tables in a single query.

-- Allows the use of normalized database structures (where data is split into different tables to reduce redundancy),
-- JOINs help in efficiently managing and organizing data.

--- create a table --
create table join_employees(
    employee_id int auto_increment primary key,
    name varchar(100),
    department_id int
);

CREATE TABLE join_departments(
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100)
);


INSERT INTO join_employees (name, department_id) VALUES                          
('Alice', 1),
('Bob', 2),
('Charlie', 1),
('David', 3),
('Eve', NULL);

INSERT INTO join_departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Finance');

select * from join_employees;
select * from join_departments;

-- types of JOIN --

-- 1. INNER JOIN --
--  It Returns records that have matching values in both tables.

select join_employees.name, join_departments.department_name
from join_employees
INNER JOIN join_departments
on join_employees.department_id = join_departments.department_id;

-- 2. LEFT JOIN --
-- returns all records from the Left table and matched records from the Right table.
-- If there is no match, then NULL values are returned for Right table columns.

select join_employees.name , join_departments.department_name
from join_employees
LEFT JOIN join_departments
on join_employees.department_id = join_departments.department_id;

-- 3. RIGHT JOIN --
-- Returns all the rows from the right table and the matched rows from the left table. 
-- NULL values will be returned for columns from the left table when there are no matches.

select join_employees.name, join_departments.department_name
from join_employees
RIGHT JOIN join_departments
on join_employees.department_id = join_departments.department_id;

-- 4. FULL JOIN --
-- Returns all records when there is a match in either the left or the right table.
-- In case of no match, NULL values are returned for columns that have no match in either table.

select join_employees.name, join_departments.department_name
from join_employees
LEFT JOIN join_departments
on join_employees.department_id = join_departments.department_id
UNION
select join_employees.name, join_departments.department_name
from join_employees
RIGHT JOIN join_departments
on join_employees.department_id = join_departments.department_id;


-- 5. CROSS JOIN --
-- Returns the Cartesian product of two tables. Matches every row of one table with every row of another table.

select join_employees.name, join_departments.department_name
from join_employees
CROSS JOIN join_departments;

-- 6. SELF JOIN --
-- is a type of join in which a table is joined to itself.
-- is useful when you need to compare rows within the same table,
-- such as relating employees to their managers in an organizational hierarchy.

-- Altering the Table to Add the manager_id Column
alter table join_employees
add column manager_id int;

-- Updating the Table with Manager Information
update join_employees set manager_id = 3 where employee_id = 1;
update join_employees set manager_id = 3 where employee_id = 2;
update join_employees set manager_id = 4 where employee_id = 3;

SELECT a.name AS employee, b.name AS manager
FROM join_employees AS a
JOIN join_employees AS b ON a.manager_id = b.employee_id;

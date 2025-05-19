-- UNION 
-- used to combine the results of two or more SELECT statements into a single result set.
-- Each SELECT statement within the UNION must have the same number of columns in the result sets 
-- with similar data types.

select * from students;

create table if not exists teachers(
    teacher_id int auto_increment primary key,
    teacher_name varchar(100),
    subject varchar(50),
    years_of_experience int
);

insert ignore into teachers (teacher_name, subject, years_of_experience)
values
('Rave', 'Geography', 9),
('Deepkic', 'Tamul', 11);

SELECT * FROM teachers;

select student_name as Name, 'Student' as Type 
FROM students
UNION
select teacher_name as Name, 'Teacher' as Type 
FROM teachers;

select student_name as Name, 'Student' as Type
from students
where branch = 'CSE'
UNION
select teacher_name as Name, 'Teacher' as Type 
FROM teachers
where years_of_experience > 8;

-- removes duplicates 
select student_name as Name
from students
where branch = 'CSE'
UNION
select student_name as Name 
FROM students
where state = 'PUNJAB';

-- UNION ALL
-- is used to combine the result sets of two or more SELECT statements.
-- UNION ALL does not remove duplicate rows from the result sets.
-- more efficient than UNION when we do not need to eliminate duplicates.

select * from employees;

select employee_name from employees
where department = 'HR'
UNION ALL
select employee_name from employees
where salary  >= 56000;

-- doesn't remove duplicates
select employee_name from employees
where department = 'HR'
UNION ALL
select employee_name from employees
where salary  >= 56000
order by employee_name;




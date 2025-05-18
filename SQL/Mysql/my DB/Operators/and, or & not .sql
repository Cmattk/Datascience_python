CREATE TABLE if not exists students(
student_id INT primary key,
student_name VARCHAR(20),
birth_date DATE,
branch VARCHAR(20),
state VARCHAR(20));

INSERT ignore INTO students 
VALUES
(194001,'PRANAB','1999-03-17','CSE','PUNJAB'),
(194002,'PRAKASH','2000-08-07','ECE','TAMIL NADU'),
(194003,'ROCKY','2000-03-10','ECE','PUNJAB'),
(194004,'TRIBHUVAN','1999-03-15','CSE','ANDHRA PRADESH'),
(194005,'VAMSI','2000-04-19','CSE','TELANGANA');


select * from students;

-- AND 
-- All the students with branch CSE and from Punjab.
SELECT *
    FROM students
    WHERE branch = 'CSE' AND state ='PUNJAB';

-- OR 
-- All the students with branch either CSE or ECE.
select * from students 
where branch = 'CSE' OR branch = 'ECE';

-- NOT
-- All the students were from states other than Punjab.
SELECT *
      FROM students
      WHERE NOT state ='PUNJAB';



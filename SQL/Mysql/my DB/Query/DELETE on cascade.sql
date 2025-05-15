-- ON DELETE CASCADE constraint is used in MySQL
-- to delete the rows from the child table automatically, 
-- when the rows from the parent table are deleted.

use database geeks4geeks;

CREATE TABLE IF NOT EXISTS Student (
    sno INT PRIMARY KEY,
    sname VARCHAR(20),
    age INT

);

INSERT IGNORE INTO Student(sno, sname,age) 
 VALUES(1,'Ankit',17),
       (2,'Ramya',18),
       (3,'Ram',16);

SELECT *
FROM Student;

CREATE TABLE IF NOT EXISTS Course (
    cno INT PRIMARY KEY,
    cname VARCHAR(20)
);

INSERT IGNORE INTO Course(cno, cname) 
 VALUES(101,'c'),
       (102,'c++'),
       (103,'DBMS');

SELECT *
FROM Course;

CREATE TABLE IF NOT EXISTS Enroll(
    sno INT,
    cno int,
    jdate date,
    PRIMARY KEY (sno, cno),
    FOREIGN KEY (sno) references Student(sno) on delete cascade,
    FOREIGN KEY (cno) references Course(cno) on delete cascade
);


INSERT IGNORE INTO Enroll(sno, cno, jdate) 
VALUES
    (1, 101, NOW() + INTERVAL 1 DAY),
    (1, 102, NOW() + INTERVAL 2 DAY),
    (2, 103, NOW() + INTERVAL 3 DAY);


SELECT *
FROM Enroll;

--- Here the parent tables are Student and Course whereas the child table is Enroll.

DELETE FROM Student
WHERE sname="Ramya";

Select * from Student;
Select * from Enroll;

-- As you delete the contents of sno=2 in the parent table it automatically deletes the details of sno=2 from the child table 
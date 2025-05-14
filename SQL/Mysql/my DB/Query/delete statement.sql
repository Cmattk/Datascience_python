CREATE TABLE cadets (
  ID int NOT NULL,
  Name varchar(255) NOT NULL,
  Department varchar(255) NOT NULL,
  Location varchar(255) NOT NULL,
  PRIMARY KEY (ID)
);

INSERT INTO cadets (ID, Name, Department, Location) VALUES
  (12, 'Ravi', 'IT', 'Hyderabad'),
  (15, 'Kiran', 'MECH', 'Mysore'),
  (18, 'Navya', 'CSE', 'Hyderabad'),
  (20, 'Rahul', 'CIVIL', 'Chennai'),
  (22, 'Alex', 'ECE', 'Bengaluru'),
  (24, 'Bob', 'IT', 'Vizag');

-- DELETE Statement with WHERE Clause
DELETE from cadets
where (Department = 'IT' or Department = 'CSE') AND Location = 'Hyderabad';

-- DELETE with JOIN Clause
--  DELETE table1,table2
--  from table1
--  inner JOIN table2 
--  on table1.id = table2.id
--  where table1.id = 2;


select * from cadets;


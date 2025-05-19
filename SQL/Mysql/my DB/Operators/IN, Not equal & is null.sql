-- in operator used to filter data based on a specified set of values.

use geeks4geeks;

select id, name, department from classroom
where department in ('IT', 'AI');

select id, name, department
from classroom
where department not in ('IT', 'AI');

select * from classroom ;

-- NOT EQUAL
-- used to compare two expressions to determine if they are not equal. 
-- This operator is primarily used for filtering results in queries to exclude specific values 
-- or find records that differ from a given value.

-- two ways to express the NOT EQUAL operator:
--- != operator  and <> operator

SELECT name, department
FROM classroom
WHERE department != 'IT';

select name, department
from classroom
where department <> 'AI';

-- IS NULL
-- identifies and manages records with missing or incomplete data.
-- supports accurate queries and data integrity.
-- Helps to maintain clean and accurate data by enabling checks for incomplete records.

insert ignore into classroom
values (9, 'Matt Ale', NULL ,'ASC'),
       (10, 'Chris Ave', NULL, 'ASC');

select id, name
from classroom
where rollno is null;

select count(*)
from classroom
where rollno is null;

update classroom
set rollno = 13
where rollno is null;

delete from classroom
where rollno is null;

select * from classroom;

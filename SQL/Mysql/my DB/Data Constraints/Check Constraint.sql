-- Check Constraint
-- it enforces a condition on column(s) of a table.
-- ensures a specific type of data only gets inserted into the table.

--  create table with check constraint -- 
SELECT VERSION();


CREATE TABLE checkC (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    questions INT,
    rank_no INT,
    CONSTRAINT check_validEntry CHECK (rank_no <= 100 AND questions > 100)
);


insert into checkC (id, name, questions, rank_no)
values
(01,'Vishu',150,10),
(02,'Sumit',145,15),
(03,'Aayush',140,20),
(04,'Neeraj',120,40);

select * from checkC;

-- Inserting a Row with Rank Grater than 100 --
insert into checkC (id, name, questions, rank_no)
values (05,'Vivek',150,120);

-- Inserting a Row with Questions Less than 100 --
insert into checkC (id, name, questions, rank_no)
values (05,'Vivek',90,12);

-- Drop the CHECK constraint --
-- use ALTER and DROP clause

ALTER TABLE checkC
DROP CONSTRAINT check_validEntry;

insert into checkC (id, name, questions, rank_no)
values (05,'Vivek',90,12);

select * from checkC;

delete from checkC
where id = 5;

-- Adding CHECK Constraints to an Existing Table --
ALTER TABLE checkC
ADD CONSTRAINT check_validEntry
CHECK (rank_no <= 100 AND questions > 100);

insert into checkC (id, name, questions, rank_no)
values (05,'Vivek',90,12);

DROP TABLE checkC;
-- foreign key
-- is a field or column that refers to a primary key in another table.
-- also called referencing key.
-- it rcreates a link (relation) between 2 tables thus creating referential integrity.

-- FK creates a parent-child type of relationship 
-- where the table with the FOREIGN KEY in the child table refers to the primary or unique key column in the parent table.

-- create table with foreign key

-- Parent table ---------
use geeks4geeks;

create table if not exists parent(
    parent_id int primary key,
    parent_name varchar(50),
    email varchar(100) unique not null
);

insert ignore into parent (parent_id, parent_name, email)
values
(1, 'Alice Mueni', 'alicemueni24@timill.xyz'),
(2, 'Jackson Kariuki', 'jackkariuki@timill.xyz'),
(3, 'Farida Swale', 'faridaswale@timill.xyz'),
(4, 'Alex Ochieng', 'alexochieng@timill.xyz');



-- child table ----------

create table if not exists child(
    child_id int primary key,
    parent_id int,
    adm_date date,
    package_amount decimal(10,2),
    foreign key (parent_id) references parent(parent_id)
);

insert ignore into child (child_id, parent_id, adm_date, package_amount)
values
(1, 2, '2025-03-09',45000),
(2, 4, '2025-03-10', 45000),
(3, 1, '2025-03-12', 55000),
(4, 3, '2025-03-14', 55000);

alter table child
add column child_name varchar(50);

UPDATE child SET child_name = 'Alice'   WHERE child_id = 1;
UPDATE child SET child_name = 'Brian'   WHERE child_id = 2;
UPDATE child SET child_name = 'Cynthia' WHERE child_id = 3;
UPDATE child SET child_name = 'David'   WHERE child_id = 4;

alter table child
modify column child_name varchar(50) after child_id;

-- Describe the tables ----
desc child;
desc parent;

-------Queries-----

select child_id, child_name, parent_name as childsParent
from child inner join parent
on child.parent_id = parent.parent_id;

select child_id, child_name, email as parentsEmail
from child left join parent
on child.parent_id = parent.parent_id;


---- Example 2 ----

-- Foreign Key using SET NULL---
-- SET NULL action in a foreign key constraint is used to delete or update row in the parent table 
--- while setting the foreign key column in the child table to NULL.

create table fkp(
    p_id int primary key,
    p_name varchar(50) not null
);

create table fkc(
    c_id int primary key,
    c_name varchar(50) not null,
    p_id int,
    foreign key (p_id) references fkp(p_id)
        on update set null 
        on delete set null
);

INSERT INTO fkp (p_id, p_name) VALUES
    (1, 'HR'),
    (2, 'Engineering'),
    (3, 'Marketing');

insert into fkc (c_id, c_name, p_id) VALUES
    (101, 'John Doe', 1),
    (102, 'Jane Smith', 2),
    (103, 'Bob Johnson', 3);

select * from fkp;
select* from fkc;

-- update p_id in fkp and set it null in fkc
update fkp set p_id = 4 where p_id = 2;
select * from fkc;

-- delete a p_id in fkp and set it null in fkc
delete from fkp where p_id = 1;
select * from fkc;

---  Drop foreign key ---
alter table <table_name>
drop foreign key foreign_key_name;

-- enabling disabling foreign key checks

-- disable --
SET foreign_key_checks = 0;


-- enable--
SET foreign_key_checks = 1;
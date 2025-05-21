-- Alternate Key
-- is a column or set of columns that can uniquely identify a record, like a primary key.
-- it enhances database reliability and efficiency.

-- key concepts --
-- primary key - a column or combination of columns that uniquely identifies row in a table.
-- candidate key - a column or set of columns that can uniquely identify a row in a table.
----              Every table can have multiple candidate keys.
-- Alternate key - A candidate key that was not selected as the primary key.

-- while defining a relation, only one candidate key can be specified as the primary key, 
-- and the others are termed as the alternate key.

-- To define an alternate key, you need to use the 'UNIQUE' constraint, 
-- which ensures that all values in a column or a set of columns are distinct.

-- Creating a Table with an Alternate Key.

create table alternate (
    student_id int auto_increment,
    email varchar(100),
    phone varchar(15),
    primary key (student_id),
    UNIQUE (email)
);

-- 'student_id' is the primary key.
-- 'email' is the alternate key because it is unique and can identify a record independemtly.

--- Inserting Data into the Table ---
insert into alternate (email, phone)
values
('alice@example.com', '1234567890'),
('bob@example.com', '0987654321'),
('charlie@example.com', '1122334455');

select * from alternate;

-- Adding Unique contraint to an existing table --
alter table users add constraint unique_email
unique (email);

desc users;

-- Inserting Additional Data --
insert into alternate (email, phone)
values ('dave@example.com', '2233445566');

select * from alternate;

--- Attempting to Insert Duplicate Values -- 
insert into alternate (email, phone)
values ('dave@example.com', '2233445566');





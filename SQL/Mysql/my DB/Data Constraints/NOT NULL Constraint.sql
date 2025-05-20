-- NOT NULL Constraint
-- it enforces the presence of values within specific columns.

-- we will cover it's implementation, addition, removal and significance in database design.

create table if not exists users (
    user_id int auto_increment primary key,
    username varchar(50),
    email varchar (100),
    age int 
);

insert ignore users (user_id, username, email, age)
values
    (1, 'ram_123', 'ram123@gmail.com', 30),
    (2, 'sumitb 17', 'sumit@gmail.com', NULL),
    (3, 'rohit264', 'rohits@yopmail.com', 35),
    (4, 'mahi', 'msd@gmail.com', NULL),
    (5, 'Bob', 'bobzy@gmail.com', 25);

select * from users;

-- add a not null constraint to existing column

alter table users
modify column email varchar(100) NOT NULL;

-- remove a not null constraint
alter table users
modify column email varchar(100);


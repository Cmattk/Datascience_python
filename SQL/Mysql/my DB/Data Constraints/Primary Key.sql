-- Primary Key
-- In mySQL data is stored in a table format and to uniquely identify each record in a table, we require a Primary Key.
-- It is a unique column/ field in a table that doesnot contain duplicates or null values.
-- it maintains integrity of the database by preventing duplicate and null values in the key column.

-- Primary keys can be either system-generated such as auto-incremented integers or natural keys such as
-- existing data that uniquely identifies a record (for example- Email).

-- create table with primary key
create table primr (
    id int,
    name varchar(100),
    primary key(id)
);

-- add primary key to a table
alter table primr
add primary key(name);

-- Drop primary key
alter table primr
drop primary key;

desc table primr;

drop table primr;
# RENAME TABLE workers to employees;
ALTER TABLE employees ADD phone_number VARCHAR(10);
ALTER table employees rename column phone_number to email; 
alter table employees modify column email varchar(100);
alter table employees modify email varchar(100) after last_name;
alter table employees drop column email;




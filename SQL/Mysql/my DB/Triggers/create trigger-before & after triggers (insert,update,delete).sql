-- 1. Before Update Trigger: actions of the trigger will be performed before the update is implemented

-- Create buyer table
CREATE TABLE buyer (
    acc_no INT PRIMARY KEY,
    buyer_name VARCHAR(20),
    available_balance DECIMAL
);

-- Create mini_statement table
CREATE TABLE mini_statement (
    acc_no INT,
    available_balance DECIMAL,
    FOREIGN KEY (acc_no) REFERENCES buyer(acc_no) ON DELETE CASCADE
);

-- Insert initial records
INSERT INTO buyer 
VALUES 
(1000, 'Fanny', 7000), 
(1001, 'Peter', 12000);

select * from buyer;

-- Create trigger to log old balance before update

CREATE TRIGGER update_buyer
BEFORE UPDATE ON buyer
FOR EACH ROW
BEGIN
    INSERT INTO mini_statement (acc_no, available_balance)
    VALUES (OLD.acc_no, OLD.available_balance);
END;


-- Perform updates
UPDATE buyer SET available_balance = available_balance + 2000 
WHERE acc_no = 1000;

UPDATE buyer SET available_balance = available_balance + 3000 
WHERE acc_no = 1001;

select * from buyer;
select * from mini_statement;

-- 2. After Update Trigger: it gets implemented after an update statement is executed
create table micro_statement (
acc_no int,
available_balance DECIMAL,
foreign key (acc_no) references buyer(acc_no) on delete cascade
);

insert into buyer values (1002, "Janitor", 4500);

-- create trigger
create trigger update_after
after update on buyer
for each row 
begin 
    insert into micro_statement(acc_no, available_balance)
    values (new.acc_no, new.available_balance);
end;

update buyer 
set available_balance = available_balance + 1500
where acc_no = 1002;

select * from buyer;
select * from micro_statement;

-- 3. Before Insert Trigger: As the name implies, this trigger is invoked before an insert,
--    or before an insert statement is executed.

create table contacts(
    contact_id int(11) not null auto_increment,
    last_name varchar(30) not null,
    first_name varchar(30),
    birthdate date,
    created_date date,
    created_by varchar(30),
    constraint contact_pk PRIMARY KEY (contact_id) 
);
-- Trigger to insert contact information such as name, birthday and creation-date/user into a table contact before an insert occurs:
create trigger contacts_before_insert
before insert on contacts
for each row 
begin
    declare vuser varchar(50);
    -- find username of person performing insert into table
    select user() into vuser;
    -- update create_date field to current system date
    set new.created_date = sysdate();
    -- update created_by filed to the username of the person performing the insert
    set new.created_by = vuser;
end;

insert into contacts 
values 
(1, "Newton", "Enigma", str_to_date("19-08-1999","%d-%m-%Y"), "2018-03-17","XYZ");

select *from contacts;

-- 4. After Insert Trigger: As the name implies, 
---   this trigger gets invoked after an insert is implemented.
create table contacts2 (
    contact_id int (11) NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(30) NOT NULL, 
    first_name VARCHAR(25), 
    birthday DATE,
    CONSTRAINT contacts_pk PRIMARY KEY (contact_id));

create table contacts_audit (
    contact_id int,
    created_date date,
    created_by varchar(30)
);

-- Trigger to insert contact_id and contact creation-date/user information into contacts_audit record after an insert occurs:
create trigger contacts2_after_insert
after insert on contacts2
for each row
begin
    declare vuser varchar(50);
    -- username of person inserting into table
    select user() into vuser;
    -- insert record into audit table
    insert into contacts_audit(
        contact_id,
        created_date,
        created_by
    )
    values (new.contact_id, sysdate(), vuser);
end; 

insert into contacts2
values (1, 'Kumar', 'Rupesh', '1999-06-20');

select * from contacts_audit;

-- 5. Before Delete Trigger
-- : triggers is invoked before delete occurs.


create table contacts_audit2 (
    contact_id int,
    deleted_date date,
    deleted_by varchar(30)
);

insert ignore into contacts2
values 
(2, 'Marish', 'Khaan', '1999-06-26'),
(3, 'Omar', 'Kritesh', '1999-06-26'),
(4, 'Priha', 'Hanuru', '1999-06-27'),
(5, 'Deepki', 'Shamerh', '1999-06-28')
;

create trigger contacts_before_delete
before delete
on contacts2 for each row
begin 
    declare vuser varchar(30);
    SELECT user() into vuser;
    insert into contacts_audit2(
        contact_id,
        deleted_date,
        deleted_by
    )
    values (
        old.contact_id,
        sysdate(),
        vuser
    );
end;

delete from contacts2 where contact_id = '5';
select * from contacts_audit2;


-- 6. AFter delete trigger

create table contacts_audit3 (
    contact_id int,
    deleted_date date,
    deleted_by varchar(30)
);


create trigger contacts_after_delete
after delete
on contacts2 for each row
begin 
    declare vuser varchar(30);
    SELECT user() into vuser;
    insert into contacts_audit3(
        contact_id,
        deleted_date,
        deleted_by
    )
    values (
        old.contact_id,
        sysdate(),
        vuser
    );
end;

delete from contacts2 where contact_id = '4';
select * from contacts_audit3;

----- SHOW TRIGGERS ------
SHOW TRIGGERS FROM geeks4geeks;
-- show triggers by table --
SHOW TRIGGERS LIKE 'contacts';

--- DROP TRIGGERS ---
DROP TRIGGER IF EXISTS contacts_after_delete;


drop table contacts2;
drop table contacts_audit2;
drop table contacts_audit;


drop table mini_statement;
drop table micro_statement;
drop table buyer;

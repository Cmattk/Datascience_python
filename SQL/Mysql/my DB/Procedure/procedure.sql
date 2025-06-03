-- Procedure --
-- is a subroutine  in a regular scripting  language , stored in a database.
-- a mysql procedure has a name , a parameter list, and sql statement(s)

-- Four different types of the procedures --

-- 1. Procedure with no parameters: 
-- A procedure without parameters does not take any input or casts an output indirectly.
-- It is simply called with its procedure name followed by () (without any parameters).

-- Example: Consider two tables author and book:
create table author (
    author_id integer primary key,
    authorname varchar(30),
    email varchar (25),
    gender varchar(10)
);

create table book(
    bookid integer not null unique,
    ISBN integer primary key,
    book_name varchar (30) not null,
    author_id integer,
    ed_num integer,
    price integer,
    pages integer,
    foreign key (author_id) references author(author_id) on delete cascade
);

insert into author values 
(1, "Kraig Muller", "Wordnewton@gmail.com", "Male"),
(2, "Karrie Nicolette", "karrie23@gmail.com", "Female");

insert into book values
(1, 001, "Glimpses of the past", 1, 1, 650, 396),
(2, 002, "Beyond The Horizons of Venus", 1, 1, 650, 396),
(3, 003, "Ultrasonic Aquaculture", 2, 1, 799, 500),
(4, 004, "Cryogenic Engines", 2, 1, 499, 330); 

-- procedure --
CREATE procedure display_book()
BEGIN   
    SELECT * FROM book;
END; 
call display_book();

-- 2. Procedure with IN  parameter:
-- An IN parameter is used to take a parameter as input such as an attribute.
-- the procedure only works on the copy of the IN parameter.
-- Example: Procedure to update price of a book taking ISBN of the book and its new price as input

create procedure update_price (
    IN temp_ISBN varchar(10),
    IN new_price integer)
BEGIN
    update book
    set price = new_price
    where ISBN = temp_ISBN;
END;

call update_price(001,600);

-- 3. Procedure with out parameter:
-- used to pass a parameter as output or display like select operator.
-- value of an output parameter can be changed inside the procedure 
--- and its ne value is passed back to the calling program.
-- Example: procedure to display the highest price  among all the books with an output parameter:

create procedure display_max(out highestprice integer)
BEGIN
    select max(price) into highestprice from book;
END;

call display_max(@M);
SELECT @M;
-- @M is a session variable used to store the result from the procedure.

-- 4. Procedure with IN-OUT parameter: 
-- An INOUT parameter is a combination of IN and OUT parameters. 
-- It means that the calling program may pass the argument, and
-- the stored procedure can modify the INOUT parameter and pass the new value back to the calling program. 
-- Example: Procedure to take gender type input ('Male'/'Female' here) with an in-out parameter 
--- which reflects the number of authors falling in that gender category/type:

create procedure display_gender(
    INOUT mfgender integer,
    IN emp_gender varchar(6)
)
BEGIN
    select count(gender) into mfgender from author
    where gender = emp_gender;
end;

call display_gender(@M,'Male');
select @M;

call display_gender(@M, 'Female');
select @M;




-- AFTER INSERT TRIGGER
-- utomatically executes specified actions after a new row is inserted into a table

-- It is used to perform tasks such as updating related tables, logging changes or performing calculations, 
-- ensuring immediate and consistent data processing.

/*
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
FOR EACH ROW
BEGIN
    -- trigger logic here
END;
*/

DROP TRIGGER log_order_insert;
DROP TABLE trigger_orders;
DROP TABLE order_log;


-- EX 1: TRIGGER THAT LOGS THE DEATAILS OF AN ORDER INTO A TABLE CALLED 'order_log'

CREATE TABLE trigger_orders(
    order_id int primary key,
    customer_id int not null,
    order_date date,
    total_amount decimal(10,2)
);

CREATE TABLE order_log(
    order_id int primary key,
    customer_id int not null,
    order_date date,
    total_amount decimal(10,2)
);

CREATE TRIGGER log_order_insert
AFTER INSERT ON trigger_orders
FOR EACH ROW
BEGIN 
    INSERT INTO order_log (order_id, customer_id, order_date, total_amount)
    VALUES (NEW.order_id, NEW.customer_id, NEW.order_date, NEW.total_amount);
END;

INSERT INTO trigger_orders()
VALUES (1, 123, '2024-07-30', 250.00);
SELECT * FROM trigger_orders;

SELECT * FROM order_log;

-- EXAMPLE 2: ON A DATABASE FOR LIBRARY SYSTEM . THERE SHOULD BE A TABLE FOR HOLDING DATA 
-- ABOUT THE BOOKS
-- AND ANOTHER FOR LOGGING EACH  NEW BOOK ADDED INTO THE LIBRARY.

DROP table trigger_books;


CREATE TABLE trigger_books(
    book_id int auto_increment primary key,
    title varchar(255),
    author varchar(255),
    published_date DATE,
    genre varchar(100),
    added_date timestamp default current_timestamp 
);

DROP table book_log;

CREATE TABLE book_log(
    log_id int auto_increment primary key,
    book_id int,
    log_date timestamp default current_timestamp,
    action varchar(50)
);

DROP TRIGGER log_book_insert;

CREATE TRIGGER log_book_insert
AFTER INSERT ON trigger_books
FOR EACH ROW
BEGIN
    INSERT INTO book_log (book_id,log_date,action)
    VALUES (NEW.book_id, NOW(), 'BOOK ADDED');
END;

INSERT INTO trigger_books (title, author, published_date, genre)
VALUES ('Siku Njema', 'Ken Walibora', '2011-03-12', 'Fiction');

INSERT INTO trigger_books (title, author, published_date, genre)
VALUES ('KIGOGO', 'PAULINE KEA', '2017-07-22', 'Fiction');

SELECT * FROM trigger_books;

SELECT * FROM book_log;















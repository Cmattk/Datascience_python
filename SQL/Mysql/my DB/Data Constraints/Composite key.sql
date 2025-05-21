-- Composite key
-- it is a combination of two or more columns in a table that uniquely 
-- each entry.

-- it is important hen database has to uniquely identify each record that has more than one characteristic.

-- composite key in create statement
create table compo(
    emplo_id int,
    depa_id int,
    emplo_name varchar(255),
    primary key (emplo_id, depa_id)
);

describe compo;

INSERT INTO compo (emplo_id, depa_id, emplo_name) VALUES
    (101, 1, 'John Doe'),
    (102, 2, 'Jane Smith'),
    (103, 1, 'Bob Johnson'),
    (104, 3, 'Alice Brown');

SELECT * FROM compo;  

-- Composite Key in ALTER Statement
CREATE TABLE compo2 (
    order_id INT,
    product_id INT,
    quantity INT
);

-- add composite key
ALTER TABLE compo2
ADD PRIMARY KEY (order_id, product_id);

describe compo2;

INSERT INTO compo2 (order_id, product_id, quantity) 
VALUES
    (101, 1, 10),
    (102, 2, 12),
    (103, 1, 13),
    (104, 3, 14);

SELECT * FROM compo2;


 insert into employees 
 values 
(2, 'Squidward', 'Tentacles', 15.25, '2003-04-20'),
(3, 'Spongebob', 'Squarepants', 12.50, '2005-06-02'),
(4, 'Patrick', 'Star', 11.50, '2003-11-24'),
(5, 'Sandy', 'Cheeks', 17.00, '2004-07-17');

insert into employees (employee_id, first_name, last_name) values (6, 'Sheldon', 'Plankton');


SELECT 
    *
FROM
    mydb.employees;
-- inner join 
SELECT authors.author_name, books.title
FROM book_authors
INNER JOIN authors ON book_authors.author_id = authors.author_id
INNER JOIN books ON book_authors.book_id = books.book_id
WHERE books.publication_year < '2015-01-01';

-- self join
select * from employees;

SELECT e1.employee_id AS employee_id, 
       e1.employee_name AS employee_name, 
       e2.salary AS employee_salary
FROM employees as e1
INNER JOIN employees as e2 ON e1.employee_id = e2.employee_id;

-- cross join
SELECT * FROM customers
CROSS JOIN orders;

-- recursive join
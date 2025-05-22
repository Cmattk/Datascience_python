-- right join
-- lists authors' names alongside the titles of books they authored.
select book_id, author_id, title, publication_year from book_authors
right join books using(book_id);

select authors.author_name, count(books.book_id)  as book_count
from authors
right join book_authors on authors.author_id = book_authors.author_id
right join books on book_authors.book_id = books.book_id
group by authors.author_name;

select authors.author_name, books.title
FROM authors
RIGHT JOIN book_authors ON authors.author_id = book_authors.author_id
RIGHT JOIN books ON book_authors.book_id = books.book_id
WHERE books.publication_year < '2015-01-01';

SELECT *
FROM authors
RIGHT JOIN book_authors ON authors.author_id = book_authors.author_id
RIGHT JOIN books ON book_authors.book_id = books.book_id;
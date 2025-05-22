-- left join
-- create authors & books Tables

create table authors(
    author_id int primary key,
    author_name varchar(255)
);

create table books(
    book_id int primary key,
    title varchar(255),
    publication_year date
);

-- create book_authors Table
create table book_authors(
    book_id int,
    author_id int,
    foreign key (book_id) references books(book_id)
        on delete cascade on update cascade,
    foreign key (author_id) references authors(author_id)
        on delete cascade on update cascade
);

INSERT INTO authors (author_id, author_name) VALUES 
(1, 'Rajesh Kumar'),
(2, 'Priya Patel'),
(3, 'Amit Sharma'),
(4, 'Neha Gupta'),
(5, 'Sanjay Verma'),
(6, 'Pooja Singh'),
(7, 'Rahul Kapoor'),
(8, 'Meera Jain'),
(9, 'Vikram Malhotra'),
(10, 'Anita Choudhary');

INSERT INTO books (book_id, title, publication_year) VALUES 
(101, 'The Mystery', '2010-01-01'),
(102, 'Adventure Awaits', '2015-01-01'),
(103, 'Coding 101', '2020-01-01'),
(104, 'The Secret Garden', '2012-01-01'),
(105, 'Data Science Essentials', '2018-01-01'),
(106, 'Indian Cooking 101', '2015-01-01'),
(107, 'Mystery of the Himalayas', '2011-01-01'),
(108, 'Love in the Monsoon', '2019-01-01');


INSERT INTO book_authors (book_id, author_id) VALUES
(101, 1),
(101, 2),
(102, 2),
(103, 3),
(104, 4),
(105, 5),
(106, 6),
(107, 7),
(108, 8),
(104, 9),
(105, 10),
(106, 10);

--- clauses--
select * from books
left join book_authors using (book_id);

select authors.author_name,  count(books.book_id) as book_count
from authors
left join book_authors on authors.author_id = book_authors.author_id
left join books on book_authors.book_id = books.book_id
group by authors.author_name;

SELECT authors.author_name, books.title
FROM authors
LEFT JOIN book_authors ON authors.author_id = book_authors.author_id
LEFT JOIN books ON book_authors.book_id = books.book_id
WHERE books.publication_year < '2015-01-01';


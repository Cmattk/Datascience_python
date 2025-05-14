-- syntax
--   UPDATE table_name
--   SET column_name = value
--   WHERE (condition);

create table g4g(
    id varchar(100) primary key,
    name varchar(100),
    monthly_score int,
    contest_rank int,
    courses_enrolled int
);

insert into g4g
values
    ('vish3001', 'Vishu', 50, 1, 10),
    ('Aayush05', 'Aayush', 48, 2, 8),
    ('Neeraj50', 'Neeraj', 46, 3, 6),
    ('Sumit65', 'Sumit', 45, 4, 5),
    ('Harsh45', 'Harsh', 42, 5, 7);

-- UPDATE Statement
UPDATE g4g
set contest_rank = 10
WHERE id = 'Neeraj50';

-- Update With Multiple Columns
UPDATE g4g
set contest_rank = 55, courses_enrolled = 15
where id = 'sumit65';

UPDATE g4g
SET name = 'Vishu Vaishnav'
WHERE id = 'vish3001';

-- UPDATE Without WHERE Clause
UPDATE g4g
SET monthly_score = monthly_score + 1;

-- complex query
UPDATE g4g
set contest_rank = contest_rank + 5,
courses_enrolled = courses_enrolled + 10
where id = 'vish3001' or name = 'Harsh';

-- IGNORE clause on UPDATE Statement:
UPDATE IGNORE g4g
set id = 'vish3001'
where name = 'Harsh';

select * from g4g ;

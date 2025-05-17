-- A PARTITION BY clause is used to partition rows of table into groups.
-- It is useful when we have to perform a calculation on individual rows of a group using other rows of that group.

-- It is always used inside OVER() clause.
-- The partition formed by partition clause are also known as Window.
-- This clause works on windows functions only. Like- RANK(), LEAD(), LAG() etc.
-- If this clause is omitted in OVER() clause, 
-- then whole table is considered as a single partition.

create table if not exists hacker(
    h_id int,
    h_name varchar(50),
    challenge_id int,
    score int ,
    PRIMARY KEY (h_id,h_name,challenge_id)
);

insert ignore into hacker
values 
    (3, 'shubh', 111, 20),
    (2, 'aayush', 111, 80),
    (5, 'krithik', 112, 40),
    (5, 'krithik', 114, 90),
    (4, 'tushar', 112, 30),
    (1, 'parth', 112, 40);

SELECT * FROM hacker;


-- Rank hackers within each challenge based on score
-- This will show how each hacker ranks within each challenge based on their score 
SELECT *,
RANK() OVER (PARTITION BY challenge_id order by score desc) as rank_in_challenge
FROM hacker;

-- Total score per hacker (without collapsing rows)
select *, SUM(score) over (partition by h_id, h_name) as total_score_per_hacker
FROM hacker;

-- Row number per hacker (for challenge attempts)
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY h_id, h_name ORDER BY challenge_id) AS attempt_number
FROM 
    hacker;



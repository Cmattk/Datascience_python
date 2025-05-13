repair table users quick;

REPAIR TABLE users EXTENDED;

CREATE TABLE  if not exists my_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO my_table (id,name) VALUES (1,'Badal'), (2,'Ashutosh'), (3,'Diya');

UPDATE my_table SET id = id + 1 WHERE id = 3;

CHECK TABLE my_table;

REPAIR TABLE my_table;

CHECK TABLE my_table;

SELECT * FROM my_table;

drop table my_table;
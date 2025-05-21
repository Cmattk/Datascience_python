-- DEFAULT Constraint
-- returns the default value for a table column. 
-- The DEFAULT value of a column is a value used in the case, 
-- when there is no value specified by the user.

--- Using DEFAULT Constraint on CREATE TABLE ---
CREATE TABLE defaultC (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) DEFAULT 'example@domain.com',
  city VARCHAR(50) DEFAULT 'Unknown'
);

--- Add DEFAULT Constraint with ALTER TABLE Statement ---
ALTER TABLE defaultC ALTER city SET DEFAULT 'New York';

desc defaultC;

---EX2--
CREATE TABLE blog_posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    published_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

desc blog_posts;

INSERT INTO blog_posts (title,content)
VALUES ('My First Blog Post', 'Hello readers! This is my UCL Final preview post analysis.'
);

select * from blog_posts;




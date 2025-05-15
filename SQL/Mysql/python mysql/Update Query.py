import mysql.connector as mc

# connecting to database 

conn = mc.connect(
    host = 'localhost',
    database = 'geeks4geeks',
    user = 'root',
    password = "@Mathias#"
)

cs = conn.cursor()

# drop clause 
query0 = "INSERT IGNORE INTO students(id,name) VALUES (1,'Rishi Kumar'), (2,'SK Anirban');"
query1 = "UPDATE students SET name = 'Dev Khan' WHERE id = 2; "

cs.execute(query0)
cs.execute(query1)

conn.commit()

cs.execute("SELECT * FROM students;")
result = cs.fetchall()

for row in result:
    print(row)

# Disconnecting from the database
conn.close() 
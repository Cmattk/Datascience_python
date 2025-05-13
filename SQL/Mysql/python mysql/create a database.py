from mysql.connector import connection

conn = connection.MySQLConnection(host = 'localhost',
                                  user = 'root',
                                  password = '@Mathias#',
                                  database = 'geeks4geeks')

# preparing a cursor object
cursorObject = conn.cursor()
 
# creating database
# cursorObject.execute("CREATE DATABASE geeks4geeks")

# drop database 


# creating table

studentRecord = """ CREATE TABLE STUDENT (
                name varchar(20) not null,
                branch varchar(50),
                roll int not null,
                section varchar(5),
                age int   
                )"""

cursorObject.execute(studentRecord)

# drop table
statement = "Drop Table if exists student"

cursorObject.execute(statement)

# disconnecting from server
conn.close()




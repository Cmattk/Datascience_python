from mysql.connector import connection

conn = connection.MySQLConnection(host = 'localhost',
                                  user = 'root',
                                  password = '@Mathias#',
                                  database = 'geeks4geeks')

# get cursor by cursor() method
cursor = conn.cursor()

<<<<<<< HEAD
'''
query = "ALTER TABLE TRANSFER ADD person varchar(50);"
cursor.execute(query)

query1 = "UPDATE TRANSFER SET person = 'chris ham' WHERE DATE = '2022-09-01'"
cursor.execute(query1)
'''
=======

query = "ALTER TABLE TRANSFER ADD person varchar(50);"
cursor.execute(query)

query1 = "UPDATE TRANSFER SET person = 'john doe' WHERE DATE = '2022-09-03'"
cursor.execute(query1)

>>>>>>> 9a5fd11788cec69c618fd01bb41c851aedb85ccd


cursor.execute("SELECT * FROM TRANSFER")
result = cursor.fetchall()

for row in result:
    print(row)

conn.commit()




conn.close()
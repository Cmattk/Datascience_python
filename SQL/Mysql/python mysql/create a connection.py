from mysql.connector import connection

conn = connection.MySQLConnection(host = 'localhost',
                                  user = 'root',
                                  password = '@Cmkf2100#',
                                  database = 'mydb')

# preparing a cursor object
cursorObject = conn.cursor()
 
# creating database
cursorObject.execute("CREATE DATABASE geeks4geeks")
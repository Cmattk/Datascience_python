import pandas as pd
import mysql.connector

# Step 1: Load and format the CSV
df = pd.read_csv("C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Transfer.csv")
df['DATE'] = pd.to_datetime(df['DATE']).dt.strftime('%Y-%m-%d')

# Step 2: Connect to MySQL
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='@Cmkf2100#',
    database='geeks4geeks'
)

cursor = conn.cursor()

# Step 3: Create table (if not exists)
cursor.execute("""
CREATE TABLE IF NOT EXISTS TRANSFER (
    DATE DATE,
    TOTAL_TIME INT,
    HOURS INT,
    MINUTES INT
);
""")
conn.commit()



# Insert data into table

for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO TRANSFER (DATE, TOTAL_TIME, HOURS, MINUTES)
        VALUES (%s, %s, %s, %s);
    """, (row['DATE'], row['TOTAL_TIME'], row['HOURS'], row['MINUTES']))

conn.commit()

print("Data inserted successfully!")



# Select and display all data
cursor.execute("SELECT * FROM TRANSFER")
results = cursor.fetchall()

# Display as a formatted table using pandas
df_results = pd.DataFrame(results, columns=['DATE', 'TOTAL_TIME', 'HOURS', 'MINUTES'])
print("\n--- TRANSFER Table ---")
print(df_results)


# Cleanup
cursor.close()
conn.close()






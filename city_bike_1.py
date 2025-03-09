import psycopg2
import pandas as pd

DB_HOST = "fhtw-big-data.postgres.database.azure.com"
DB_PORT = "5432"
DB_NAME = "nyt_import"
DB_USER = "ds24m024"
DB_PASSWORD = ""

conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)

cursor = conn.cursor()

cursor.execute("SELECT schema_name FROM information_schema.schemata;")
schemas = cursor.fetchall()
print(schemas)

cursor.execute("SET search_path TO m024;")
conn.commit()

cursor.execute("SELECT * FROM city_bike_data LIMIT 5;")
data = cursor.fetchall()
print(data)

columns = ['tripduration', 'starttime', 'stoptime', 'start station id', 'start station name', 'start station latitude', 
           'start station longitude', 'end station id', 'end station name', 'end station latitude', 'end station longitude', 
           'bikeid', 'usertype', 'birth year', 'gender']

df = pd.DataFrame(data, columns=columns)

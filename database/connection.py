import pymysql
import os
from dotenv import load_dotenv

def get_connection():
    try:
        load_dotenv()
        host = os.getenv('DB_HOST')
        user = os.getenv('DB_USER')
        password = os.getenv('DB_PASSWORD')
        database = os.getenv('DB_NAME')
        port = int(os.getenv('DB_PORT'))

        return pymysql.connect(
            host= host,
            user= user,
            password= password,
            database= database,
            port= port
        )
    except pymysql.MySQLError as e:
        print(f"Database connection failed: {e}")
        return None
if __name__ == '__main__':
    connection = get_connection()
    if connection:
        print('Database connected successfully!')

        connection.close()
        print('Database connection closed')
    else:
        print('Unable to connect to database!')
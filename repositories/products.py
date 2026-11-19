import pymysql
from database.connection import get_connection

def get_all_products():

    connection = get_connection()

    if connection is None:
        return None

    try:
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        query = 'select * from products'
        cursor.execute(query)
        products = cursor.fetchall()
        return products
    
    except pymysql.MySQLError as e:
        print(f'Error retrieving products: {e}')
        return None
    
    finally:
        if connection:
            connection.close()


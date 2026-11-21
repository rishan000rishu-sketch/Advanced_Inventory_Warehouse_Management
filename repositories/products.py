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

def create_product(product_name,sku,category,price):
    connection = get_connection()

    if connection is None:
        return None

    try:
        with connection.cursor() as cursor:

            check_query = """
                SELECT product_id FROM products
                WHERE sku = %s
            """

            cursor.execute(check_query,(sku,))

            if cursor.fetchone():
                print(f'SKU {sku} already exists!')
                return None

            query = """
                INSERT INTO products (product_name,sku,category,price)
                VALUES(%s,%s,%s,%s)
            """

            cursor.execute(query,(product_name,sku,category,price))

            connection.commit()
            return cursor.lastrowid

    except pymysql.err.IntegrityError as e:
        connection.rollback()
        print(f'Integrity error: {e}')
        return None

    except pymysql.MySQLError as e:
        connection.rollback()
        print(f'Database error: {e}')
        return None

    finally:
        connection.close()

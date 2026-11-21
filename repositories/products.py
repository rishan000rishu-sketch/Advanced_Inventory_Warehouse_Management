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

def get_product_by_sku(sku):

    connection = get_connection()

    if connection is None:
        return None

    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:

            query = """
                SELECT *
                FROM products
                WHERE sku = %s
            """

            cursor.execute(query, (sku,))
            return cursor.fetchone()

    except pymysql.MySQLError as e:
        print(f"Error finding product: {e}")
        return None

    finally:
        connection.close()

def update_product(product_id,product_name,category,price):
    connection  = get_connection()

    if connection is None:
        return False

    try:
        with connection.cursor() as cursor:
            query = """
                UPDATE products
                SET product_name = %s,
                    category = %s,
                    price = %s
                WHERE product_id = %s
            """

            cursor.execute(query,(product_name,category,price,product_id))

            connection.commit()

            return cursor.rowcount > 0

    except pymysql.MySQLError as e:
        connection.rollback()
        print(f'Update error: {e}')
        return False

    finally:
        connection.close()
        
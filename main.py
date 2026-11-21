from repositories.products import (
    get_all_products
)

def main():

    products = get_all_products()

    if products is None:
        print('Unable to retrieve products')

    elif not products:
        print('Products not found !')

    else:
        for product in products:
            print(product)

if __name__=='__main__':
    main()
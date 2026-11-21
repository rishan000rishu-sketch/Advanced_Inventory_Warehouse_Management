from repositories.products import (
    get_all_products,
    create_product
)

def main():

    product_id = create_product(
        "Lenovo Laptop",
        "LAP006",
        "Electronics",
        62000.0
    )

    if product_id:
        print(f'Project created successfully! ID: {product_id}')
    else:
        print('Product creation failed')

    print('\n----- PRODUCT LIST -----')

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
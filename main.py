from repositories.products import (
    get_all_products,
    get_product_by_sku,
    create_product,
    update_product
)

def main():

    product_name = "VICTUS Laptop"
    sku = "LAP015"
    category = "Electronics"
    price = 72000.0

    existing_product = get_product_by_sku(sku)

    product_id = None

    if existing_product is not None:
        product_id = existing_product["product_id"]
        print(f"Product already exists! ID: {product_id}")

    else:
        product_id = create_product(
            product_name,
            sku,
            category,
            price
        )

        if product_id is not None:
            print(f"Product created successfully! ID: {product_id}")
        else:
            print("Product creation failed!")

    print("\n----- PRODUCT LIST -----")

    products = get_all_products()

    if products is None:
        print("Unable to retrieve products")

    elif not products:
        print("Products not found!")

    else:
        for product in products:
            print(product)

    if product_id is not None:

        updated = update_product(
            10,
            "Asus Gaming Laptop",
            "Electronics",
            65000.00
        )

        if updated:
            print("\nProduct updated successfully!")
        else:
            print("\nProduct update failed!")

    print("\n----- UPDATED PRODUCT LIST -----")

    products = get_all_products()

    if products is not None:
        for product in products:
            print(product)

if __name__=='__main__':
    main()
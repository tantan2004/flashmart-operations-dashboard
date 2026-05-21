import pandas as pd
import random

# -----------------------------
# LOAD PRODUCTS
# -----------------------------

products_df = pd.read_csv("data/raw/products.csv")

# -----------------------------
# CONFIGURATION
# -----------------------------

cities = [
    "Hyderabad",
    "Bangalore",
    "Chennai",
    "Mumbai",
    "Delhi"
]

warehouse_mapping = {
    "Hyderabad": "W001",
    "Bangalore": "W002",
    "Chennai": "W003",
    "Mumbai": "W004",
    "Delhi": "W005"
}

# -----------------------------
# GENERATE INVENTORY
# -----------------------------

inventory = []

inventory_counter = 1

for city in cities:

    warehouse_id = warehouse_mapping[city]

    for _, product in products_df.iterrows():

        product_id = product["product_id"]

        stock_available = random.randint(50, 1000)

        reorder_level = random.randint(40, 150)

        inventory.append([
            inventory_counter,
            warehouse_id,
            city,
            product_id,
            stock_available,
            reorder_level
        ])

        inventory_counter += 1

# -----------------------------
# CREATE DATAFRAME
# -----------------------------

inventory_df = pd.DataFrame(
    inventory,
    columns=[
        "inventory_id",
        "warehouse_id",
        "city",
        "product_id",
        "stock_available",
        "reorder_level"
    ]
)

# -----------------------------
# SAVE CSV
# -----------------------------

inventory_df.to_csv(
    "data/raw/inventory.csv",
    index=False
)

print("Inventory dataset created successfully!")
print(inventory_df.head())
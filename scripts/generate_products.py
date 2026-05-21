import pandas as pd
import numpy as np
import random

# -----------------------------
# PRODUCT CATEGORIES
# -----------------------------

categories = {
    "Dairy": [
        "Milk", "Cheese", "Butter", "Curd", "Paneer"
    ],
    
    "Snacks": [
        "Potato Chips", "Nachos", "Popcorn", "Cookies", "Namkeen"
    ],
    
    "Beverages": [
        "Orange Juice", "Cola", "Green Tea", "Coffee", "Energy Drink"
    ],
    
    "Fruits": [
        "Apple", "Banana", "Mango", "Grapes", "Orange"
    ],
    
    "Vegetables": [
        "Tomato", "Potato", "Onion", "Carrot", "Capsicum"
    ],
    
    "Personal Care": [
        "Shampoo", "Soap", "Face Wash", "Toothpaste", "Body Lotion"
    ],
    
    "Household": [
        "Detergent", "Floor Cleaner", "Dish Wash", "Tissue Paper", "Garbage Bags"
    ],
    
    "Frozen Food": [
        "Frozen Pizza", "Ice Cream", "Frozen Fries", "Frozen Nuggets", "Frozen Peas"
    ]
}

# -----------------------------
# GENERATE PRODUCTS
# -----------------------------

products = []

product_counter = 1

for category, items in categories.items():
    
    for item in items:
        
        # Generate multiple variants
        for i in range(10):
            
            product_id = f"P{product_counter:03d}"
            
            unit_cost = round(random.uniform(20, 500), 2)
            
            markup = random.uniform(1.15, 1.60)
            
            selling_price = round(unit_cost * markup, 2)
            
            margin_pct = round(
                ((selling_price - unit_cost) / selling_price) * 100,
                2
            )
            
            product_name = f"{item} Variant {i+1}"
            
            products.append([
                product_id,
                category,
                product_name,
                unit_cost,
                selling_price,
                margin_pct
            ])
            
            product_counter += 1

# -----------------------------
# CREATE DATAFRAME
# -----------------------------

products_df = pd.DataFrame(
    products,
    columns=[
        "product_id",
        "category",
        "product_name",
        "unit_cost",
        "selling_price",
        "margin_pct"
    ]
)

# -----------------------------
# SAVE CSV
# -----------------------------

products_df.to_csv(
    "data/raw/products.csv",
    index=False
)

print("Products dataset created successfully!")
print(products_df.head())
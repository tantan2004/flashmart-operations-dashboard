import pandas as pd
import numpy as np
import random
from faker import Faker
from datetime import timedelta

fake = Faker()

# -----------------------------
# LOAD EXISTING DATA
# -----------------------------

customers_df = pd.read_csv("data/raw/customers.csv")
products_df = pd.read_csv("data/raw/products.csv")

# -----------------------------
# CONFIGURATION
# -----------------------------

NUM_ORDERS = 75000

cities = [
    "Hyderabad",
    "Bangalore",
    "Chennai",
    "Mumbai",
    "Delhi"
]

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Cash on Delivery"
]

delivery_statuses = [
    "Delivered",
    "Cancelled"
]

warehouse_ids = [
    "W001",
    "W002",
    "W003",
    "W004",
    "W005"
]

# -----------------------------
# GENERATE ORDERS
# -----------------------------

orders = []

for i in range(1, NUM_ORDERS + 1):

    order_id = f"O{i:06d}"

    customer = customers_df.sample(1).iloc[0]
    product = products_df.sample(1).iloc[0]

    customer_id = customer["customer_id"]
    city = customer["city"]

    product_id = product["product_id"]

    warehouse_id = random.choice(warehouse_ids)

    order_datetime = fake.date_time_between(
        start_date='-1y',
        end_date='now'
    )

    order_date = order_datetime.date()

    # -----------------------------
    # DELIVERY LOGIC
    # -----------------------------

    delivery_time_mins = random.randint(10, 90)

    delivery_status = random.choices(
        delivery_statuses,
        weights=[92, 8],
        k=1
    )[0]

    # -----------------------------
    # FINANCIALS
    # -----------------------------

    base_price = product["selling_price"]

    quantity = random.randint(1, 5)

    gross_value = base_price * quantity

    discount = round(
        gross_value * random.uniform(0.00, 0.20),
        2
    )

    delivery_fee = round(
        random.uniform(20, 70),
        2
    )

    order_value = round(
        gross_value - discount + delivery_fee,
        2
    )

    # -----------------------------
    # PAYMENT METHOD
    # -----------------------------

    payment_method = random.choice(payment_methods)

    # -----------------------------
    # CUSTOMER RATING
    # -----------------------------

    if delivery_status == "Cancelled":
        customer_rating = 1
    else:
        customer_rating = random.choices(
            [3, 4, 5],
            weights=[15, 35, 50],
            k=1
        )[0]

    # -----------------------------
    # APPEND ORDER
    # -----------------------------

    orders.append([
        order_id,
        customer_id,
        product_id,
        city,
        warehouse_id,
        order_date,
        order_datetime,
        delivery_time_mins,
        order_value,
        discount,
        delivery_fee,
        payment_method,
        delivery_status,
        customer_rating
    ])

# -----------------------------
# CREATE DATAFRAME
# -----------------------------

orders_df = pd.DataFrame(
    orders,
    columns=[
        "order_id",
        "customer_id",
        "product_id",
        "city",
        "warehouse_id",
        "order_date",
        "order_time",
        "delivery_time_mins",
        "order_value",
        "discount",
        "delivery_fee",
        "payment_method",
        "delivery_status",
        "customer_rating"
    ]
)

# -----------------------------
# SAVE CSV
# -----------------------------

orders_df.to_csv(
    "data/raw/orders.csv",
    index=False
)

print("Orders dataset created successfully!")
print(orders_df.head())
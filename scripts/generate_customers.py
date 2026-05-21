import pandas as pd
import random
from faker import Faker

fake = Faker()

# -----------------------------
# CONFIGURATION
# -----------------------------

NUM_CUSTOMERS = 12000

cities = [
    "Hyderabad",
    "Bangalore",
    "Chennai",
    "Mumbai",
    "Delhi"
]

age_groups = [
    "18-25",
    "26-35",
    "36-45",
    "46-60"
]

loyalty_tiers = [
    "Silver",
    "Gold",
    "Platinum"
]

# -----------------------------
# GENERATE CUSTOMERS
# -----------------------------

customers = []

for i in range(1, NUM_CUSTOMERS + 1):

    customer_id = f"C{i:05d}"

    city = random.choice(cities)

    signup_date = fake.date_between(
        start_date='-2y',
        end_date='today'
    )

    age_group = random.choice(age_groups)

    loyalty_tier = random.choices(
        loyalty_tiers,
        weights=[60, 30, 10],
        k=1
    )[0]

    customers.append([
        customer_id,
        city,
        signup_date,
        age_group,
        loyalty_tier
    ])

# -----------------------------
# CREATE DATAFRAME
# -----------------------------

customers_df = pd.DataFrame(
    customers,
    columns=[
        "customer_id",
        "city",
        "signup_date",
        "age_group",
        "loyalty_tier"
    ]
)

# -----------------------------
# SAVE CSV
# -----------------------------

customers_df.to_csv(
    "data/raw/customers.csv",
    index=False
)

print("Customers dataset created successfully!")
print(customers_df.head())
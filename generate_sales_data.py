"""
Generate Sales Analytics Data for Food Delivery App (Uber Eats-style)
Target: Monthly CSV files for 2023-2025 (100K rows each)
Structure: data/year=YYYY/month=MM/sales_YYYY_MM.csv
"""
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
import os
import calendar

# Configuration
ROWS_PER_MONTH = 100_000
YEARS = [2023, 2024, 2025]
OUTPUT_DIR = "data"

# Seed for reproducibility
np.random.seed(42)
random.seed(42)

# Reference data
CITIES = [
    ("New York", "NY", "USA"),
    ("Los Angeles", "CA", "USA"),
    ("Chicago", "IL", "USA"),
    ("Houston", "TX", "USA"),
    ("Phoenix", "AZ", "USA"),
    ("Philadelphia", "PA", "USA"),
    ("San Antonio", "TX", "USA"),
    ("San Diego", "CA", "USA"),
    ("Dallas", "TX", "USA"),
    ("Miami", "FL", "USA"),
]

RESTAURANT_TYPES = [
    "Fast Food", "Pizza", "Chinese", "Mexican", "Indian",
    "Italian", "Japanese", "Thai", "American", "Mediterranean",
    "Vegan", "Seafood", "BBQ", "Breakfast", "Desserts"
]

PAYMENT_METHODS = ["Credit Card", "Debit Card", "Cash", "Digital Wallet", "Gift Card"]
ORDER_STATUS = ["Delivered", "Delivered", "Delivered", "Delivered", "Cancelled", "Refunded"]
DEVICE_TYPES = ["iOS", "Android", "Web"]
PROMO_CODES = [None, None, None, "SAVE10", "FIRST50", "FREEDEL", "WEEKEND20", None, None]


def generate_month_data(year, month, start_order_id):
    """Generate data for a specific month"""
    n = ROWS_PER_MONTH

    # Get days in this month
    days_in_month = calendar.monthrange(year, month)[1]
    start_date = datetime(year, month, 1)

    # Generate random dates within the month
    random_days = np.random.randint(0, days_in_month, n)
    random_seconds = np.random.randint(0, 86400, n)

    order_datetimes = [
        start_date + timedelta(days=int(d), seconds=int(s))
        for d, s in zip(random_days, random_seconds)
    ]

    # City selection with weights
    city_weights = [0.20, 0.15, 0.12, 0.10, 0.08, 0.08, 0.07, 0.07, 0.07, 0.06]
    city_indices = np.random.choice(len(CITIES), n, p=city_weights)

    # Generate IDs
    order_ids = [f"ORD-{start_order_id + i:010d}" for i in range(n)]
    customer_ids = np.random.randint(1, 500001, n)
    driver_ids = np.random.randint(1, 25001, n)
    restaurant_ids = np.random.randint(1, 10001, n)

    # Generate amounts
    subtotal = np.round(np.random.exponential(25, n) + 8, 2)
    subtotal = np.clip(subtotal, 8, 200)

    delivery_fee = np.where(
        np.random.random(n) < 0.3,
        0,
        np.round(np.random.uniform(2.99, 7.99, n), 2)
    )

    service_fee = np.round(subtotal * np.random.uniform(0.10, 0.18, n), 2)

    tip_pct = np.random.choice([0, 0.10, 0.15, 0.18, 0.20, 0.25], n,
                                p=[0.15, 0.10, 0.25, 0.20, 0.20, 0.10])
    tip_amount = np.round(subtotal * tip_pct, 2)

    discount_amount = np.where(
        np.random.random(n) < 0.25,
        np.round(np.random.uniform(2, 15, n), 2),
        0
    )

    tax_amount = np.round(subtotal * 0.08, 2)
    total_amount = np.round(subtotal + delivery_fee + service_fee + tax_amount + tip_amount - discount_amount, 2)
    total_amount = np.maximum(total_amount, 0)

    # Delivery metrics
    prep_time_minutes = np.random.randint(10, 45, n)
    delivery_time_minutes = np.random.randint(15, 60, n)
    total_time_minutes = prep_time_minutes + delivery_time_minutes
    delivery_distance_miles = np.round(np.clip(np.random.exponential(3, n) + 0.5, 0.5, 20), 2)

    item_count = np.random.choice([1, 2, 3, 4, 5, 6, 7, 8], n,
                                   p=[0.15, 0.30, 0.25, 0.15, 0.08, 0.04, 0.02, 0.01])

    # Ratings
    customer_rating = np.random.choice([0, 3.0, 4.0, 4.5, 5.0], n,
                                        p=[0.40, 0.05, 0.15, 0.20, 0.20])
    driver_rating = np.random.choice([0, 3.0, 4.0, 4.5, 5.0], n,
                                      p=[0.35, 0.05, 0.15, 0.20, 0.25])

    # Flags
    is_first_order = (np.random.random(n) < 0.08).astype(int)
    is_reorder = (np.random.random(n) < 0.35).astype(int)
    is_weekend = np.array([dt.weekday() >= 5 for dt in order_datetimes]).astype(int)

    data = {
        "order_id": order_ids,
        "customer_id": customer_ids,
        "driver_id": driver_ids,
        "restaurant_id": restaurant_ids,
        "order_date": [dt.strftime("%Y-%m-%d") for dt in order_datetimes],
        "order_time": [dt.strftime("%H:%M:%S") for dt in order_datetimes],
        "order_year": year,
        "order_month": month,
        "order_day": [dt.day for dt in order_datetimes],
        "order_hour": [dt.hour for dt in order_datetimes],
        "order_day_of_week": [dt.weekday() for dt in order_datetimes],
        "is_weekend": is_weekend,
        "city": [CITIES[i][0] for i in city_indices],
        "state": [CITIES[i][1] for i in city_indices],
        "country": [CITIES[i][2] for i in city_indices],
        "restaurant_type": np.random.choice(RESTAURANT_TYPES, n),
        "item_count": item_count,
        "subtotal": subtotal,
        "delivery_fee": delivery_fee,
        "service_fee": service_fee,
        "tax_amount": tax_amount,
        "tip_amount": tip_amount,
        "discount_amount": discount_amount,
        "total_amount": total_amount,
        "prep_time_minutes": prep_time_minutes,
        "delivery_time_minutes": delivery_time_minutes,
        "total_time_minutes": total_time_minutes,
        "delivery_distance_miles": delivery_distance_miles,
        "payment_method": np.random.choice(PAYMENT_METHODS, n, p=[0.45, 0.25, 0.05, 0.20, 0.05]),
        "order_status": np.random.choice(ORDER_STATUS, n),
        "device_type": np.random.choice(DEVICE_TYPES, n, p=[0.45, 0.45, 0.10]),
        "promo_code": [p if p else "" for p in np.random.choice(PROMO_CODES, n)],
        "customer_rating": customer_rating,
        "driver_rating": driver_rating,
        "is_first_order": is_first_order,
        "is_reorder": is_reorder,
    }

    return pd.DataFrame(data)


def main():
    total_files = len(YEARS) * 12
    total_rows = total_files * ROWS_PER_MONTH

    print(f"Generating {total_files} monthly files")
    print(f"Rows per file: {ROWS_PER_MONTH:,}")
    print(f"Total rows: {total_rows:,}")
    print(f"Years: {YEARS}")
    print("-" * 50)

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    start_time = datetime.now()
    order_id_counter = 1
    file_count = 0

    for year in YEARS:
        for month in range(1, 13):
            file_count += 1
            filename = f"sales_{year}_{month:02d}.csv"
            filepath = os.path.join(OUTPUT_DIR, filename)

            print(f"[{file_count}/{total_files}] Generating {filename}...")

            df = generate_month_data(year, month, order_id_counter)
            df.to_csv(filepath, index=False)

            order_id_counter += ROWS_PER_MONTH

            # File size check
            file_size_mb = os.path.getsize(filepath) / (1024 * 1024)
            print(f"         Size: {file_size_mb:.2f} MB | Rows: {len(df):,}")

    elapsed = (datetime.now() - start_time).total_seconds()
    print("-" * 50)
    print(f"COMPLETE!")
    print(f"Total time: {elapsed:.1f} seconds")
    print(f"Files created: {file_count}")
    print(f"Location: {os.path.abspath(OUTPUT_DIR)}")

    # Show sample
    print("\nSample columns:")
    sample_file = os.path.join(OUTPUT_DIR, "sales_2023_01.csv")
    df_sample = pd.read_csv(sample_file, nrows=3)
    for col in df_sample.columns:
        print(f"  - {col}")


if __name__ == "__main__":
    main()

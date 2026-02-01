# Sales Analytics Data - Food Delivery App

Synthetic sales data for a food delivery app (Uber Eats-style) used to demonstrate **dbt Jobs vs PySpark Notebooks** in Microsoft Fabric.

## Dataset Overview

| Metric | Value |
|--------|-------|
| Total Rows | 3,600,000 |
| Files | 36 (monthly) |
| Date Range | Jan 2023 - Dec 2025 |
| Rows per File | 100,000 |

## Schema

| Column | Type | Description |
|--------|------|-------------|
| order_id | string | Unique order identifier |
| customer_id | int | Customer identifier |
| driver_id | int | Driver identifier |
| restaurant_id | int | Restaurant identifier |
| order_date | date | Order date (YYYY-MM-DD) |
| order_time | time | Order time (HH:MM:SS) |
| order_year | int | Year |
| order_month | int | Month (1-12) |
| order_day | int | Day of month |
| order_hour | int | Hour (0-23) |
| order_day_of_week | int | Day of week (0=Monday) |
| is_weekend | int | Weekend flag (0/1) |
| city | string | City name |
| state | string | State code |
| country | string | Country |
| restaurant_type | string | Cuisine type |
| item_count | int | Number of items |
| subtotal | decimal | Order subtotal |
| delivery_fee | decimal | Delivery fee |
| service_fee | decimal | Service fee |
| tax_amount | decimal | Tax amount |
| tip_amount | decimal | Tip amount |
| discount_amount | decimal | Discount applied |
| total_amount | decimal | Total order amount |
| prep_time_minutes | int | Food preparation time |
| delivery_time_minutes | int | Delivery time |
| total_time_minutes | int | Total order time |
| delivery_distance_miles | decimal | Delivery distance |
| payment_method | string | Payment type |
| order_status | string | Delivered/Cancelled/Refunded |
| device_type | string | iOS/Android/Web |
| promo_code | string | Promo code used |
| customer_rating | decimal | Customer rating (0-5) |
| driver_rating | decimal | Driver rating (0-5) |
| is_first_order | int | First order flag (0/1) |
| is_reorder | int | Reorder flag (0/1) |

## File Structure

```
data/
├── sales_2023_01.csv
├── sales_2023_02.csv
├── ...
├── sales_2024_01.csv
├── ...
└── sales_2025_12.csv
```

## Usage

This data is used for the blog post: **"dbt Jobs vs PySpark Notebooks in Microsoft Fabric: A Real Performance Comparison"**

## Author

Sulaiman Ahmed - Data Engineer & Microsoft Fabric Specialist

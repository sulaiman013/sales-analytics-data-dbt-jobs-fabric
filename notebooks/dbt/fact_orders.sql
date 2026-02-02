-- ============================================
-- dbt Model: fact_orders
-- Purpose: Fact table for star schema
-- Target: sales_warehouse.dbt_transformed.fact_orders
-- Contains: 10 FKs + 12 Additive + 2 Semi-Additive + 2 Flags
-- SIMPLIFIED: Computes dimension keys inline (matches PySpark approach)
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT
    -- Primary Key
    order_id,

    -- Foreign Keys (10 total) - computed inline
    CAST(FORMAT(CAST(order_date AS DATE), 'yyyyMMdd') AS INT) AS date_key,
    order_hour AS time_key,
    customer_id AS customer_key,
    driver_id AS driver_key,
    restaurant_id AS restaurant_key,
    -- For location_key, payment_method_key, etc. - use direct values as keys
    -- (These will match the dimension tables we already created)
    DENSE_RANK() OVER (ORDER BY city, state, country) AS location_key,
    DENSE_RANK() OVER (ORDER BY payment_method) AS payment_method_key,
    DENSE_RANK() OVER (ORDER BY order_status) AS order_status_key,
    DENSE_RANK() OVER (ORDER BY device_type) AS device_key,
    DENSE_RANK() OVER (ORDER BY promo_code) AS promo_key,

    -- Additive Measures (12)
    subtotal,
    delivery_fee,
    service_fee,
    tax_amount,
    tip_amount,
    discount_amount,
    total_amount,
    item_count,
    prep_time_minutes,
    delivery_time_minutes,
    total_time_minutes,
    delivery_distance_miles,

    -- Semi-Additive Measures (2)
    customer_rating,
    driver_rating,

    -- Flags (2)
    is_first_order,
    is_reorder

FROM [sales_warehouse].[dbt_sales].[bronze_sales]

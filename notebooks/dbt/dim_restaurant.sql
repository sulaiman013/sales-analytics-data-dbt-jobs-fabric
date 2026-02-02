-- ============================================
-- dbt Model: dim_restaurant
-- Purpose: Restaurant dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_restaurant
-- Note: Using ROW_NUMBER to get one restaurant_type per restaurant_id
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

WITH ranked AS (
    SELECT
        restaurant_id,
        restaurant_type,
        ROW_NUMBER() OVER (PARTITION BY restaurant_id ORDER BY restaurant_type) AS rn
    FROM [sales_warehouse].[dbt_sales].[bronze_sales]
)
SELECT
    restaurant_id AS restaurant_key,
    restaurant_id,
    CAST(restaurant_type AS VARCHAR(50)) AS restaurant_type
FROM ranked
WHERE rn = 1

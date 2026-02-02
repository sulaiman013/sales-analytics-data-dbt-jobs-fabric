-- ============================================
-- dbt Model: dim_time
-- Purpose: Time dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_time
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    order_hour AS time_key,
    order_hour AS hour,
    CAST(
        CASE
            WHEN order_hour < 6 THEN 'Night'
            WHEN order_hour < 12 THEN 'Morning'
            WHEN order_hour < 17 THEN 'Afternoon'
            WHEN order_hour < 21 THEN 'Evening'
            ELSE 'Night'
        END AS VARCHAR(20)
    ) AS period,
    CASE WHEN order_hour >= 9 AND order_hour < 17 THEN 1 ELSE 0 END AS is_business_hours
FROM [sales_warehouse].[dbt_sales].[bronze_sales]

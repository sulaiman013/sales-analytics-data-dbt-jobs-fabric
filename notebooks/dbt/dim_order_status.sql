-- ============================================
-- dbt Model: dim_order_status
-- Purpose: Order status dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_order_status
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY order_status) AS order_status_key,
    CAST(order_status AS VARCHAR(50)) AS order_status
FROM [sales_warehouse].[dbt_sales].[bronze_sales]

-- ============================================
-- dbt Model: dim_device
-- Purpose: Device type dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_device
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY device_type) AS device_key,
    CAST(device_type AS VARCHAR(50)) AS device_type
FROM [sales_warehouse].[dbt_sales].[bronze_sales]

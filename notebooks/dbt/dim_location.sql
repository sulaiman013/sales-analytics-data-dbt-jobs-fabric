-- ============================================
-- dbt Model: dim_location
-- Purpose: Location dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_location
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY city, state, country) AS location_key,
    CAST(city AS VARCHAR(100)) AS city,
    CAST(state AS VARCHAR(100)) AS state,
    CAST(country AS VARCHAR(100)) AS country
FROM [sales_warehouse].[dbt_sales].[bronze_sales]

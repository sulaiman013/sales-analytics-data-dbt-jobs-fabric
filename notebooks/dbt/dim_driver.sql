-- ============================================
-- dbt Model: dim_driver
-- Purpose: Driver dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_driver
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    driver_id AS driver_key,
    driver_id
FROM {{ ref('bronze_sales') }}

-- ============================================
-- dbt Model: dim_customer
-- Purpose: Customer dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_customer
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    customer_id AS customer_key,
    customer_id
FROM {{ ref('bronze_sales') }}

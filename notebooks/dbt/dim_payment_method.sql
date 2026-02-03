-- ============================================
-- dbt Model: dim_payment_method
-- Purpose: Payment method dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_payment_method
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY payment_method) AS payment_method_key,
    CAST(payment_method AS VARCHAR(50)) AS payment_method
FROM {{ ref('bronze_sales') }}

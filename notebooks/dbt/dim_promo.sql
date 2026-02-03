-- ============================================
-- dbt Model: dim_promo
-- Purpose: Promo code dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_promo
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY promo_code) AS promo_key,
    CAST(promo_code AS VARCHAR(50)) AS promo_code
FROM {{ ref('bronze_sales') }}

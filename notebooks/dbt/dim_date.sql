-- ============================================
-- dbt Model: dim_date
-- Purpose: Date dimension for star schema
-- Target: sales_warehouse.dbt_transformed.dim_date
-- ============================================

{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT DISTINCT
    CAST(FORMAT(CAST(order_date AS DATE), 'yyyyMMdd') AS INT) AS date_key,
    CAST(order_date AS DATE) AS date,
    order_year AS year,
    DATEPART(QUARTER, order_date) AS quarter,
    order_month AS month,
    CAST(DATENAME(MONTH, order_date) AS VARCHAR(20)) AS month_name,
    order_day AS day,
    order_day_of_week AS day_of_week,
    CAST(DATENAME(WEEKDAY, order_date) AS VARCHAR(20)) AS day_name,
    is_weekend
FROM {{ ref('bronze_sales') }}

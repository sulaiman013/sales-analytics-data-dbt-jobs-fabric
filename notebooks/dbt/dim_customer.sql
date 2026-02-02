{{ config(
    materialized='table',
    schema='dbt_transformed'
) }}

SELECT 
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id
FROM (
    SELECT DISTINCT customer_id
    FROM [sales_warehouse].[dbt_sales].[bronze_sales]
) AS customers

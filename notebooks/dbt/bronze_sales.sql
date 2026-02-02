-- models/bronze_sales.sql
-- Read from Lakehouse, Write to Warehouse

{{ config(materialized='table') }}

SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_01
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_02
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_03
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_04
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_05
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_06
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_07
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_08
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_09
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_10
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_11
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2023_12
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_01
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_02
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_03
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_04
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_05
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_06
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_07
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_08
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_09
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_10
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_11
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2024_12
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_01
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_02
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_03
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_04
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_05
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_06
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_07
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_08
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_09
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_10
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_11
UNION ALL
SELECT * FROM sales_lakehouse.dbo.source_bronze_2025_12

### What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
			-- unique_products_2020
			-- unique_products_2021
			-- percentage_chg

WITH Unique_products AS (
SELECT 
     fiscal_year,
     count(DISTINCT product_code) AS uniq_products 
FROM fact_gross_price 
GROUP BY fiscal_year
),
compare_uni_year AS (
SELECT
     MAX(CASE WHEN fiscal_year =2020 THEN uniq_products END) AS Unique_products_2020,
     MAX(CASE WHEN fiscal_year =2021 THEN uniq_products END) AS Unique_products_2021
FROM
Unique_products)

SELECT 
 unique_products_2020,
 unique_products_2021,
 CONCAT(ROUND((unique_products_2021 - unique_products_2020)/unique_products_2020*100,2)," %") as chg
FROM compare_uni_year




WITH prod_cnt AS (
SELECT 
   gp.fiscal_year,
   p.segment,
   COUNT(DISTINCT(p.product_code)) as uniq_prod_cnt
FROM dim_product p
JOIN fact_gross_price gp
USING (product_code)
GROUP BY p.segment,gp.fiscal_year
ORDER BY uniq_prod_cnt DESC),
fy_prod_cnt AS (
SELECT 
     segment,
     MAX(CASE WHEN fiscal_year = 2020 then uniq_prod_cnt END) AS product_count_2020,
     MAX(CASE WHEN fiscal_year = 2021 then uniq_prod_cnt END) AS product_count_2021
FROM prod_cnt
GROUP BY segment
)
SELECT 
	segment,
    product_count_2020,
    product_count_2021,
    product_count_2021 - product_count_2020 as difference
FROM fy_prod_cnt
ORDER BY difference DESC;
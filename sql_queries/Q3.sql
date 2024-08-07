# Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains2 fields,
					-- segment
					-- product_count
WITH CTE AS (SELECT 
   segment,
   COUNT(DISTINCT(product_code)) as prod_cnt
FROM dim_product
GROUP BY segment
ORDER BY prod_cnt DESC)

SELECT 
 cte.segment, cte.prod_cnt/COUNT(p.PRODUCT_CODE)*100
FROM dim_product p,cte
group by
segment
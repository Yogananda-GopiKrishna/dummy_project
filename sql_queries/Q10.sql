# Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
-- The final output contains these fields,
				-- division
				-- product_code
				-- product
				-- total_sold_quantity
				-- rank_order

WITH cte AS (
SELECT 
    division,
    product_code,
    product,
    SUM(sold_quantity) AS Total_sold_qty
FROM
    dim_product
        JOIN
    fact_sales_monthly USING (product_code)
WHERE
    fiscal_year = 2021
GROUP BY division , product_code , product
),
cte_2 AS (
SELECT 
    * ,
    DENSE_RANK() OVER(PARTITION BY division ORDER BY total_sold_qty DESC) AS rank_order
FROM cte 
)
SELECT 
   * 
FROM cte_2 
WHERE rank_order <= 3;


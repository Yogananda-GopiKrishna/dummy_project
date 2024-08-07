# Which channel helped to bring more gross sales in the fiscal year 2021
-- and the percentage of contribution? The final output contains these fields,
				-- channel
				-- gross_sales_mln
				-- percentage

with gs_channel AS (
SELECT 
    channel, SUM(sold_quantity * gross_price) AS gross_sales
FROM
    dim_customer c
        JOIN
    fact_sales_monthly USING (customer_code)
        JOIN
    fact_gross_price USING (product_code , fiscal_year)
WHERE
    fiscal_year = 2021
GROUP BY channel
),
Total_gs AS (
SELECT 
    SUM(gross_sales) AS total_gross_sales
FROM
    gs_channel
   ) 

SELECT 
    gs_channel.channel,
    CONCAT("$ ",ROUND(gs_channel.gross_sales / 1000000, 2)," M") AS gross_sales_mln,
    CONCAT(ROUND(gs_channel.gross_sales * 100 / Total_gs.total_gross_sales,
            2)," %") AS percentage
FROM
    gs_channel,
    Total_gs
ORDER BY percentage DESC;



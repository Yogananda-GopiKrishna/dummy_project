#In which quarter of 2020, got the maximum total_sold_quantity? 
--  The final output contains these fields sorted by the total_sold_quantity,
			-- Quarter
			-- total_sold_quantity

WITH cte AS (
    SELECT 
        CASE 
            WHEN MONTH(date) IN (9, 10, 11) THEN 'Q1'
            WHEN MONTH(date) IN (12, 1, 2) THEN 'Q2'
            WHEN MONTH(date) IN (3, 4, 5) THEN 'Q3'
            WHEN MONTH(date) IN (6, 7, 8) THEN 'Q4'
        END AS quarter,
        sold_quantity 
    FROM 
        fact_sales_monthly
    WHERE 
        fiscal_year = 2020
)
SELECT 
    quarter,
    concat(round(SUM(sold_quantity)/1000000,2),"M") AS total_sold_quantity
FROM 
    cte
GROUP BY 
    quarter
ORDER BY 
    total_sold_quantity DESC;

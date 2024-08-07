## # Get the complete report of the Gross sales amount for the customer â€œAtliq Exclusiveâ€ for each month. 
-- This analysis helps to get an idea of low and high-performing months and take strategic decisions.
-- The final report contains these columns:
			-- Month
			-- Year
			-- Gross sales Amount


WITH gross_sale_amt_cte AS (
SELECT 
    customer_code,
    concat(MONTHNAME(sm.date),
    YEAR(date)) as month_year,
    sm.fiscal_year,
    (sm.sold_quantity * gp.gross_price) AS gross_sales_amt
FROM
    fact_gross_price gp
        JOIN
    fact_sales_monthly sm USING (product_code)
)

SELECT 
    month_year, fiscal_year, CONCAT("$",ROUND(sum(gross_sales_amt/1000000),2)," M") AS gross_sales_amt_mln
FROM
    gross_sale_amt_cte
        JOIN
    dim_customer USING (customer_code)
WHERE
    customer = 'Atliq Exclusive'
GROUP BY  fiscal_year,month_year
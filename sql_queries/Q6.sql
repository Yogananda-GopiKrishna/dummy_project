#6 Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and 
-- in the Indian market. The final output contains these fields,
			-- customer_code
			-- customer
			-- average_discount_percentage
WITH avg_prein_disc_cust AS (
SELECT 
    customer_code, AVG(pre_invoice_discount_pct) AS Avg_prein_disc
FROM
    fact_pre_invoice_deductions
WHERE
    fiscal_year = 2021
GROUP BY customer_code
 )
SELECT 
    c.customer_code, customer, CONCAT(ROUND(Avg_prein_disc*100,2)," %") AS avg_disc_pct
FROM
    avg_prein_disc_cust 
        JOIN
    dim_customer c USING (customer_code)
WHERE
    market = 'india'
ORDER BY Avg_prein_disc DESC
LIMIT 5;
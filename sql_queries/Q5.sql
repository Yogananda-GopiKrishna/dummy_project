#5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,
			-- product_code
			-- product
			-- manufacturing_cost
SELECT 
    p.product_code, p.product, CONCAT("$ ",ROUND(manufacturing_cost,2)) AS manufacturing_cost
FROM
    fact_manufacturing_cost m
        JOIN
    dim_product p USING (product_code)
WHERE
    manufacturing_cost = (SELECT 
            MAX(manufacturing_cost) AS max_1
        FROM
            fact_manufacturing_cost)
        OR manufacturing_cost = (SELECT 
            MIN(manufacturing_cost) AS min_1
        FROM
            fact_manufacturing_cost)


	
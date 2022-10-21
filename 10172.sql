WITH cte1 AS 
(   
	SELECT EXTRACT(MONTH FROM invoicedate) AS month,
		 price,
		 description
	FROM 
	(
		SELECT SUM(unitprice*quantity) OVER (PARTITION BY description, 
			EXTRACT(MONTH FROM invoicedate)) AS price,
			invoiceno,
			invoicedate, 
			description FROM online_retail
	) helper

	oRDER BY month,
	price DESC
),
-- Showing highest results per month 
result AS (
	SELECT DISTINCT month,
	price,
	RANK() OVER(PARTITION BY month ORDER BY price DESC) as rank,
	description 
	FROM cte1
)
SELECT month, description, price
FROM result
WHERE rank = 1
ORDER BY month
WITH sorted AS (
    SELECT salary,
           department
    FROM twitter_employee
    GROUP BY 2, 1
),
ranked AS (
    SELECT RANK() OVER(PARTITION BY department ORDER BY salary DESC) as rnk,
           department,
           salary
    FROM sorted
)
SELECT department,
       salary
FROM ranked
WHERE rnk <= 3
SELECT res.request_date,
       round(abs(res.dist_to_cost-res.avg_dist_to_cost)::DECIMAL, 2) abs_avg_diff
FROM
    (SELECT trsfm.request_date,
            trsfm.dist_to_cost,
            AVG(dist_to_cost) OVER(PARTITION BY trsfm.request_mnth) AS avg_dist_to_cost
    FROM
        (SELECT *,
                to_char(request_date::date, 'YYYY-MM') as request_mnth,
                (distance_to_travel/monetary_cost) AS dist_to_cost
        FROM uber_request_logs) trsfm
    ) res
GROUP BY res.request_date,
         res.dist_to_cost,
         res.avg_dist_to_cost
ORDER BY res.request_date
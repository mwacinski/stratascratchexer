SELECT COUNT(worker_title), worker_title, affected_from
FROM
(
    SELECT t1.worker_title as worker_title, t1.affected_from as affected_from
    FROM title AS t1
    JOIN title AS t2
    ON t1.worker_ref_id <> t2.worker_ref_id
    WHERE t1.worker_title = t2.worker_title and t1.affected_from = t2.affected_from
) result
GROUP BY 2, 3
select DISTINCT(t1.user_id)
from amazon_transactions t1
join amazon_transactions t2 on t1.user_id = t2.user_id
and t1.id <> t2.id
AND t1.created_at - t2.created_at BETWEEN 0 AND 7
ORDER BY t1.user_id

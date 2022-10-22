SELECT policy_num, state, claim_cost, fraud_score
FROM (
    SELECT RANK() OVER(PARTITION BY state ORDER BY fraud_score DESC) as ranking, policy_num, state, claim_cost, fraud_score
    FROM fraud_score
) ranks
WHERE ranking > 0 and ranking < 6

WITH distinct_users AS
(
SELECT * 
FROM (
    SELECT user1 as username
    FROM fb_messages
    UNION
    SELECT user2 as username
    FROM fb_messages
    ) as distinct_username
),

interaction_counts AS
(
    SELECT du.username, message_sent, message_received, COALESCE(message_sent, 0) + COALESCE(message_received, 0) as total_msg_count
        FROM distinct_users du
        LEFT JOIN (
                SELECT user1, sum(msg_count) as message_sent
                FROM fb_messages
                GROUP BY 1
        ) message_sent 
        ON du.username = message_sent.user1
        LEFT JOIN (
                SELECT user2, sum(msg_count) as message_received
                FROM fb_messages
                GROUP BY 1
        ) message_received
        ON du.username = message_received.user2
        
)

SELECT username, total_msg_count
FROM (
    SELECT username,
           total_msg_count,
           RANK() OVER(ORDER BY total_msg_count DESC) AS msg_count_rank
           FROM interaction_counts
) interaction_ranking
WHERE msg_count_rank < 11
SELECT a.date,
    (
    SUM
        (
        CASE WHEN a.action = 'sent' AND b.action = 'accepted' THEN 1 ELSE NULL END
        ) * 1.0 /
    SUM
        (
    CASE WHEN a.action = 'sent' AND b.action = 'sent' THEN 1 ELSE NULL END
        )
    ) as rate
    FROM fb_friend_requests a, fb_friend_requests b
    WHERE a.user_id_sender = b.user_id_sender
    AND a.user_id_receiver = b.user_id_receiver
    GROUP BY a.DATE
    LIMIT 2
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	gender
FROM
    (SELECT
        gender,
        COUNT(*) num_likes
    FROM
        profiles
    WHERE
        user_id IN
            (SELECT user_id FROM LIKES)
    GROUP BY
        gender
    ORDER BY
        num_likes DESC
    LIMIT 1) AS some_alias;
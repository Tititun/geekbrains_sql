-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	gender
FROM
	(SELECT
		gender,
		COUNT(*) total
	FROM
		(SELECT
			user_id,
			(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender
		FROM
			likes) AS inner_table_1
	GROUP BY
		gender
	ORDER BY
		total DESC
	LIMIT 1) AS inner_table_2;
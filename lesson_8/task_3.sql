-- 5. (по желанию) Подсчитать количество лайков которые получили
-- 10 самых последних сообщений. 

-- не знаю, возможно ли сделать SUM() здесь без вложенного запроса,
-- получается как-то громоздко.

SELECT SUM(likes) FROM
	(SELECT
		COUNT(likes.target_type = 'messages') likes	
	FROM
		messages
	LEFT JOIN likes
		ON likes.target_id = messages.id AND likes.target_type = 'messages'
	GROUP BY
		messages.id
	ORDER BY
		messages.created_at DESC 
	LIMIT 10) AS sub_table;
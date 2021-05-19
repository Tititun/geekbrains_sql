-- 4. Вывести для каждого пользователя количество созданных сообщений, постов,
-- загруженных медиафайлов и поставленных лайков.

SELECT 
	CONCAT(first_name, ' ', last_name) AS name,
	COUNT(DISTINCT messages.id) messages_sent,
	COUNT(DISTINCT posts.id) posts_created,
	COUNT(DISTINCT media.id) mediafiles,
	COUNT(DISTINCT likes.id) likes
FROM
	users
	LEFT JOIN messages
		ON users.id = messages.from_user_id
	LEFT JOIN posts
		ON users.id = posts.user_id 
	LEFT JOIN media
		ON users.id = media.user_id 
	LEFT JOIN likes
		ON users.id = likes.user_id 
GROUP BY 
	name
ORDER BY
	messages_sent DESC,
	posts_created DESC,
	mediafiles DESC,
	likes DESC;
		
	









-- 4. Вывести для каждого пользователя количество созданных сообщений, постов,
-- загруженных медиафайлов и поставленных лайков.

SELECT
	(SELECT CONCAT(first_name, ' ', last_name) FROM profiles WHERE user_id = users.id) AS user,
	(SELECT COUNT(*) FROM messages WHERE from_user_id = users.id) AS messages,
	(SELECT COUNT(*) FROM posts WHERE user_id = users.id) AS posts,
	(SELECT COUNT(*) FROM media WHERE user_id = users.id) AS mediafiles,
	(SELECT COUNT(*) FROM likes WHERE user_id = users.id) AS likes
FROM
	users
ORDER BY
	messages DESC,
	posts DESC,
	mediafiles DESC,
	likes DESC;
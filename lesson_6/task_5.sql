-- 5. (по желанию) Подсчитать количество лайков которые получили
-- 10 самых последних сообщений. 

SELECT
	COUNT(*)
FROM
	LIKES
WHERE
	target_type = 'messages'
AND
	target_id IN (SELECT id FROM (SELECT id FROM messages ORDER BY created_at DESC LIMIT 10) subtable);
	-- сначала пробовал следующий фильтр:
	-- target_id IN (SELECT id FROM messages ORDER BY created_at DESC LIMIT 10);
	-- но получил ошибку:
	-- 'SQL Error [1235] [42000]: This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
	-- пришлось немного почитать stackoverflow, чтобы создать правильный запрос

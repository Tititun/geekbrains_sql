-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
	gender
FROM 
	likes
JOIN
	profiles
	ON
		likes.user_id = profiles.user_id 
GROUP BY 
	gender
ORDER BY 
	COUNT(*) DESC
LIMIT 1;

		














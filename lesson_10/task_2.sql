-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- (сумма количестива пользователей во всех группах делённая на количество групп)
-- самый молодой пользователь в группе (желательно вывести имя и фамилию)
-- самый старший пользователь в группе (желательно вывести имя и фамилию)
-- количество пользователей в группе
-- всего пользователей в системе (количество пользователей в таблице users)
-- отношение в процентах для последних двух значений 
-- (общее количество пользователей в группе / всего пользователей в системе) * 100


-- Почему, если пытаться выбирать самого старшего пользователя при помощи LAST_VALUE:
-- LAST_VALUE(CONCAT(users.first_name, ' ', users.last_name)) OVER (w_community ORDER BY profiles.birthday) AS oldest
-- то в итоговой таблице получается намного больше рядов, и все пользователи которые есть в группе идут в колонку oldest?
-- однако всё получается, если использовать ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING


SELECT 
	DISTINCT communities.id AS group_name,
	COUNT(cu.user_id) OVER() / (SELECT COUNT(*) FROM communities) AS average_users,
	FIRST_VALUE(CONCAT(users.first_name, ' ', users.last_name)) OVER (w_community ORDER BY profiles.birthday) AS youngest,
	LAST_VALUE(CONCAT(users.first_name, ' ', users.last_name)) OVER 
		(w_community ORDER BY profiles.birthday ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS oldest,
 	COUNT(users.id) OVER w_community AS total_members,
 	(SELECT COUNT(*) FROM users) AS total_users,
 	(COUNT(users.id) OVER w_community / (SELECT COUNT(*) FROM users)) * 100 AS members_to_users
FROM 
	(communities
	LEFT JOIN communities_users cu
		ON communities.id = cu.community_id 
	LEFT JOIN users
		ON users.id = cu.user_id
	LEFT JOIN profiles 
		ON users.id = profiles.user_id)
	WINDOW w_community AS (PARTITION BY communities.id);

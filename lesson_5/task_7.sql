-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
	DATE_FORMAT(DATE_FORMAT(birthday_at, CONCAT(YEAR(NOW()), '-', '%m-%d')), '%a') AS day_name,
	COUNT(*) AS total
FROM users
GROUP BY day_name;


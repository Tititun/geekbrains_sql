-- показать пять самых популярных тем за год

SELECT 
	s.name subject_name,
	COUNT(*) total
FROM
	article_subject a_s
	JOIN subjects s
		ON a_s.subject_id = s.id 
GROUP BY 
	subject_name
ORDER BY total DESC
LIMIT 5;


-- вывести дату издания, название и количество статей для каждого выпуска
SELECT DISTINCT
	issues.id,
	issues.title,
	issues.published_at ,
	COUNT(*) OVER (issue_group) AS issue_number
FROM
	article_subject a_s
	LEFT JOIN subjects s
		ON a_s.subject_id = s.id 
	LEFT JOIN articles art
		ON a_s.article_id = art.id
	LEFT JOIN issues
		ON art.issue_id = issues.id
WINDOW issue_group AS (PARTITION BY issues.id);

-- выбрать 10 самых продуктивных авторов за этот год
SELECT 
	authors.name AS name,
	COUNT(article_id) articles_number
FROM
	article_author 
	JOIN authors 
		ON author_id = authors.id 
GROUP BY 
	name
ORDER BY 
	articles_number DESC
LIMIT 10;


-- выбрать названия и ссылки на статьи, в написании которых участвовали авторы из России
SELECT 
	DISTINCT title,
	CONCAT('https://www.nature.com/articles/', article_id) AS  url
FROM
	article_author 
	JOIN articles 
	ON article_id = articles.id
WHERE 
	author_id IN (SELECT author_id FROM
				  (SELECT
					author_id
				  FROM
				  	author_organization
				  	JOIN organizations
				  		ON author_organization.organization_id = organizations.id
				  	WHERE
				  	  organizations.address LIKE '%Russia')author_id);

-- Представление о числе статей, представленных разными организациями

CREATE OR REPLACE VIEW org_productivity
	AS SELECT
		organizations.name AS org_name,
		COUNT(*) total
	FROM 
		article_author aa
		JOIN author_organization  ao
			ON aa.author_id = ao.author_id
		JOIN organizations 
			ON ao.organization_id = organizations.id
		JOIN articles
			ON aa.article_id = articles.id 
	GROUP BY org_name
		ORDER BY total DESC;

-- Показать пять организаций с наибольшим количеством статей
SELECT * FROM org_productivity LIMIT 5;


-- представление, показывающее новые топики в этом месяце, которые не затрагивали в прошлом месяце
CREATE OR REPLACE VIEW new_subjects
	AS SELECT 
		DISTINCT name
	FROM
		article_subject ars 
		JOIN subjects
			ON ars.subject_id = subjects.id 
		JOIN articles 
			ON ars.article_id = articles.id
	WHERE
		MONTH(created_at) = MONTH(NOW())
		AND name NOT IN 
				(SELECT name FROM
					(SELECT	name
					FROM
						article_subject ars 
					JOIN subjects
						ON ars.subject_id = subjects.id 
					JOIN articles 
						ON ars.article_id = articles.id
					WHERE
						MONTH(created_at) = MONTH(date_sub(NOW(), INTERVAL 2 MONTH)))AS st);

SELECT * FROM new_subjects;					

	


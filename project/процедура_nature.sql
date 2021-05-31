-- процедура для получения ссылок на статьи автора по имени

DELIMITER //

CREATE PROCEDURE get_article_by_author(IN author_name VARCHAR(255))
BEGIN
	SELECT 
		CONCAT('https://www.nature.com/articles/', articles.id) AS urls
	FROM
		article_author 
		JOIN articles 
			ON article_author.article_id = articles.id 
		JOIN authors 
			ON article_author.author_id = authors.id
	WHERE authors.name LIKE CONCAT('%', author_name, '%');
END//

DELIMITER ;


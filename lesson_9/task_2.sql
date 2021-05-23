-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW show_name AS
	SELECT
		products.name AS name,
		catalogs.name AS catalog_name
	FROM
		products JOIN catalogs 
		ON products.catalog_id = catalogs.id;

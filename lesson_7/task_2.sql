-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
	p.name,
	p.desсription,
	p.price,
	c.name AS catalog,
	p.created_at,
	p.updated_at
FROM
	products p
JOIN
	catalogs c 
ON p.catalog_id = c.id;



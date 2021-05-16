-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- Сначала создадим таблицы и заполним их данными:

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(255) PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO	cities VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');


DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(255),
	`to` VARCHAR(255),
	CONSTRAINT flights_from_city FOREIGN KEY (`from`) REFERENCES cities(label) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT flights_to_city FOREIGN KEY (`to`) REFERENCES cities(label) ON DELETE SET NULL ON UPDATE CASCADE
	);

INSERT INTO	flights (`from`, `to`) VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

SELECT
	id,
	cities_from.name AS `from`,
	cities_to.name AS `to`
FROM flights f 
JOIN cities cities_from 
	ON `from` = cities_from.label
JOIN cities cities_to
	ON `to` = cities_to.label;

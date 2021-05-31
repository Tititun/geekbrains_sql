CREATE TABLE logs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	table_name VARCHAR(30) NOT NULL,
	table_key_id INT UNSIGNED NOT NULL,
	name VARCHAR(255)
) ENGINE = Archive;


-- каждый триггер создавался в отдельном файле с использованием DELIMITER //

CREATE TRIGGER users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, 'users', NEW.id, NEW.name);
END;


CREATE TRIGGER products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, 'products', NEW.id, NEW.name);
END;


CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, 'catalogs', NEW.id, NEW.name);
END;

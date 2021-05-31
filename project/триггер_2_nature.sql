-- триггер, не позволяющий вставить в таблицу media ссылку, не начинающуюся со слова 'media'

DELIMITER //

DROP TRIGGER IF EXISTS media_insert//
CREATE TRIGGER media_insert BEFORE INSERT ON media
FOR EACH ROW
BEGIN
	IF NEW.url NOT LIKE 'media%' THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'url media должен наачинаться со слова media';
	END IF;
END//

DELIMITER ;
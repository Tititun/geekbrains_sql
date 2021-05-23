-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

-- почему-то выдает ошибку в синтаксисе: SQL Error [1064] [42000]: You have an error in your SQL syntax; 

DELIMITER //


DROP TRIGGER IF EXISTS null_check//
CREATE TRIGGER null_check BEFORE UPDATE ON products
FOR EACH ROW 
	BEGIN 
		IF NEW.name IS NULL AND NEW.description IS NULL THEN
			SIGNAL SQLSTATE = '45000'
			SET MESSAGE_TEXT = 'Either name or description should not be null';
		END IF;
	END//

DELIMITER ;


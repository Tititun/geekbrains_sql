-- триггер предназначен для предотвращения обновления даты статьи на дату новеее,
-- чем вышел журнал, сожержащий статью

DELIMITER //

DROP TRIGGER IF EXISTS articles_update//
CREATE TRIGGER articles_update BEFORE UPDATE ON articles
FOR EACH ROW
BEGIN
	DECLARE issueID INT;
	SET @issueID = NEW.issue_id;
	IF NEW.created_at > (SELECT published_at FROM issues WHERE id = @issueID) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Статья не может быть младше журнала';
	END IF;
END//

DELIMITER ;
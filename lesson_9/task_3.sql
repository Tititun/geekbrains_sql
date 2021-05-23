-- Пусть имеется таблица с календарным полем created_at.
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
-- если дата присутствует в исходном таблице и 0, если она отсутствует.


-- использовал вариант с созданием временной таблицы

DELIMITER //

DROP PROCEDURE IF EXISTS august_dates//
CREATE PROCEDURE august_dates()
BEGIN
  DECLARE my_date DATE DEFAULT '2021-08-01';
  DROP TEMPORARY TABLE IF EXISTS august;
  CREATE TEMPORARY TABLE august (day DATE, value INT);
  WHILE DATE_FORMAT(my_date, '%M') = 'August' DO
    INSERT INTO august VALUES (my_date, IF((SELECT COUNT(*) FROM products WHERE created_at = DATE(my_date)) > 0, 1, 0));
    SET my_date = DATE_ADD(my_date, INTERVAL 1 DAY);
  END WHILE;
  SELECT * FROM august;
END//

DELIMITER ;

CALL august_dates();
	

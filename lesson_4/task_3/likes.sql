-- Насколько я понял, систему лайков нужно было создать не для нашей базы вконтакте,
-- а в каком-то абстрактном виде.
-- Придумал такоую таблицу, где некий пользователь user_id может поставить лайк чему-то из предложенного:
-- 'publication', 'media', 'comment'
-- показателем состояния лайка будет поле is_liked на случай, если пользователь уберет свой лайк.


CREATE TABLE likes (
	user_id INT UNSIGNED NOT NULL,
	entry_type ENUM('publication', 'media', 'comment') COMMENT 'сущности, которым можно поставить лайк',
	entry_id INT UNSIGNED NOT NULL,
	is_liked BOOLEAN NOT NULL DEFAULT 1,
	date_created DATETIME DEFAULT CURRENT_TIMESTAMP(),
	date_updated DATETIME,
	PRIMARY KEY (user_id, entry_type, entry_id)
);
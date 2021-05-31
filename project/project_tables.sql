-- категории - разделы журнала, в которых публикуются статьи
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name VARCHAR(100) NOT NULL COMMENT 'название раздела журнала, в котором опубликована статья',
	CONSTRAINT categories_pk PRIMARY KEY (id)
);

-- тома журналов
DROP TABLE IF EXISTS volumes;
CREATE TABLE volumes (
	id INT UNSIGNED NOT NULL,
	published_at DATE NOT NULL,
	url VARCHAR(255) NOT NULL,
	CONSTRAINT volumes_pk PRIMARY KEY (id)
);

-- таблица хранения ссылок на медиа
DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	url VARCHAR(255) NOT NULL COMMENT 'ссылка на хранимый медиа-файл',
	CONSTRAINT media_pk PRIMARY KEY (id),
	CONSTRAINT media_unique_url UNIQUE KEY (url),
	INDEX (url)	-- решил проиндексировать, потому что часто выполняется поиск поиск по этому столбцу при вставке
);

-- таблица хранения выпусков журнала
DROP TABLE IF EXISTS issues;
CREATE TABLE issues (
	id INT UNSIGNED NOT NULL,
	volume_id INT UNSIGNED NOT NULL,
	title VARCHAR(255) NOT NULL COMMENT 'название журнала',
	description TEXT NOT NULL COMMENT 'описание журнала',
	published_at DATE NOT NULL,
	url VARCHAR(200) NOT NULL,
	media_id INT UNSIGNED,
	CONSTRAINT issues_pk PRIMARY KEY (id),
	CONSTRAINT issues_FK FOREIGN KEY (volume_id) REFERENCES volumes(id),
	CONSTRAINT issues_media_id FOREIGN KEY (media_id) REFERENCES media(id),
	INDEX (title),	-- аналогично с индексом из таблицы медиа, идет частый поиск по жтому столбцу при вставке данных
	INDEX (url)	
);

-- таблица хранения топиков статей
DROP TABLE IF EXISTS subjects;
CREATE TABLE subjects (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name VARCHAR(150) NOT NULL,
	CONSTRAINT subjects_pk PRIMARY KEY (id),
	CONSTRAINT subjects_unique UNIQUE KEY (name)
);

-- основная сущность - научная статья
-- может оказаться спорным отсутствие стобца url, но сссы
DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
	id VARCHAR(100) NOT NULL,
	issue_id INT UNSIGNED NOT NULL COMMENT 'ссылка на выпуск журнала, содержащий данную статью',
	category_id INT UNSIGNED NULL COMMENT 'ссылка на название раздела журнала, содержащего данную статью',
	title VARCHAR(255) NOT NULL COMMENT 'название статьи',
	body TEXT NULL COMMENT 'содержание статьи',
	is_paid BOOL NULL COMMENT 'индикатор - находится ли статья в латном (1) или бесплатном (0) доступе',
	created_at DATE NOT NULL COMMENT 'дата публикации статьи',
	CONSTRAINT articles_pk PRIMARY KEY (id),
	CONSTRAINT articles_issues_id_issues_id FOREIGN KEY (issue_id) REFERENCES issues(id),
	CONSTRAINT articles_category_id_categories_id FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
	INDEX (title)
);

DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,	-- не разбиваю здесь имя на имя, фамилию, потому что использую их из одного поля, как указано на сайте
	CONSTRAINT authors_pk PRIMARY KEY (id),
	CONSTRAINT authors_unique_name UNIQUE KEY (name) -- знаю, что использовать имя и фамилию как уникадьный ключ нехорошо,
	 												 -- но другого идентификатора вебсайт не предлагает, а фейковать данные я не хотел
);


DROP TABLE IF EXISTS organizations;
CREATE TABLE organizations (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	address TEXT NULL COMMENT 'полный адрес организации',
	CONSTRAINT organization_pk PRIMARY KEY (id),
	CONSTRAINT organization_unique_name UNIQUE KEY (name)
);

-- таблица для связи аторов и организаций
DROP TABLE IF EXISTS author_organization;
CREATE TABLE author_organization (
	author_id INT UNSIGNED NOT NULL,
	organization_id INT UNSIGNED NOT NULL,
	CONSTRAINT author_organization_author_id FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE,
	CONSTRAINT author_organization_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE
);

-- таблица для связи статей и авторов, каждая статья обычно имеет много авторов
DROP TABLE IF EXISTS article_author;
CREATE TABLE article_author (
	article_id VARCHAR(100) NOT NULL,
	author_id INT UNSIGNED NOT NULL,
	CONSTRAINT article_author_article_id FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT article_author_author_id FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- таблица для связи статеей и тем, котоых статья касается
DROP TABLE IF EXISTS article_subject;
CREATE TABLE article_subject (
	article_id VARCHAR(100) NOT NULL,
	subject_id INT UNSIGNED NOT NULL,
	CONSTRAINT article_subject_article_id FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT article_subject_subject_id FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- табллица указывает, какие статьи (to_article) рекомендуется почитать на странице from_article
-- я не стал накладывать ограничение на to_article на случай, если этой статьи не будет у меня в базе данных,
-- но в практических условиях, конечно, эта to_article тоже является внешним ключом 
DROP TABLE IF EXISTS recommendations;
CREATE TABLE recommendations (
	from_article VARCHAR(100) NOT NULL,
	to_article VARCHAR(100) NOT NULL,
	CONSTRAINT recommendations_from_article FOREIGN KEY (from_article) REFERENCES articles(id)
);

-- таблица ссылок между статьями и медиа. Одна статья может иметь ссылки на множество медиа файлов
DROP TABLE IF EXISTS article_media;
CREATE TABLE article_media (
	article_id VARCHAR(100) NOT NULL,
	media_id INT UNSIGNED NOT NULL,
	CONSTRAINT article_media_article_id FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT article_media_media_id FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE
);


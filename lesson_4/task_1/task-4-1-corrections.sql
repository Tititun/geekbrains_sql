SELECT * FROM communities;
UPDATE communities SET updated_at = NOW() WHERE created_at > updated_at;


SELECT * FROM communities_users;
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 100);
UPDATE communities_users SET user_id = FLOOR(1 + RAND() * 2000);


SELECT * FROM media;
UPDATE media SET filename = CONCAT(
	'https://myarchive.com/',
	filename 
);
UPDATE media SET updated_at = NOW() WHERE created_at > updated_at;
UPDATE media SET size = FLOOR(RAND() * 10000) WHERE SIZE < 1000;
UPDATE media SET metadata = CONCAT(
	'{"origin":"',
	(SELECT name FROM countries ORDER BY RAND() LIMIT 1),
	'"}'
);
ALTER TABLE media MODIFY COLUMN metadata JSON;


UPDATE media_types SET updated_at = NOW() WHERE created_at > updated_at;
UPDATE friendship_statuses SET updated_at = NOW() WHERE created_at > updated_at;


SELECT * FROM messages;
UPDATE messages SET to_user_id = FLOOR(1 + RAND() * 2000) WHERE from_user_id = to_user_id;


SELECT * FROM profiles;
UPDATE profiles SET updated_at = NOW() WHERE created_at > updated_at;
UPDATE profiles SET birthday = DATE_SUB(NOW(), INTERVAL (FLOOR(RAND() * 365 * 20) + 365 * 18) DAY);


SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE created_at > updated_at;

-- 1. Брой на потребители
SELECT count(*) FROM users;

-- 2. Най-старият потребител
SELECT min(birthDate) FROM users;

-- 3. Най-младият потребител
SELECT max(birthDate) FROM users;

/* 4. Колко юзъра са регистрирани с мейли от abv и колко от gmail
 и колко с различни от двата */
 SELECT count(*) FROM users where email LIKE '%abv%' 
 union 
 SELECT count(*) FROM users WHERE email LIKE '%gmail%'
 union
 SELECT count(*) FROM users WHERE email NOT LIKE '%abv%' AND email NOT LIKE '%gmail%';
 
 -- 5. Кои юзъри са баннати
 SELECT * FROM users
 WHERE isBanned = 1;
 
 -- 6. Изкарайте всички потребители от базата като ги наредите по име в азбучен ред 
 -- и дата на раждане(от най-младия към най-възрастния).
 SELECT * FROM users
 ORDER BY username, birthDate DESC;

 -- 7. Изкарайте всички потребители от базата, на които потребителското име започва с "a".
 SELECT * FROM users
 WHERE username LIKE 'a%';
 
 -- 8. Изкарайте всички потребители от базата, които съдържат "а" в username името си.
 SELECT * FROM users
 WHERE username LIKE '%a%';
 
 -- 9. Изкарайте всички потребители от базата, чието име се състои от 2 имена
 SELECT * FROM users
 WHERE username LIKE '% %';
 
 -- 10. Регистрирайте 1 юзър през UI-а и го забранете след това от базата.
 UPDATE users
 SET isBanned= '1'
 WHERE username LIKE 'katara katara';
 
-- 11. Брой на всички постове
SELECT count(*) FROM posts;

-- 12. Брой на всички постове групирани по статуса на post-a
SELECT postStatus, count(*) FROM posts
GROUP BY postStatus;

-- 13. Намерете поста/овете с най-къс caption
SELECT min(caption) FROM posts;

-- 14. Покажете поста с най-дълъг caption
SELECT postsid, max(caption) FROM posts;

-- 15. Кой потребител има най-много постове. Използвайте join заявка
SELECT u.username, COUNT(p.id) FROM users AS u
JOIN posts AS p
ON p.userId = u.id
GROUP BY username
ORDER BY COUNT(p.id) DESC
LIMIT 1;

-- 16. Кои потребители имат най-малко постове. Използвайте join заявка
SELECT u.username, COUNT(p.id) FROM users AS u
JOIN posts AS p
ON p.userId = u.id
GROUP BY username
HAVING COUNT(p.id) = 1;

-- 17. Колко потребителя с по 1 пост имаме. Използвайте join заявка, having clause и вложени заявки
SELECT u.username, COUNT(p.id) FROM users AS u
JOIN posts AS p
ON p.userId = u.id
GROUP BY username
HAVING COUNT(p.id) = 1;

-- 18. Колко потребителя с по малко от 5 поста имаме. Използвайте join заявка, having clause и вложени заявки

-- 19. Кои са постовете с най-много коментари. Използвайте вложена заявка и where clause

-- 20. Покажете най-стария пост. Може да използвате order или с aggregate function
SELECT * FROM posts
ORDER BY createdAt
LIMIT 1;

-- 21. Покажете най-новия пост. Може с order или с aggregate function
SELECT * FROM posts
ORDER BY createdAt DESC
LIMIT 1;

-- 22. Покажете всички постове с празен caption
SELECT * FROM posts
WHERE caption IS NULL;

-- 23. Създайте потребител през UI-а, добавете му public пост през базата и проверете дали се е създал през UI-а
INSERT INTO posts (caption, coverUrl, postStatus, userID)
VALUES ('example', 'https://i.imgur.com/3H77tqw.jpeg', 'public', 1160);

-- 24. Покажете всички постове и коментарите им ако имат такива
SELECT * FROM posts
LEFT JOIN comments
ON comments.postid=posts.id;

-- 25. Покажете само постове с коментари и самите коментари
SELECT *, c.content FROM posts AS p
RIGHT JOIN comments AS c
ON c.postid = p.id;

-- 26. Покажете името на потребителя с най-много коментари. Използвайте join клауза
SELECT u.username, COUNT(p.commentsCount) FROM users AS u
JOIN posts AS p
ON p.userId = u.id
GROUP BY username
HAVING MAX(commentsCount)
ORDER BY username DESC
LIMIT 1;

-- 27. Покажете всички коментари, към кой пост принадлежат и кой ги е направил. Използвайте join клауза.
SELECT content, p.id AS postId, u.username FROM comments AS c
JOIN posts AS p
ON p.id = c.postId
JOIN users AS u
ON u.id = c.userId;

-- 28. Кои потребители са like-нали най-много постове
SELECT u.username, MAX(ulp.usersId) liked_posts FROM users_liked_posts ulp
JOIN posts p
ON p.id = ulp.postsId
JOIN users u
ON u.id = ulp.usersId
GROUP BY username
ORDER BY usersId DESC
LIMIT 5;

-- 29. Кои постове имат like-ове. Покажете id на поста и caption
SELECT id, caption FROM posts p
RIGHT JOIN users_liked_posts ulp
ON ulp.postsId = p.id
GROUP BY id;
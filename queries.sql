-- Find the boooks written by the given author name, listed from the most recent to the oldest
SELECT * FROM "books"
WHERE "author_id" IN (
    SELECT "id" FROM "users"
    WHERE "username" = 'TowUbukata'
)
ORDER BY "published_date" DESC;


-- Find the books in the given category, listed from the most recent to the oldest
SELECT * FROM "books"
WHERE "category_id" = (
    SELECT "id" FROM "categories"
    WHERE "digit" = '900'
)
ORDER BY "published_date" DESC;


-- Find the posts written by the given user, listed from the most recent to the oldest
SELECT * FROM "posts"
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'PeiYiLin'
)
ORDER BY "post_datetime" DESC;

-- Find the posts related with the given author, listed fro, the most recent to the oldest
SELECT * FROM "posts"
WHERE "book_id" IN (
    SELECT "id" FROM "books"
    WHERE "author_id" = (
        SELECT "id" FROM "users"
        WHERE "username" = 'TowUbukata'
    )
)
ORDER BY "post_datetime" DESC;

-- Add characters
INSERT INTO "characters" ("character")
VALUES
('Reader'),
('Writer'),
('Translator'),
('Publisher');


-- Add categories of books
INSERT INTO "categories" ("digit", "class")
VALUES
('000', 'Generalities'),
('100', 'Philosophy and Psychology'),
('200', 'Religion'),
('300', 'Social Sciences'),
('400', 'Language'),
('500', 'Science'),
('600', 'Technology'),
('700', 'Arts and Recreation'),
('800', 'Literature'),
('900', 'History and Geography');


-- Add new users
INSERT INTO "users" ("displayname", "email", "username", "password", "character")
VALUES
('P.Y.', 'peiyitest@gmail.com', 'PeiYiLin', '2024@!0601', 1),
('T.U.', 'T.U.test@gmail.com', 'TowUbukata', '2024@!0602', 2),
('M.Y.', 'M.Y,test@gmail.com', 'M.Y.X.', '2024@!0602', 3),
('新經典文化', 'NCCtest@gmail.com', 'newculture', '2024@!0602!', 4);


-- Add a new book
INSERT INTO "books" ("name", "category_id", "author_id", "translator_id", "publisher_id", "published_date", "ISBN-10", "ISBN-13")
VALUES
('天地明察', 10, 2, 3, 4, '2013-01-31', NULL, '9789868885462');


-- Add a new post
INSERT INTO "posts" ("user_id", "book_id", "reading_date", "is_deleted", "content", "image_url")
VALUES
(1, 1, '2024-06-02', FALSE, 'A man trys his best to find the mystery of the season', 'http://buildingWebForBooks.com');


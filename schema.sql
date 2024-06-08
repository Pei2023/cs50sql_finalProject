-- Represent roles of users
CREATE TABLE "characters" (
    "id" SMALLSERIAL,
    "character" VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY ("id")
);

-- Represent users' basic information
CREATE TABLE "users" (
    "id" SERIAL,
    "displayname" VARCHAR(32) NOT NULL,
    "email" VARCHAR(320) UNIQUE,
    "username" VARCHAR(32) UNIQUE,
    "password" VARCHAR(32),
    "character" SMALLINT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("character") REFERENCES "characters"("id")
);

-- Represent categories of books
CREATE TABLE "categories" (
    "id" SMALLSERIAL,
    "digit" CHAR(3) NOT NULL CHECK ("digit" ~ '^[0-9]{3}$'),
    "class" VARCHAR(64) NOT NULL UNIQUE,
    PRIMARY KEY ("id")
);


-- Represent books' information
CREATE TABLE "books" (
    "id" SERIAL,
    "name" VARCHAR(256) NOT NULL,
    "category_id" SMALLINT NOT NULL,
    "author_id" INTEGER NOT NULL,
    "translator_id" INTEGER,
    "publisher_id" INTEGER,
    "published_date" DATE,
    "ISBN-10" CHAR(10) UNIQUE,
    "ISBN-13" CHAR(13) UNIQUE,
    PRIMARY KEY("id"),
    FOREIGN KEY("author_id") REFERENCES "users"("id"),
    FOREIGN KEY("translator_id") REFERENCES "users"("id"),
    FOREIGN KEY("publisher_id") REFERENCES "users"("id"),
    FOREIGN KEY ("category_id") REFERENCES "categories"("id")
);

-- Represent users' posts
CREATE TABLE "posts"(
    "id" BIGSERIAL,
    "user_id" INTEGER,
    "book_id" INTEGER,
    "reading_date" DATE,
    "post_datetime" TIMESTAMP DEFAULT current_timestamp,
    "is_deleted" BOOLEAN,
    "content" TEXT,
    "image_url" VARCHAR(256),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("book_id") REFERENCES "books"("id")
);

-- Create index to speed some searches.
CREATE INDEX books_name_idx ON "books" ("name");
CREATE INDEX user_displayname_idx ON "users" ("displayname");
CREATE INDEX post_bookid_idx ON "posts" ("book_id");


-- Create a function to ensure that either ISBN-10 or ISBN-13 must be filled
CREATE OR REPLACE FUNCTION check_ISBN_values()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW."ISBN-10" IS NULL AND NEW."ISBN-13" IS NULL THEN
        RAISE EXCEPTION 'At least one of ISBN-10 or ISBN-13 must have a value.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Create a trigger to ensure that either ISBN-10 or ISBN-13 must be filled
CREATE TRIGGER enforce_ISBN_values
BEFORE INSERT OR UPDATE ON "books"
FOR EACH ROW
EXECUTE FUNCTION check_ISBN_values();

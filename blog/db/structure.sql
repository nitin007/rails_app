CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "commenter" varchar(255), "body" text, "post_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "title" varchar(255), "description" text, "category_id" integer, "users_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "post_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255), "password" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_comments_on_post_id" ON "comments" ("post_id");
CREATE INDEX "index_posts_on_category_id" ON "posts" ("category_id");
CREATE INDEX "index_posts_on_users_id" ON "posts" ("users_id");
CREATE INDEX "index_tags_on_post_id" ON "tags" ("post_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120518104030');

INSERT INTO schema_migrations (version) VALUES ('20120518130520');

INSERT INTO schema_migrations (version) VALUES ('20120519071021');

INSERT INTO schema_migrations (version) VALUES ('20120524071848');

INSERT INTO schema_migrations (version) VALUES ('20120524074241');

INSERT INTO schema_migrations (version) VALUES ('20120524081843');

INSERT INTO schema_migrations (version) VALUES ('20120526055118');
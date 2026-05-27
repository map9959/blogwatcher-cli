DROP TRIGGER IF EXISTS articles_ai;
DROP TRIGGER IF EXISTS articles_ad;
DROP TRIGGER IF EXISTS articles_au;
DROP TABLE IF EXISTS articles_fts;

-- SQLite doesn't support DROP COLUMN before 3.35.0.
-- For a full rollback, the articles table would need to be recreated.
-- Leaving body_text in place is safe for partial rollback.

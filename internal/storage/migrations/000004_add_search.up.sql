ALTER TABLE articles ADD COLUMN body_text TEXT;

CREATE VIRTUAL TABLE articles_fts USING fts5(title, body_text, content='articles', content_rowid='rowid');

INSERT INTO articles_fts(rowid, title, body_text)
    SELECT id, title, COALESCE(body_text, '') FROM articles;

CREATE TRIGGER articles_ai AFTER INSERT ON articles BEGIN
    INSERT INTO articles_fts(rowid, title, body_text) VALUES (new.id, new.title, COALESCE(new.body_text, ''));
END;

CREATE TRIGGER articles_ad AFTER DELETE ON articles BEGIN
    DELETE FROM articles_fts WHERE rowid = old.id;
END;

CREATE TRIGGER articles_au AFTER UPDATE ON articles BEGIN
    UPDATE articles_fts SET title = new.title, body_text = COALESCE(new.body_text, '') WHERE rowid = old.id;
END;

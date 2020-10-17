require './lib/db_connection'
require './db/environment'

DBConnection.exec("ALTER TABLE comments DROP CONSTRAINT comments_bookmark_id_fkey, ADD CONSTRAINT comments_bookmark_id_fkey FOREIGN KEY (bookmark_id) REFERENCES bookmarks(id) ON DELETE CASCADE")

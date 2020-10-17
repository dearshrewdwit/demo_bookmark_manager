require './lib/db_connection'

DBConnection.exec("ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60)")

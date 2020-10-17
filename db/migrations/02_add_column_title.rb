require './lib/db_connection'
require './db/environment'

DBConnection.exec("ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60)")

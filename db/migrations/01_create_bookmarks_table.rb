require './lib/db_connection'
require './db/environment'

DBConnection.exec("CREATE TABLE IF NOT EXISTS bookmarks (id SERIAL PRIMARY KEY, url VARCHAR(60))")

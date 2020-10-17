require './lib/db_connection'
require './db/environment'

DBConnection.exec("CREATE TABLE IF NOT EXISTS comments (id SERIAL PRIMARY KEY, text TEXT, bookmark_id INTEGER REFERENCES bookmarks (id))")

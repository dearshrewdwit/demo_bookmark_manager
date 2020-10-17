require './lib/db_connection'

DBConnection.exec("CREATE TABLE IF NOT EXISTS comments (id SERIAL PRIMARY KEY, text TEXT, bookmark_id INTEGER REFERENCES bookmarks (id))")

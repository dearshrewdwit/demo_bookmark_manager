require './lib/db_connection'
require './db/environment'

DBConnection.exec("CREATE TABLE IF NOT EXISTS tags (id SERIAL PRIMARY KEY, content VARCHAR(60))")

require './lib/db_connection'

DBConnection.exec("CREATE TABLE IF NOT EXISTS tags (id SERIAL PRIMARY KEY, content VARCHAR(60))")

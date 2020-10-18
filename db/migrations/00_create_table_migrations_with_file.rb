require './lib/db_connection'

DBConnection.exec("CREATE TABLE IF NOT EXISTS migrations (id SERIAL PRIMARY KEY, file VARCHAR(100))")

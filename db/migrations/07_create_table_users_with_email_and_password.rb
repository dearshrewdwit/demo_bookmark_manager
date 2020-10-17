require './lib/db_connection'

DBConnection.exec("CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(60))")

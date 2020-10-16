require 'pg'
require 'db_connection'

RSpec.configure do |config|
  config.before(:each) do
    result = DBConnection.exec("SELECT table_name FROM information_schema.tables WHERE table_schema='public';")
    result.each do |row|
      DBConnection.exec("TRUNCATE TABLE #{row["table_name"]} CASCADE")
    end
  end
end

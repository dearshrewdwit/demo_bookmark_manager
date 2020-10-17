require 'pg'
require 'db_connection'

RSpec.configure do |config|
  config.before(:each) do
    DBConnection.exec("TRUNCATE TABLE bookmarks")
  end
end

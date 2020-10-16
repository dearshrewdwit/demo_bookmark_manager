require 'pg'

raise 'no environment specfied' if ARGV.empty?
environment = ARGV[0].split('=')[1]
if ['test', 'development'].include?(environment)
  ENV['RACK_ENV'] = environment
else
  raise 'Wrong environment specified'
end

begin
  connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
  connection.exec("ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60)")
rescue PG::Error => e
  puts e.message
ensure
  connection.close if connection
end

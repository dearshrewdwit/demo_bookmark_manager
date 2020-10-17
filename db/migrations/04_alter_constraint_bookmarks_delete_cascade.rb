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
  connection.exec("ALTER TABLE comments DROP CONSTRAINT comments_bookmark_id_fkey, ADD CONSTRAINT comments_bookmark_id_fkey FOREIGN KEY (bookmark_id) REFERENCES bookmarks(id) ON DELETE CASCADE")
rescue PG::Error => e
  puts e.message
ensure
  connection.close if connection
end

require 'rake'
require './app/models/migration'

task 'db:migrate', :db_migrate do |tsk, args|

  raise 'no environment specfied' unless ARGV[1]
  environment = ARGV[1].split('=')[1]

  if ['test', 'development'].include?(environment)
    ENV['RACK_ENV'] = environment
  else
    raise 'Wrong environment specified'
  end

  puts "running #{tsk} in #{ENV['RACK_ENV']} mode"
  Dir.glob("db/migrations/**").sort.each do |path|
    file = path.split('/')[-1]
    puts "Attempting migration: #{file}..."
    migration = Migration.find_by(file: file)
    if migration.nil?
      migration = Migration.create(file: path)
      print "Migrating..."
      migration.run!
      puts "Migrated"
    else
      puts "Skipped."
    end
  end
end

task 'db:setup', :db_setup do |tsk, args|

  raise 'no environment specfied' unless ARGV[1]
  environment = ARGV[1].split('=')[1]

  if ['test', 'development'].include?(environment)
    ENV['RACK_ENV'] = environment
  else
    raise 'Wrong environment specified'
  end

  puts "running #{tsk} in #{ENV['RACK_ENV']} mode"
  migrations_file = "00_create_table_migrations_with_file.rb"
  print 'setting up the migrations table..'
  system("ruby db/migrations/#{migrations_file} RACK_ENV=#{ENV['RACK_ENV']}")
  puts 'Created.'
  print "creating initial migration..."
  migration = Migration.create(file: migrations_file)
  puts 'Created.'
  puts 'Database ready to migrate.'
end

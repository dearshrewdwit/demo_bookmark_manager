require 'rake'

task 'db:migrate', :db_migrate do |tsk, args|

  raise 'no environment specfied' unless ARGV[1]
  environment = ARGV[1].split('=')[1]

  if ['test', 'development'].include?(environment)
    ENV['RACK_ENV'] = environment
  else
    raise 'Wrong environment specified'
  end

  puts "running #{tsk} in #{ENV['RACK_ENV']} mode"
  Dir.glob("db/migrations/**").each do |path|
    print "Running migration: #{path}..."
    system("ruby #{path} RACK_ENV=#{ENV['RACK_ENV']}")
    puts "Migrated"
  end
end

raise 'no environment specfied' if ARGV.empty?
environment = ARGV[0].split('=')[1]

if ['test', 'development'].include?(environment)
  ENV['RACK_ENV'] = environment
else
  raise 'Wrong environment specified'
end

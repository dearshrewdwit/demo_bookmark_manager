ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'pg'
require './app/app'

require_relative 'support/database_cleaner.rb'
Capybara.app = BookmarkManager

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'

require_relative 'models/bookmark'
require_relative 'models/comment'
require_relative 'models/tag'
require_relative 'models/bookmarks_tags'
require_relative 'models/user'


require_relative 'controllers/app_controller'
require_relative 'controllers/bookmarks_controller'
require_relative 'controllers/tags_controller'
require_relative 'controllers/registrations_controller'
require_relative 'controllers/sessions_controller'

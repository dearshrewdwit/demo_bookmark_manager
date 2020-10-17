class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions
  register Sinatra::Flash
  set :root, File.dirname(File.expand_path('..', __FILE__))
end

class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions
  register Sinatra::Flash
  set :root, File.dirname(File.expand_path('..', __FILE__))

  def current_user
    User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def authenticate!
    redirect '/' unless signed_in?
  end

  before '/bookmarks*' do
    authenticate!
  end

  before '/tags*' do
    authenticate!
  end
end

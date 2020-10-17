class BookmarkManager < Sinatra::Base
  get '/' do
    erb(:'registrations/signup')
  end

  post '/registrations' do
    user = User.create(email: params[:email], password: params[:password])
    flash.next[:info] = "Welcome, #{user.email}!"
    session[:user_id] = user.id
    redirect '/bookmarks'
  end
end

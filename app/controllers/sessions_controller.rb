class BookmarkManager < Sinatra::Base
  get '/sign_in' do
    erb(:'sessions/sign_in')
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      flash.next[:info] = "Welcome back, #{user.email}!"
      redirect '/bookmarks'
    else
      flash.next[:error] = "Your email or password is incorrect"
      redirect '/sign_in'
    end
  end

  delete '/sessions' do
    flash.next[:info] = "Goodbye, #{current_user.email}!"
    session.delete(:user_id)
    redirect '/'
  end
end

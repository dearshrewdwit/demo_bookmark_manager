ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'models/bookmark'

class BookmarkManager < Sinatra::Base
  get '/bookmarks' do
    erb(:'bookmarks/index', locals: { bookmarks: Bookmark.all })
  end

  post '/bookmarks' do
    Bookmark.create(url: params[:bookmark_url])
    redirect '/bookmarks'
  end
end

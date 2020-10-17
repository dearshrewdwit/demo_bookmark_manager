ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'models/bookmark'

class BookmarkManager < Sinatra::Base
  enable :method_override

  get '/bookmarks' do
    erb(:'bookmarks/index', locals: { bookmarks: Bookmark.all })
  end

  get '/bookmarks/:id/edit' do
    bookmark = Bookmark.find_by(id: params[:id])
    erb(:'bookmarks/edit', locals: { bookmark: bookmark})
  end

  post '/bookmarks' do
    Bookmark.create(url: params[:bookmark_url], title: params[:bookmark_title])
    redirect '/bookmarks'
  end

  delete '/bookmarks' do
    Bookmark.delete(id: params[:bookmark_id])
    redirect '/bookmarks'
  end

  put '/bookmarks' do
    bookmark = Bookmark.find_by(id: params[:bookmark_id])
    bookmark.update(url: params[:bookmark_url], title: params[:bookmark_title])
    redirect '/bookmarks'
  end
end

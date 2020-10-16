ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'models/bookmark'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions
  register Sinatra::Flash

  get '/bookmarks' do
    erb(:'bookmarks/index', locals: { bookmarks: Bookmark.all })
  end

  get '/bookmarks/:id/edit' do
    bookmark = Bookmark.find_by(id: params[:id])
    erb(:'bookmarks/edit', locals: { bookmark: bookmark})
  end

  post '/bookmarks' do
    bookmark = Bookmark.create(url: params[:bookmark_url], title: params[:bookmark_title])

    if bookmark.valid?
      flash.next[:info] = "Bookmark saved"
    else
      flash.next[:error] = bookmark.errors
    end
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  put '/bookmarks/:id' do
    bookmark = Bookmark.find_by(id: params[:id])
    bookmark = bookmark.update(url: params[:bookmark_url], title: params[:bookmark_title])
    if bookmark.valid?
      flash.next[:info] = "Bookmark updated"
    else
      flash.next[:error] = bookmark.errors
    end
    redirect '/bookmarks'
  end
end

class BookmarkManager < Sinatra::Base
  get '/tags/:id/bookmarks' do
    tag = Tag.find_by(id: params[:id])
    erb(:'/bookmarks/tag', locals: { bookmarks: tag.bookmarks })
  end
end

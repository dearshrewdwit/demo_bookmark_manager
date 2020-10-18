class BookmarkManager < Sinatra::Base
  post '/bookmarks/:id/comments' do
    bookmark = Bookmark.find_by(id: params[:id])
    comment = Comment.create(text: params[:comment_text], bookmark_id: bookmark.id)
    redirect '/bookmarks'
  end
end

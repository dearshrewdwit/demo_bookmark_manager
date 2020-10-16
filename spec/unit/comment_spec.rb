require './app/models/comment'
require './app/models/bookmark'

require 'db_connection'

describe Comment do
  describe '.create' do
    let!(:bookmark) { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC')}

    it 'returns a comment instance that is persisted' do
      comment = Comment.create(text: "yay, a comment", bookmark_id: bookmark.id)
      expect(comment.id).not_to eq nil
      expect(comment.text).to eq "yay, a comment"
    end
  end
end

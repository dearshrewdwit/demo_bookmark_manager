require './app/models/tag'
require './app/models/bookmark'
require './app/models/bookmarks_tags'

require 'db_connection'

describe BookmarksTags do
  describe '.create' do
    let!(:bookmark) { Bookmark.create(url: 'https://www.bbc.co.uk', title: 'BBC')}
    let!(:tag) { Tag.find_or_create(content: 'news') }

    it 'returns a BookmarksTags instance that is persisted' do
      bookmark_tag = BookmarksTags.create(bookmark_id: bookmark.id, tag_id: tag.id)
      expect(bookmark_tag.id).not_to eq nil
      expect(bookmark_tag.bookmark_id).to eq bookmark.id
      expect(bookmark_tag.tag_id).to eq tag.id
    end
  end
end

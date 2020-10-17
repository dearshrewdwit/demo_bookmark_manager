require './app/models/tag'

require 'db_connection'

describe Tag do
  describe '.find_or_create' do
    it 'returns a tag instance that is persisted' do
      tag = Tag.find_or_create(content: "short")
      expect(tag.id).not_to eq nil
      expect(tag.content).to eq "short"
    end

    it 'make sure to find tag first if exists' do
      created_tag = Tag.find_or_create(content: "short")
      found_tag = Tag.find_or_create(content: "short")

      expect(created_tag.id).to eq found_tag.id
    end
  end

  describe '.find_by' do
    it 'returns a bookmark instance by id' do
      DBConnection.exec("INSERT INTO tags (content) VALUES('happy')")

      tag = Tag.find_or_create(content: 'happy')
      found_tag = Tag.find_by(id: tag.id)

      expect(found_tag.id).to eq tag.id
      expect(found_tag.content).to eq tag.content
    end
  end

  describe '#bookmarks' do
    it 'returns an array of bookmarks' do
      tag = described_class.find_or_create(content: 'news')
      bookmark = Bookmark.create(url: 'http://www.bbc.co.uk', title: 'bbc')
      bookmarks_tags = BookmarksTags.create(bookmark_id: bookmark.id, tag_id: tag.id)

      expect(tag.bookmarks.length).to eq 1
      expect(tag.bookmarks.first.url).to eq 'http://www.bbc.co.uk'
    end
  end
end

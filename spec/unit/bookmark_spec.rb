require './app/models/bookmark'
require 'db_connection'

describe Bookmark do
  describe '.find_by' do
    it 'returns a bookmark instance by id' do
      DBConnection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.test.com', 'test_title')")

      bookmarks = Bookmark.all
      bookmark = bookmarks.first
      found_bookmark = Bookmark.find_by(id: bookmark.id)

      expect(found_bookmark.id).to eq bookmark.id
      expect(found_bookmark.url).to eq bookmark.url
      expect(found_bookmark.title).to eq bookmark.title
    end
  end

  describe '.all' do
    it 'returns an array of bookmarks' do
      DBConnection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.test.com', 'test_title')")

      bookmarks = Bookmark.all

      expect(bookmarks.first.url).to eq 'http://www.test.com'
      expect(bookmarks.first.title).to eq 'test_title'
    end
  end

  describe '.create' do
    it 'returns a bookmark instance that is persisted' do
      Bookmark.create(url: 'http://www.test.com', title: 'test')
      bookmarks = Bookmark.all
      expect(bookmarks.first.url).to eq 'http://www.test.com'
      expect(bookmarks.first.title).to eq 'test'
    end
  end

  describe '.delete' do
    it 'removes a record from the table' do
      DBConnection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.test.com', 'test_title')")

      bookmarks = Bookmark.all
      first_bookmark = bookmarks[0]

      Bookmark.delete(id: first_bookmark.id)
      bookmarks = Bookmark.all

      expect(Bookmark.all.empty?).to eq true
    end
  end

  describe '#update' do
    it 'updates a record from the table' do
      DBConnection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.test.com', 'test_title')")

      bookmarks = Bookmark.all
      first_bookmark = bookmarks[0]

      first_bookmark.update(url: 'http://www.title.com', title: 'new_title')
      updated_bookmark = Bookmark.find_by(id: first_bookmark.id)

      expect(updated_bookmark.url).to eq 'http://www.title.com'
      expect(updated_bookmark.title).to eq 'new_title'
    end
  end

  describe '#valid?' do
    it 'true if the url is valid' do
      bookmark = described_class.new(id: nil, url: 'http://www.bbc.co.uk', title: 'bbc')

      expect(bookmark.valid?).to eq true
      expect(bookmark.errors.empty?).to eq true
    end

    it 'false if the url is invalid' do
      bookmark = described_class.new(id: nil, url: 'blaaa', title: 'bla')

      expect(bookmark.valid?).to eq false
    end

    it 'false if the url is invalid' do
      bookmark = described_class.new(id: nil, url: 'blaaa', title: 'bla')
      bookmark.valid?

      expect(bookmark.errors.empty?).to eq false
      expect(bookmark.errors.keys).to include(:url)
    end
  end

  describe '#errors' do
    it 'starts empty' do
      bookmark = described_class.new(id: nil, url: 'http://www.bbc.co.uk', title: 'bbc')

      expect(bookmark.errors.empty?).to eq true
    end

    it 'can add key value pairs' do
      bookmark = described_class.new(id: nil, url: 'blaaa', title: 'bla')
      bookmark.errors[:test] = 'test'

      expect(bookmark.errors.empty?).to eq false
      expect(bookmark.errors.keys).to include(:test)
    end
  end

  describe '#comments' do
    it 'returns an array of comments' do
      bookmark = described_class.create(url: 'http://www.bbc.co.uk', title: 'bbc')
      comment = Comment.create(text: 'a test comment', bookmark_id: bookmark.id)
      expect(bookmark.comments.length).to eq 1
      expect(bookmark.comments.first.text).to eq 'a test comment'
    end
  end
end

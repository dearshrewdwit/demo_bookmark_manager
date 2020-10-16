require './app/models/bookmark'

describe Bookmark do
  describe '.find_by' do
    it 'returns a bookmark instance by id' do
      begin
        connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
        connection.exec("INSERT INTO bookmarks (url, title) VALUES('test_url', 'test_title')")
      rescue PG::Error => e
        puts e.message
      ensure
        connection.close if connection
      end
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
      begin
        connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
        connection.exec("INSERT INTO bookmarks (url) VALUES('test_url')")
      rescue PG::Error => e
        puts e.message
      ensure
        connection.close if connection
      end

      bookmarks = Bookmark.all

      expect(bookmarks.first.url).to eq 'test_url'
    end
  end

  describe '.create' do
    it 'returns a bookmark instance that is persisted' do
      Bookmark.create(url: 'test_create_url', title: 'test')
      bookmarks = Bookmark.all
      expect(bookmarks.first.url).to eq 'test_create_url'
      expect(bookmarks.first.title).to eq 'test'
    end
  end

  describe '.delete' do
    it 'removes a record from the table' do
      begin
        connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
        connection.exec("INSERT INTO bookmarks (url, title) VALUES('test_url', 'test_title')")
      rescue PG::Error => e
        puts e.message
      ensure
        connection.close if connection
      end

      bookmarks = Bookmark.all
      first_bookmark = bookmarks[0]

      Bookmark.delete(id: first_bookmark.id)
      bookmarks = Bookmark.all

      expect(Bookmark.all.empty?).to eq true
    end
  end

  describe '#update' do
    it 'updates a record from the table' do
      begin
        connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
        connection.exec("INSERT INTO bookmarks (url, title) VALUES('test_url', 'test_title')")
      rescue PG::Error => e
        puts e.message
      ensure
        connection.close if connection
      end

      bookmarks = Bookmark.all
      first_bookmark = bookmarks[0]

      first_bookmark.update(url: 'new_url', title: 'new_title')
      updated_bookmark = Bookmark.find_by(id: first_bookmark.id)

      expect(updated_bookmark.url).to eq 'new_url'
      expect(updated_bookmark.title).to eq 'new_title'
    end
  end
end

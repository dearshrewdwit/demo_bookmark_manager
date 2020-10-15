require './app/models/bookmark'

describe Bookmark do
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
      Bookmark.create(url: 'test_create_url')
      bookmarks = Bookmark.all
      expect(bookmarks.first.url).to eq 'test_create_url'
    end
  end
end

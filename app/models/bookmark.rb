require 'pg'

class Bookmark
  def self.find_by(id:)
    begin
      connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
      result = connection.exec("SELECT * FROM bookmarks WHERE id=#{id};")
      result.map do |row|
        new(id: row["id"], url: row["url"], title: row["title"])
      end.first
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  def self.all
    begin
      connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
      result = connection.exec("SELECT * FROM bookmarks;")
      result.map do |row|
        new(id: row["id"], url: row["url"], title: row["title"])
      end
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  def self.create(url:, title:)
    begin
      connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}')")
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  def self.delete(id:)
    begin
      connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
      connection.exec("DELETE FROM bookmarks WHERE id=#{id}")
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def update(url:, title:)
    begin
      connection = PG.connect :dbname => "demo_bookmark_manager_#{ENV['RACK_ENV']}"
      connection.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id=#{id}")
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end
end

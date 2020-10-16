require 'pg'
require './lib/db_connection'

class Bookmark
  include DBConnection

  def self.find_by(id:)
    result = DBConnection.exec("SELECT * FROM bookmarks WHERE id=#{id};")
    result.map do |row|
      new(id: row["id"], url: row["url"], title: row["title"])
    end.first
  end

  def self.all
    result = DBConnection.exec("SELECT * FROM bookmarks;")
    result.map do |row|
      new(id: row["id"], url: row["url"], title: row["title"])
    end
  end

  def self.create(url:, title:)
    bookmark = new(id: nil, url: url, title: title)
    if bookmark.valid?
      result = DBConnection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title")
      bookmark = result.map do |row|
        new(id: row["id"], url: row["url"], title: row["title"])
      end.first
    end
    bookmark
  end

  def self.delete(id:)
    DBConnection.exec("DELETE FROM bookmarks WHERE id=#{id}")
  end

  attr_reader :id, :url, :title, :errors

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
    @errors = {}
  end

  def update(url:, title:)
    bookmark = self.class.new(id: nil, url: url, title: title)
    if bookmark.valid?
      result = DBConnection.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id=#{id} RETURNING id, url, title")
      bookmark = result.map do |row|
        self.class.new(id: row["id"], url: row["url"], title: row["title"])
      end.first
    end
    bookmark
  end

  def valid?
    begin
      uri = URI.parse(url)
      raise if uri.host.nil?
      true
    rescue
      errors[:url] = "#{url} is an invalid URL"
      false
    end
  end
end

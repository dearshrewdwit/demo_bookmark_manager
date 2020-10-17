require './lib/db_connection'

class Tag
  include DBConnection

  def self.find_or_create(content: )
    result = DBConnection.exec("SELECT * FROM tags WHERE content='#{content}'")
    if result.first.nil?
      result = DBConnection.exec("INSERT INTO tags (content) VALUES('#{content}') RETURNING id, content")
    end
    result.map do |row|
      new(id: row["id"], content: row["content"])
    end.first
  end

  def self.find_by(id:)
    result = DBConnection.exec("SELECT * FROM tags WHERE id=#{id};")
    result.map do |row|
      new(id: row["id"], content: row["content"])
    end.first
  end

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def bookmarks
    result = DBConnection.exec("SELECT * FROM bookmarks JOIN bookmarks_tags ON bookmarks_tags.bookmark_id = bookmarks.id WHERE bookmarks_tags.tag_id = #{id}")
    result.map do |row|
      Bookmark.new(id: row["id"], url: row["url"], title: row["title"])
    end
  end
end

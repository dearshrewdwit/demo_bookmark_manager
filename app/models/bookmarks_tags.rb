require './lib/db_connection'

class BookmarksTags
  include DBConnection

  def self.create(bookmark_id:, tag_id: )
    result = DBConnection.exec("INSERT INTO bookmarks_tags (bookmark_id, tag_id) VALUES('#{bookmark_id}', '#{tag_id}') RETURNING id, bookmark_id, tag_id")
    result.map do |row|
      new(id: row["id"], bookmark_id: row["bookmark_id"], tag_id: row["tag_id"])
    end.first
  end

  attr_reader :id, :bookmark_id, :tag_id

  def initialize(id:, bookmark_id:, tag_id:)
    @id = id
    @bookmark_id = bookmark_id
    @tag_id = tag_id
  end
end

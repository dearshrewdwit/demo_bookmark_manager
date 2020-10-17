require './lib/db_connection'

class Comment
  include DBConnection

  def self.create(text:, bookmark_id:)
    result = DBConnection.exec("INSERT INTO comments (text, bookmark_id) VALUES('#{text}', '#{bookmark_id}') RETURNING id, text")
    comment = result.map do |row|
      new(id: row["id"], text: row["text"])
    end.first
  end

  attr_reader :id, :text
  
  def initialize(id:, text:)
    @id = id
    @text = text
  end
end

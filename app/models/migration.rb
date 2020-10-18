require './lib/db_connection'

class Migration
  include DBConnection

  def self.create(file:)
    split_file = file.split('/')[-1]
    result = DBConnection.exec("INSERT INTO migrations (file) VALUES('#{split_file}') RETURNING id, file")
    result.map do |row|
      new(id: row["id"], file: row["file"])
    end.first
  end

  def self.find_by(file:)
    result = DBConnection.exec("SELECT * FROM migrations WHERE file='#{file}';")
    result.map do |row|
      new(id: row["id"], file: row["file"])
    end.first
  end

  attr_reader :id, :file

  def initialize(id:, file:)
    @id = id
    @file = file
  end

  def run!
    system("ruby db/migrations/#{file} RACK_ENV=#{ENV['RACK_ENV']}")
  end
end

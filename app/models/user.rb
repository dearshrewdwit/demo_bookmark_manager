require './lib/db_connection'
require 'bcrypt'

class User
  include DBConnection
  include BCrypt

  def self.create(email:, password:)
    password_hash = Password.create(password)
    result = DBConnection.exec("INSERT INTO users (email, password) VALUES('#{email}', '#{password_hash}') RETURNING id, email, password")
    result.map do |row|
      new(id: row["id"], email: row["email"], password: row["password"])
    end.first
  end

  def self.find_by(**args)
    arg_list = args.first
    return nil if arg_list[1].nil?
    if arg_list[1].is_a? String
      value = "'#{arg_list[1]}'"
    else
      value = arg_list[1]
    end
    result = DBConnection.exec("SELECT * FROM users WHERE #{arg_list[0]}=#{value};")
    result.map do |row|
      new(id: row["id"], email: row["email"], password: row["password"])
    end.first
  end

  def self.authenticate(email:, password:)
    user = find_by(email: email)
    return nil unless user
    return nil unless user.password == password
    user
  end

  attr_reader :id, :email

  def initialize(id:, email:, password:)
    @id = id
    @email = email
    @password_hash = password
  end

  def password
    @password ||= Password.new(@password_hash)
  end
end

require './app/models/user'
require 'bcrypt'
require 'db_connection'

describe User do
  describe '.create' do
    it 'returns a user instance that is persisted' do
      user = described_class.create(email: "test@test.com", password: "test12")
      expect(user.id).not_to eq nil
      expect(user.email).to eq "test@test.com"
      expect(user.password).to eq "test12"
    end
  end

  describe '.find_by' do
    it 'returns a user instance by email' do
      password_hash = BCrypt::Password.create('test12')
      DBConnection.exec("INSERT INTO users (email, password) VALUES('test@test.com', '#{password_hash}')")

      user = described_class.find_by(email: 'test@test.com')

      expect(user.email).to eq 'test@test.com'
      expect(user.password).to eq 'test12'
    end

    it 'returns a user instance by id' do
      user = described_class.create(email: "test@test.com", password: "test12")

      found_user = described_class.find_by(id: user.id)

      expect(found_user.email).to eq user.email
      expect(found_user.password).to eq 'test12'
      expect(found_user.id).to eq user.id
    end

    it 'returns nil if not exists' do
      found_user = described_class.find_by(id: 1)

      expect(found_user).to eq nil
    end
  end

  describe '.authenticate' do
    context 'when valid' do
      it 'returns user' do
        user = described_class.create(email: "test@test.com", password: "test12")
        expect(described_class.authenticate(email: user.email, password: "test12")).not_to eq nil
      end
    end

    context 'when email is invalid' do
      it 'returns nil' do
        user = described_class.create(email: "test@test.com", password: "test12")
        expect(described_class.authenticate(email: 'incorrect@test.com', password: "test12")).to eq nil
      end
    end

    context 'when password is invalid' do
      it 'returns nil' do
        user = described_class.create(email: "test@test.com", password: "test12")
        expect(described_class.authenticate(email: user.email, password: "incorrect")).to eq nil
      end
    end
  end
end

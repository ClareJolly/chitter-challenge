require 'user'
require_relative '../lib/database_connection'

describe User do
  describe '#create' do
    it 'creates a user' do
      user = User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd", "test@test.com")
      expect(user).to be_a User
      expect(user.username).to eq "peeper1234"
    end
  end

  describe '#find' do
    it 'find a user by id' do
      user = User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd", "test@test.com")
      result = User.find(user.id)
      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
  end

  describe '#login' do
    it 'returns a user on successful login' do
      user = User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd", "test@test.com")
      logged_in_user = User.login('peeper1234', "p4s5w0rd")
      expect(logged_in_user.id).to eq user.id
    end

    it 'returns nil on unsuccessful login' do
      User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd", "test@test.com")
      logged_in_user = User.login('peeper1234', 'p4s5w0rd-wrong')
      expect(logged_in_user).to eq nil
    end

  end

  describe '#email_in_use' do
    it 'returns error message when username is not unique' do
      User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd", "test@test.com")
      User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd-1234", "test@test2.com")
      expect(User.create("Joe", "Bloggs", "peeper1234-test", "p4s5w0rd-1234", "test@test.com")).to eq "There is already an account with this email address"
    end
  end

  describe '#username_in_use' do
    it 'returns error message when username is not unique' do
      User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd", "test@test.com")
      expect(User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd-1234", "test@test2.com")).to eq "There is already an account with this username"
    end
  end

  describe '#valid_email?' do
    it 'returns error message when email address is not valid' do
      expect(User.create("Joe", "Bloggs", "peeper1234", "p4s5w0rd-1234", "notanemail")).to eq "Please enter a valid email address"
    end
  end

end

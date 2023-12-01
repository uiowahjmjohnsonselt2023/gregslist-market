require './spec/rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(
    name: 'Mike',
    username: 'mike_doe',
    password: 'passwordisSerect',
    email: 'mike@gmail.com'
  ) }

  describe 'digest method' do
    it 'returns a hashed string' do
      string = 'password'
      hashed_string = User.digest(string)
      expect(hashed_string).not_to be_nil
    end
  end

  describe 'new_token method' do
    it 'returns a non-nil token' do
      token = User.new_token
      expect(token).not_to be_nil
    end
  end

  describe 'remember method' do
    it 'sets remember_token and remember_digest' do
      user.remember
      expect(user.remember_token).not_to be_nil
      expect(user.remember_digest).not_to be_nil
    end
  end

  describe 'authenticated? method' do
    it 'returns false for nil remember_digest' do
      user.remember_digest = nil
      expect(user.authenticated?('some_token')).to be_falsey
    end

    it 'returns true for matching remember_token' do
      user.remember
      expect(user.authenticated?(user.remember_token)).to be_truthy
    end

    it 'returns false for non-matching remember_token' do
      user.remember
      expect(user.authenticated?('wrong_token')).to be_falsey
    end
  end

  describe 'forget method' do
    it 'sets remember_digest to nil' do
      user.remember
      user.forget
      expect(user.remember_digest).to be_nil
    end
  end
end

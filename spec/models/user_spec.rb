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

  describe '#authenticated_activation?' do
    let(:user) { User.new }
    context 'when activation_digest is nil' do
      it 'returns false' do
        user.activation_digest = nil
        activation_token = 'some_activation_token'
        expect(user.authenticated_activation?(activation_token)).to be_falsey
      end
    end

    context 'when activation_digest is present' do
      let(:activation_token) { 'some_activation_token' }
      it 'returns true for a valid activation token' do
        user.activation_digest = BCrypt::Password.create(activation_token)
        expect(user.authenticated_activation?(activation_token)).to be_truthy
      end

      it 'returns false for an invalid activation token' do
        user.activation_digest = BCrypt::Password.create('some_other_token')
        expect(user.authenticated_activation?(activation_token)).to be_falsey
      end
    end
  end

  describe '#authenticated_reset?' do
    let(:user) { User.new }
    context 'when reset_digest is nil' do
      it 'returns false' do
        user.reset_digest = nil
        reset_token = 'some_reset_token'
        expect(user.authenticated_reset?(reset_token)).to be_falsey
      end
    end

    context 'when reset_digest is present' do
      let(:reset_token) { 'some_reset_token' }
      it 'returns true for a valid reset token' do
        user.reset_digest = BCrypt::Password.create(reset_token)
        expect(user.authenticated_reset?(reset_token)).to be_truthy
      end

      it 'returns false for an invalid reset token' do
        user.reset_digest = BCrypt::Password.create('some_other_token')
        expect(user.authenticated_reset?(reset_token)).to be_falsey
      end
    end
  end

  describe '#downcase_email' do
    it 'downcases the email attribute before saving' do
      user = User.create(name: 'John Doe', username: 'john_doe', email: 'John@example.com', password: 'password')
      # user.save
      expect(user.email).to eq('john@example.com')
    end

    it 'does not modify email if it is nil' do
      user = User.new(name: 'John Doe', email: nil, password: 'password')
      user.save

      expect(user.email).to be_nil
    end
  end



end

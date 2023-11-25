#require 'test_helper'
require 'C:\Users\pchiu\RubymineProjects\gregslist-market\test\test_helper.rb'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'John Doe', username: 'johndoe', email: 'john_doe@mymail.com',
                     password: 'foo@bar', password_confirmation: 'foo@bar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '     '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "should have a unique username" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 31
    assert_not @user.valid?
  end

  test "username validation should accept valid usernames" do
    valid_usernames = %w[johndoe john_doe john123 johndoe123 john@doe john doe john&doe johndoe!]
    valid_usernames.each do |valid_username|
      @user.username = valid_username
      assert @user.valid?, "#{valid_username.inspect} should be valid"
    end
  end

  test "digest method should return a hashed string" do
    # Replace 'password' with the string you want to hash for testing
    input_string = 'password'

    # Call the digest method
    hashed_string = User.digest(input_string)

    # Ensure that the result is a valid BCrypt hash
    assert BCrypt::Password.new(hashed_string).is_password?(input_string)
  end

  test "new_token method should return a secure random token" do
    # Call the new_token method
    token = User.new_token

    # Ensure that the result is a string
    assert_instance_of String, token

    # Ensure that the token has the correct length (adjust as needed)
    assert_equal 22, token.length

    # Ensure that the token consists of URL-safe base64 characters
    assert_match(/\A[-\w]+\z/, token)
  end

  test "remember method should set remember_token and update remember_digest" do
    # Call the remember method
    @user.remember

    # Ensure that remember_token is set
    assert_not_nil @user.remember_token

    # Ensure that remember_digest is updated
    assert_not_nil @user.remember_digest
    assert BCrypt::Password.new(@user.remember_digest).is_password?(@user.remember_token)
  end

  test "authenticated? method should return true for a valid remember_token" do
    # Set up a remember_token (replace 'your_token' with an actual token)
    remember_token = 'your_token'

    # Set remember_digest to a valid BCrypt hash of the remember_token
    @user.update_attribute(:remember_digest, User.digest(remember_token))

    # Call the authenticated? method
    result = @user.authenticated?(remember_token)

    # Ensure that the result is true
    assert result
  end

  test "authenticated? method should return false for a nil remember_digest" do
    # Set remember_digest to nil
    @user.update_attribute(:remember_digest, nil)

    # Call the authenticated? method
    result = @user.authenticated?('any_token')  # The actual token doesn't matter in this case

    # Ensure that the result is false
    assert_not result
  end

  test "forget method should set remember_digest to nil" do
    # Set remember_digest to a non-nil value
    @user.update_attribute(:remember_digest, 'non_nil_value')

    # Call the forget method
    @user.forget

    # Ensure that remember_digest is set to nil
    assert_nil @user.remember_digest
  end

end

require "simplecov"
require 'test_helper'
SimpleCov.start "rails"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(name: "John Doe", username: 'johndoe', email: "johndoe@mymail.com",
                     password: "foo@bar", password_confirmation: "foo@bar")
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create a new user" do
    assert_difference('User.count', 1) do
      post users_path, params: { user: { name: "John Doe", username: "johndoe", email: "john@example.com", password: "password", password_confirmation: "password" } }
    end

    assert_redirected_to user_path(User.last)
    follow_redirect!
    assert_select 'div.alert-success', "Welcome to Greglist Marketplace!"
  end

  test "should not create a new user if blank email" do
    assert_no_difference('User.count') do
      post users_path, params: { user: { name: "John Doe", username: "johndoe", email: " ", password: "password", password_confirmation: "password" } }
    end
  end

  test "digest method should create a valid BCrypt hash" do
    # Replace 'password' with the string you want to hash for testing
    input_string = 'password'

    # Call the digest method
    hashed_string = User.digest(input_string)

    # Ensure that the result is a valid BCrypt hash
    assert BCrypt::Password.new(hashed_string).is_password?(input_string)
  end

  test "new_token method should return a valid URL-safe base64 string" do
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

end
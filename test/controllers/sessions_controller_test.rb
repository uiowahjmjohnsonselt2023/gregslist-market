require "test_helper"

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper
  def setup
    @user = User.create(name: "John Doe", username: 'johndoe', email: "johndoe@mymail.com",
                     password: "foo@bar", password_confirmation: "foo@bar")
  end
  test "new action should redirect to root_path if user is already logged in" do
    # Log in the user
    log_in(@user)
    # Call the new action
    get :new
    # Ensure that the user is redirected to root_path
    assert_redirected_to root_path
    assert_equal "You are already logged in.", flash[:info]

    end
  test "create action should log in user and redirect to user's show page on successful authentication" do
    post :create, params: { session: { email: @user.email, password: @user.password } }
    assert is_logged_in?
    assert_redirected_to user_path(@user)
  end
  test "create action should render 'new' template on unsuccessful login" do
    post :create, params: { session: { email: 'invalid@example.com', password: 'invalid_password' } }
    # Ensure that the user is not logged in
    assert_not is_logged_in?
    # Ensure that the 'new' template is rendered
    assert_template 'new'
    # Ensure that a danger flash message is set
    assert_not_nil flash[:danger]
  end

  test "destroy action should log out the user and redirect to root_url" do
    # Log in the user
    @user = users(:one)  # Assuming you have a fixture named 'one' in your test/fixtures/users.yml file
    log_in(@user)

    # Call the destroy action
    delete :destroy

    # Ensure that the user is logged out
    assert_not is_logged_in?

    # Ensure that the user is redirected to root_url
    assert_redirected_to root_path
  end
end
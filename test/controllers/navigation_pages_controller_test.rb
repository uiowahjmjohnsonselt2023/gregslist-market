require "test_helper"

class NavigationPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get navigation_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get navigation_pages_help_url
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end

end

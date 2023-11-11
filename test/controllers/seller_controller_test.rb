require 'test_helper'

class SellerControllerTest < ActionDispatch::IntegrationTest
  test 'Should be able to see seller select' do
    get '/select_seller'
    assert_response :success
  end

  test 'Should be able to see seller edit' do
    get '/edit_seller'
    assert_response :success
  end

  test 'Should be able to see seller create new' do
    get '/new_seller'
    assert_response :success
  end
end

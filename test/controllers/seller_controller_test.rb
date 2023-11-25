require 'C:\Users\pchiu\RubymineProjects\gregslist-market\test\test_helper.rb'


class SellerControllerTest < ActionDispatch::IntegrationTest
  def setup
    @seller = Seller.new(:one)
  end

  test 'Should be able to see seller select' do
    get '/select_seller'
    assert_response :success
  end

  test 'Should be able to see seller edit' do
    post '/select_seller'
    assert_response :success
  end

  test 'Should be able to see seller create new' do
    get '/new_seller'
    assert_response :success
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :current_cart, :current_seller

  private

  def current_seller
    @current_seller ||= Seller.find(session[:seller_id]) if session[:seller_id]
  end

  def current_cart
    if session[:cart_id]
      Cart.find(session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end
end


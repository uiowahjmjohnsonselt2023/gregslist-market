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
      cart = Cart.find_by_id(session[:cart_id])
    end
  
    if cart.nil?
      cart = Cart.create
      session[:cart_id] = cart.id
    end
  
    cart
  end
end


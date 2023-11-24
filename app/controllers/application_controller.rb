class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # def delete
  #   render 'application/delete'
  # end

  helper_method :current_seller

  def current_seller
    @current_seller ||= Seller.find(session[:seller_id]) if session[:seller_id]
  end
end
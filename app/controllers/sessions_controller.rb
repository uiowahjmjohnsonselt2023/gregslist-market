class SessionsController < ApplicationController

  def destroy
    session[:session_token]=nil
    @current_user=nil
    flash[:notice]="You have been logged out."
    redirect_to 'navigation_pages/home'
  end
end

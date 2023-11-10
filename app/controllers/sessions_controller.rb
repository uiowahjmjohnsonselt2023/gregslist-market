class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:info] = "You are already logged in."
      redirect_to root_path
      end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end


  def destroy
    log_out if logged_in? #if logged_in? is true, then log_out
    # flash.now[:notice] = 'You have successfully logged out.'
    redirect_to root_url
  end
end
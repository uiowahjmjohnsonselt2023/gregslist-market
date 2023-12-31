class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by(email: params[:password_reset][:email].downcase)
    if user
      user.create_reset_digest # defined in app/models/user.rb
      user.send_password_reset_email # defined in app/models/user.rb
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit
  end

  def update
      if params[:user][:password].empty? # if password is empty
        @user.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @user.update(user_params) # if password is not empty
        log_in @user
        flash[:success] = "Password has been reset."
        redirect_to @user
      else # if password is not empty but doesn't match confirmation
        render 'edit'
      end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    # unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
    unless @user && @user.activated? && @user.authenticated_reset?(params[:id])
      redirect_to root_url
    end
  end


  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

end

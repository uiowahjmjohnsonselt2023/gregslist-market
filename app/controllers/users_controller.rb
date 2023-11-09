class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save

      redirect_to @user
      flash[:success] = "Welcome to Greglist Marketplace!"
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                                 :password_confirmation)
  end
end

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user,   only: %i[edit update] # this is a private method
  before_action :admin_user,     only: :destroy # this is a private method

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @purchase_history = Purchase.where(user_id: @user.id).order(id: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Gregslist Marketplace!'
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    stores = user.stores
    if user.destroy
      flash[:success] = 'User deleted'
      redirect_to logout
    else
      puts 'failed'
    end
  end

  def graceful_delete
    user = User.find(params[:user][:id])
    stores = user.seller
    if user.destroy
      flash[:success] = 'User deleted'
      stores.each do |w|
        w.destroy if w.user.empty?
      end
      redirect_to logout_path
    else
      puts 'failed'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                                 :password_confirmation)

    # params.require(:user).permit(:avatar)
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_location # defined in sessions_helper.rb
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) # current_user? is defined in sessions_helper.rb
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

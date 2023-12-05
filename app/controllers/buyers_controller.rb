# frozen_string_literal: true

class BuyersController < ApplicationController
  def show
    @buyer = Buyer.find(params[:id] || params[:buyer][:id])
  end

  def new
    @buyer = Buyer.new
    @user_id = params[:id]
  end

  def edit
    @user = User.find(params[:id])
    @buyer = @user.buyer
    if @buyer

    else
      redirect_to new_buyer_path(id: @user.id)
    end
  end

  def update
    @buyer = Buyer.find(params[:buyer][:id])
    if @buyer.update({ first_name: params[:buyer][:first_name], last_name: params[:buyer][:last_name],
                       payment_method: params[:buyer][:payment_method], address: params[:buyer][:address] })
      flash[:notice] = 'Buyer updated'
    end
    redirect_to user_path
  end

  def create
    @buyer = Buyer.new(buyer_params)
    if @buyer.save
      redirect_to @buyer.user
    else
      flash[:error] = 'Invalid purchase info'
      render 'new'
    end
  end

  def select
    @valid_buyers = current_user.buyer
    render 'select'
  end

  private

  def buyer_params
    params.require(:buyer).permit(:first_name, :last_name, :payment_method, :address, :user_id)
  end
end

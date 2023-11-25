# frozen_string_literal: true

class BuyersController < ApplicationController
  def show
    @buyer = Buyer.find(params[:id] || params[:buyer][:id])
  end

  def new
    @buyer = Buyer.new
  end

  def edit
    @buyer = Buyer.find(params[:id].keys[0])
  end

  def update
    @buyer = Buyer.find(params[:buyer][:id])
    if @buyer.update({ first_name: params[:buyer][:first_name], last_name: params[:buyer][:last_name], payment_method: params[:buyer][:payment_method],
                        address: params[:buyer][:address] })
      flash[:notice] = 'Buyer updated'
    end
    redirect_to buyer_path
  end

  def create
    @buyer = Buyer.new(buyer_params)
    @buyer.users << current_user
    if @buyer.save
      redirect_to @buyer
      puts 'SAVED'
    else
      puts 'NEW'
      render 'new'
    end
  end

  def select
    @valid_buyers = current_user.buyer
    render 'select'
  end

  private

  def buyer_params
    params.require(:buyer).permit(:first_name, :last_name, :payment_method, :address)
  end
end

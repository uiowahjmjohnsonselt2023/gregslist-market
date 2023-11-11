class SellersController < ApplicationController
  def show
    @seller = Seller.find(params[:id])
  end

  def new
    @seller = Seller.new
  end

  def edit
    @seller = Seller.find(params[:seller][:seller_id])
  end

  def update
    @seller.save
  end

  def create
    @seller = Seller.new(seller_params)
    if @seller.save
      redirect_to @seller
    else
      render 'new'
    end
  end

  def select
    @valid_sellers = Seller.all
    render 'select'
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :description, :address)
  end
end

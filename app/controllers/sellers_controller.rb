class SellersController < ApplicationController
  def show
    @seller = Seller.find(params[:id] || params[:seller][:id])
    @items = @seller.items
  end

  def new
    @seller = Seller.new
  end

  def edit
    @seller = Seller.find(params[:id].keys[0])
  end

  def update
    @seller = Seller.find(params[:seller][:id])
    if @seller.update({ name: params[:seller][:name], description: params[:seller][:description],
                        address: params[:seller][:address] })
      flash[:notice] = 'Seller updated'
    end
    redirect_to seller_path
  end

  def create
    @seller = Seller.new(seller_params)
    @seller.user << current_user
    current_user.seller << @seller
    if @seller.save
      redirect_to @seller
      puts 'SAVED'
    else
      puts 'NEW'
      render 'new'
    end
  end

  def select
    @valid_sellers = current_user.seller
    render 'select'
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :description, :address)
  end
end

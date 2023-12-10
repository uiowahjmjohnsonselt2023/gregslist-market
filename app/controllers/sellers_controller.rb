class SellersController < ApplicationController
  def show
    @seller = Seller.find(params[:id] || params[:seller][:id])
    @items = @seller.items
  end

  def new
    @seller = Seller.new
  end

  def index
    @sellers = if current_user&.admin
                 Seller.all
               else
                 Seller.joins(:users)
               end
    @q = params[:search] && params[:search][:q]
    return unless @q && !@sellers.empty?

    @sellers = @sellers.ransack(name_i_cont: @q).result(distinct: true)
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
    # @seller.users << current_user
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

  def selection_redirect
    redirect_to(seller_path(id: params[:id] || params[:seller][:id]))
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :description, :address)
  end
end

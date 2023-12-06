class ItemsController < ApplicationController
  def new
    @item = Item.new
    if params[:seller_id].present? || session[:seller_id].present?
      session[:seller_id] = params[:seller_id] if params[:seller_id].present?
      @item.seller_id = session[:seller_id]
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  # def edit
  #   @item = Item.find(params[:id])
  # end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to seller_path(@item.seller_id)
    else
      render 'new'
    end
  end

  # Update method for items?
  def update
    @item = Item.find(params[:id])
    # if @item.update({ name: params[:item][:name], description: params[:item][:description],
    #                   address: params[:item][:address] })
    #   flash[:notice] = 'item updated'
    # end
    if @item.update({ name: params[:item][:name], description: params[:item][:description],
                      listed_price: params[:item][:listed_price] })
      flash[:notice] = 'Item updated'
      redirect_to item_path
    else
      flash[:error] = 'Invalid new values'
    end
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: 'Empty field!') && return
    else
      @parameter = params[:search].downcase
      @results = Item.all.where('lower(name) OR lower(description) LIKE :search', search: "%#{@parameter}%")
      if @results.blank?
        redirect_to(root_path, alert: 'No items found with that name or description') && return
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :listing_date, :listed_price, :seller_id, category_ids: [])
  end
end

class ItemsController < ApplicationController
  def new
    @item = Item.new
    return unless params[:seller_id].present? || session[:seller_id].present?

    session[:seller_id] = params[:seller_id] if params[:seller_id].present?
    @item.seller_id = session[:seller_id]
  end

  def index
    @items = if current_user&.admin
               Item.all
             else
               Item.joins(seller: :users)
             end
  end

  def search
    @items = if current_user&.admin
               Item.all
             else
               Item.joins(seller: :users)
             end
    @q = params[:search] && params[:search][:q]
    return unless @q && !@items.empty?

    @q = params[:search] && params[:search][:q]
    
    if (@q.nil? || @q.empty? ) && !current_user&.admin
      flash[:warning] = 'Please enter a search term'
      redirect_to root_path
    else
      # return unless @q && !@items.empty?
      @items = @items.ransack(name_i_cont: @q).result(distinct: true)
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to seller_path(@item.seller_id)
    else
      render 'new'
    end
  end

  def butter
    item = Item.find(params[:id])
    item.image.purge_later
    if item.destroy
      flash[:success] = 'Item deleted'
      redirect_to items_path
    else
      flash[:error] = 'failed to delete item'
      redirect_to item_path(params[:id])
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update({ name: params[:item][:name], description: params[:item][:description],
                      listed_price: params[:item][:listed_price] })
      flash[:notice] = 'Item updated'
      redirect_to item_path
    else
      flash[:error] = 'Invalid new values'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :listing_date, :listed_price, :seller_id, category_ids: [])
  end
end

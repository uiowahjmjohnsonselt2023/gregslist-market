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
    @q = params[:search] && params[:search][:q]
    return unless @q && !@items.empty?

    @items = @items.ransack(name_i_cont: @q).result(distinct: true)
  end

  def result
    @result = Item.find(params[:id])
  end

  # def result
  #   @item = Item.find(params[:id])
  # end


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

  # def destroy
  #   @item = Item.find(params[:id])
  #   @item.destroy
  #   redirect_to seller_path(@item.seller_id)
  # end

  private

  def item_params
    params.require(:item).permit(:name, :description, :listing_date, :listed_price, :seller_id, category_ids: [])
  end
end

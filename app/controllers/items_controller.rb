class ItemsController < ApplicationController
    def new
        @item = Item.new
        if params[:seller_id].present? || session[:seller_id].present?
            session[:seller_id] = params[:seller_id] if params[:seller_id].present?
            @item.seller_id = session[:seller_id]
        end

    end

    def create
        @item = Item.new(item_params)

        if @item.save
            redirect_to seller_path(@item.seller_id)
        else
            render 'new'
        end
        end

    private

    def item_params
        params.require(:item).permit(:name, :description, :listing_date, :listed_price, :seller_id, category_ids: [])
    end
end

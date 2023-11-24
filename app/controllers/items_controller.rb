class ItemsController < ApplicationController
    def new
        @item = Item.new
        @item.seller_id = session[:seller_id] if session[:seller_id] # This might be a problem
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

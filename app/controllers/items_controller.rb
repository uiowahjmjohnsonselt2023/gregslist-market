class ItemsController < ApplicationController
    def new
        @item = Item.new
        @item.seller_id = session[:seller_id] if session[:seller_id] # This might be a problem
    end
end

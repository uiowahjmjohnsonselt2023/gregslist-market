class ItemsController < ApplicationController
    def new
        @item = Item.new
    end
end

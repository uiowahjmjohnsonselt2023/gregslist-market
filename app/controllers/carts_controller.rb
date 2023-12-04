class CartsController < ApplicationController
    def show
        @cart = current_cart
    end

    def add
        cart = current_cart
        item = Item.find(params[:item_id])
        cart.add_item(item)
        redirect_to cart_path(id: cart.id)
    end

    def remove
        cart = current_cart
        item = Item.find(params[:item_id])
        cart.remove_item(item)
        redirect_to cart_path(id: cart.id)
    end
end

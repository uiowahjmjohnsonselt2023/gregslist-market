class CartsController < ApplicationController
    def show
        @cart = current_cart
    end

    def add
        cart = current_cart
        item = Item.find(params[:item_id])

        if cart.items.include?(item)
            flash[:warning] = "This item is already in your cart."
        else
            cart.add_item(item)
            flash[:success] = "Item added to cart."
        end

        redirect_to root_path
    end

    def remove
        cart = current_cart
        item = Item.find(params[:item_id])
        cart.remove_item(item)
        redirect_to cart_path(id: cart.id)
    end
end

class PurchasesController < ApplicationController

  def new
    @cart = current_cart
  end

  def create
    cart = current_cart
    purchase = Purchase.new(cart: cart, user: current_user)
    purchase.total_price = cart.items.sum { |item| item.listed_price }

    if purchase.save
      #create new cart on successful checkout
      cart = Cart.create
      session[:cart_id] = cart.id
      #redirect to the user page
      redirect_to(user_path(current_user))
    else
      redirect_to(:back, notice: "There was an error processing your order, don't try again!")
    end
  end
end

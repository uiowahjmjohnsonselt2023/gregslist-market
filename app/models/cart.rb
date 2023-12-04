class Cart < ApplicationRecord
    has_many :cart_items
    has_many :items, through: :cart_items

    #add items to the cart, unless it is already in that shit
    def add_item(item)
        cart_items.create(item_id: item.id) unless cart_items.find_by(item_id: item.id)
    end

    def remove_item(item)
        current_item = cart_items.find_by(item_id: item.id)
        cart_items.destroy(current_item) if current_item
    end

    def total_price
        cart_items.joins(:item).sum(:listed_price)
    end
end

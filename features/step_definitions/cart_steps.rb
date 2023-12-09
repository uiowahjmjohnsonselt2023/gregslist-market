
Given("the following associations between item and cart exist") do |association_table|
  association_table.hashes.each do |row|
    item = Item.find_by(id: row['item_id'])
    cart = Cart.find_by(id: row['cart_id'])
    CartItem.create(cart: cart, item: item)
  end
end

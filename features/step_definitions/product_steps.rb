Given /the following products exist/ do |products_table|
  products_table.hashes.each do |product|
    Product.create(
      name: product['name'],
      price: product['price'],
      date: product['date'],
      category: product['category']
    )
  end
end

Then /(.*) products should exist/ do | n_seeds |
  expect(Product.count).to eq n_seeds.to_i
end

When /^(?:|I )am in (.+)$/ do |page_name|
  visit path_to(page_name)
end

When("I complete the product post form") do
  @name="Fujifilm Quicksnap 135 Flash 400 2pk Camera"
  @price="22.99"
  @date="2023-11-13"
  @category="electronics"
  @seller="Cindy"
  fill_in "name", with: @name
  fill_in "price", with: @price
  fill_in "date", with: @date
  fill_in "category", with:@category
  click_button "Post the product"
  Product.create(
    name: @name,
    price: @price,
    date: @date,
    category: @category,
    seller_username:@seller
  )
end

Then 'I should see my product in my store' do
  the_product=Product.find_by(name:@name, price:@price, date:@date, category:@category, seller_username:@seller)
  the_id=the_product.id
  # TODO: path for one's store
  expect(current_path).to eq('/users/'+the_id.to_s)
  expect(page).to have_content(@name, price:@price, date:@date, category:@category)
end

When /^(?:|I )update the price of "([^"]*)" with "([^"]*)"$/ do |name, new_price|
  the_product=Product.find_by(name:name)
  the_id=the_product.id
  Product.update(the_id,price:new_price)

  end

Then /^(?:|I )should see "([^"]*)" with "([^"]*)"$/ do |name, new_price|
  the_product=Product.find_by(name:name)
  expect(the_product.price).to eq(new_price)
end

And /^(?:|I )should not see "([^"]*)" with "([^"]*)"$/ do |name, old_price|
  the_product=Product.find_by(name:name)
  expect(the_product.price).not eq(old_price)
end



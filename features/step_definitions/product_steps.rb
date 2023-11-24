Given /the following items exist/ do |items_table|
  items_table.hashes.each do |item|
    Item.create(
      name: item['name'],
      description: item['description'],
      seller_id: item['seller_id'],
      listing_date: item['listing_date'],
      listed_price: item['listed_price']
    )
  end
end

Given /^(?:|I )log in as "([^"]*)"$/ do |username|
  @user=User.find_by(username:username)
  @user_id=@user.id
end

Then /(.*) items should exist/ do | n_seeds |
  expect(Item.count).to eq n_seeds.to_i
end

When /^(?:|I )am in (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )am at my store "([^"]*)"$/ do |store_name|
  @store=Seller.find_by(name:store_name)
  @store_id=@store.id
  visit path_to('my store page')
end

When("I complete the item post form") do
  @name="Fujifilm Quicksnap 135 Flash 400 2pk Camera"
  @price="22.99"
  @date="2023-11-13"
  @seller=@store_id
  fill_in "name", with: @name
  fill_in "price", with: @price
  fill_in "date", with: @date
  fill_in "description", with:@description
  click_button "Post the item"
  Item.create(
    name: @name,
    price: @price,
    date: @date,
    description: @description,
    seller_id:@seller
  )
end

Then 'I should see my item in my store' do
  the_item=Item.find_by(name:@name, price:@price, date:@date, description:@description, seller_id:@seller)
  the_id=the_item.id
  # TODO: path for one's store
  expect(current_path).to eq('/users/'+the_id.to_s)
  expect(page).to have_content(@name, price:@price, date:@date, description:@description)
end

When /^(?:|I )update the price of "([^"]*)" with "([^"]*)"$/ do |name, new_price|
  the_item=Item.find_by(name:name)
  the_id=the_item.id
  Item.update(the_id,listed_price:new_price)

  end

Then /^(?:|I )should see "([^"]*)" with "([^"]*)"$/ do |name, new_price|
  the_item=Item.find_by(name:name)
  expect(the_item.listed_price).to eq(new_price)
end

And /^(?:|I )should not see "([^"]*)" with "([^"]*)"$/ do |name, old_price|
  the_item=Item.find_by(name:name)
  expect(the_item.listed_price).not eq(old_price)
end



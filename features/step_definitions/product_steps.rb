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

And /^(?:|I )am at my store "([^"]*)"$/ do |store_name|
  @store=Seller.find_by(name:store_name)
  unless @store.nil?
    puts('@store=',@store.id)
    @store_id = @store.id
  end
  visit path_to('my store page')
end

When 'I want to add an item' do
  click_link('Add Item')
end

When("I complete the item post form") do
  @name="Fujifilm Quicksnap 135 Flash 400 2pk Camera"
  @price="22.99"
  @date="2023-11-13"
  @seller=@store_id
  category='Shoes'
  fill_in "Name", with: @name
  fill_in "Description", with:@description
  fill_in "Listed price", with: @price
  fill_in "Listing date", with: @date

  select category, from: 'item[category_ids][]'
  click_button "Create Item"

  Item.create(
    name: @name,
    price: @price,
    date: @date,
    description: @description,
    seller_id:@seller
  )
end

Then 'I should see my item in my store' do
  # the_item=Item.find_by(name:@name, price:@price, date:@date, description:@description, seller_id:@seller)
  # the_id=the_item.id
  # expect(current_path).to eq('/users/'+the_id.to_s)
  expect(page).to have_content(@name)
  expect(page).to have_content(@price)
  expect(page).to have_content(date:@date)
  expect(page).to have_content(description:@description)
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



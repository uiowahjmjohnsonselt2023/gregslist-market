Given /the following items exist/ do |items_table|
  items_table.hashes.each do |item|
    Item.create(
      name: item['name'],
      description: item['description'],
      listing_date: item['listing_date'],
      listed_price: item['listed_price'],
      seller_id:item['seller_id']
    )
  end
end

Given /the following categories exist/ do |categories_table|
  categories_table.hashes.each do |category|
    Category.create(
      name: category['name']
    )
  end
end

Given("the following associations between category and item exist") do |association_table|
  association_table.hashes.each do |row|
    category = Category.find_by(id: row['category_id'])
    item = Item.find_by(id: row['item_id'])
    item.categories << category
  end
end

Then /(.*) products should exist/ do | n_seeds |
  expect(Item.count).to eq n_seeds.to_i
end

When /^(?:|I )am in (.+) as the store owner$/ do |store_name|
  store=Seller.find_by(name:store_name)
  @store_id=store.id
  visit "/sellers/#{@store_id}"
end

When 'I want to add an item' do
  click_link('Add Item')
end

When("I complete the product post form") do
  @name="Camera"
  @price="22.99"
  @date="2023/11/13"
  # @category="electronics"
  @description="Fujifilm Quicksnap 135 Flash 400 2pk"

  fill_in "Name", with: @name
  fill_in "Description", with: @description
  fill_in "item[listing_date]", with: @date
  # fill_in "Listing date", with: @date
  fill_in "Listed price", with: @price
  # fill_in "Category", with:@category
  click_button "Create Item"
  Item.create(
    name: @name,
    description:@description,
    listing_date: @date,
    listed_price: @price,
    # category: @category,
    seller_id:@store_id
  )
end

Then 'I should see my product in my store' do
  the_item=Item.find_by(name:@name, description:@description, listed_price:@price, listing_date:@date, seller_id:@store_id)
  expect(current_path).to eq("/sellers/#{@store_id}")
  expect(page).to have_content(the_item.name)
  expect(page).to have_content(the_item.description)
end

When /^(?:|I )update the price of "([^"]*)" with "([^"]*)"$/ do |name, new_price|
  the_item=Item.where(name:name,seller_id:@store_id).first
  if the_item.present?
    the_id=the_item.id
    visit "items/#{the_id}/edit"
    fill_in "Listed price", with: new_price
    click_button "Update Item"
    the_item.listed_price=new_price
    the_item.save!
    end

  end

Then /^(?:|I )should see "([^"]*)" with "([^"]*)"$/ do |name, new_price|
  the_item=Item.find_by(name:name)
  expect(the_item.listed_price).to eq(new_price)
end

And /^(?:|I )should not see "([^"]*)" with "([^"]*)"$/ do |name, old_price|
  the_item=Item.find_by(name:name)
  expect(the_item.listed_price).not eq(old_price)
end



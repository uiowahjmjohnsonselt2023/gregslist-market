Given /my following stores exist/ do |sellers_table|
  sellers_table.hashes.each do |seller|
    Seller.create(
      name: seller['name'],
      description: seller['description'],
      address: seller['address']
    )
  end
end


When 'I want to access my seller account' do
  click_link('Access Seller accounts')
end

Then 'I should see my existing seller accounts' do
  stores=Seller_user.find_by(:id => 1)
  stores.each do |store|
    expect(page).to have_content(store.name)
  end
end

When 'I select one of my seller account' do
  stores=Seller_user.find_by(:id => 1)
  @store=stores[1]
  click_button('Select')
end

And "I should see my store's name" do
  expect(page).to have_content(@store.name)
end

And "I don't have existing seller account yet" do
  click_button('Create new Seller account')
end

When 'I complete the seller edit form' do
  @name = "cindy's 1 store"
  @description = "the very first one"
  @address = "123 road, IA"

  fill_in "name", with: @name
  fill_in "description", with: @description
  fill_in "address", with: @address

  click_button "Create store account"
  @store=Seller.create(
    name: @name,
    description: @description,
    address: @address
  )
end
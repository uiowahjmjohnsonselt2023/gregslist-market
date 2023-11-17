Given /the following stores exist/ do |sellers_table|
  sellers_table.hashes.each do |seller|
    Seller.create(
      name: seller['name'],
      description: seller['description'],
      address: seller['address']
    )
  end
end

Given("the following associations exist") do |association_table|
  association_table.hashes.each do |row|
    user = User.find_by(id: row['user_id'])
    seller = Seller.find_by(id: row['seller_id'])
    seller.user << user
  end
end

When 'I want to access my seller account' do
  click_link('Access Seller accounts')
end

# Then 'I should see my existing seller accounts' do
#   seller =@user.sellers
#   #seller_name = seller.name
#   puts('user email=',@user.email)
#   puts('seller name=',seller)
#   stores.each do |store|
#     print('num=',1)
#     print('store=',store)
#     #expect(page).to have_content(store.name)
#   end
# end



And "I don't have existing seller account yet" do
  click_link('Create new Seller account')
end

When 'I complete the seller edit form' do
  name = "cindy's 1 store"
  description = "the very first one"
  address = "123 road, IA"
  fill_in "Name", with: name
  fill_in "Description", with: description
  fill_in "Address", with: address
  click_button "Create store account"
  @store=Seller.find_by(name:name)
  @store_id=@store.id
end
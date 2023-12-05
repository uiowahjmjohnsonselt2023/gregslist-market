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
    seller.users << user
  end
end

When 'I want to access my seller account' do
  click_link('Access Seller accounts')
end

Then 'I should see all my existing seller accounts' do
  user = @user
  puts('user=',user.name)
  seller_accounts = user.seller

  seller_accounts.each do |seller|
    puts('seller.name=',seller.name)
    expect(page).to have_content(seller.name)
  end

end

And "I don't have existing seller account yet" do
  click_link('Create new Seller account')
end

When 'I complete the seller edit form' do
  name = "alice's 1 store"
  description = "the very first alice shop"
  address = "A223 road, IA"
  fill_in "Name", with: name
  fill_in "Description", with: description
  fill_in "Address", with: address
  click_button "Create store account"
  Seller.create(
    name: name,
    description: description,
    address: address
  )
  @store=Seller.find_by(name:name)
  @store_id=@store.id
end

When /^(?:|I )select the seller account with the name "([^"]*)"$/  do |name|
  select name, from: 'seller[id]'
  click_button "Select"
  @store=Seller.find_by(name:name)
  @store_id=@store.id
end

Then 'I should be in my store' do
  expect(current_path).to eq("/sellers/#{@store_id}")
end
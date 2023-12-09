Given /the following buyers exist/ do |buyers_table|
  buyers_table.hashes.each do |buyer|
    Buyer.create(
      first_name: buyer['first name'],
      last_name: buyer['last name'],
      payment_method: buyer['payment method'],
      address: buyer['address'],
      user_id:buyer['user id']
    )
  end
end

When("I complete the edit form") do
  @first_name="Joe"
  @last_name="Jans"
  @address="1234 King road, TN"
  @payment_method="Master"

  fill_in "First name", with: @first_name
  fill_in "Last name", with: @last_name
  fill_in "Address", with: @address
  fill_in "Payment method", with: @payment_method
  click_button "Save buyer account"
  Buyer.create(
    first_name: @first_name,
    last_name: @last_name,
    payment_method: @payment_method,
    address: @address,
    user_id: @user_id
  )
end

When /^(?:|I )add "([^"]*)" sold by "([^"]*)" to my cart$/ do |item_name, seller_name|
  @store_id=Seller.find_by(name:seller_name).id
  within('.card-body', text: item_name) do
    if has_selector?('h6.card-subtitle.mb-2.text-muted', text: seller_name)
      click_button "Add To Cart!"
    end
  end
end

When /^(?:|I )remove "([^"]*)" sold by "([^"]*)" from my cart$/ do |item_name, seller_name|
  @store_id=Seller.find_by(name:seller_name).id
  within('li', text: item_name) do
    click_button 'Remove from Cart'

  end
end

When 'I want to checkout' do
  visit path_to('the cart page')
  click_link 'Proceed to Checkout'
end

When("I complete the checkout steps") do
  address="2224 King st"
  city="NYC"
  state="NY"
  zip="64933"
  card_number="1111222233334444"
  expiration="3/18/2029"
  cvv="027"
  fill_in "adr", with: address
  fill_in "city", with: city
  fill_in "state", with: state
  fill_in "zip", with: zip
  fill_in "ccnum", with: card_number
  fill_in "expmonth", with: expiration
  fill_in "cvvnum", with: cvv
  click_button "Check Out!"
  Purchase.create(
    user_id: @user_id,
    total_price: @payment_method
  )
end

And /"([^"]*)" should be in my cart$/ do |item_name|
  visit path_to('the cart page')
  expect(page).to have_content(item_name)
end

And /"([^"]*)" should not be in my cart$/ do |item_name|
  expect(page).not_to have_content(item_name)
end
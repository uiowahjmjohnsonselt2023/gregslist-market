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
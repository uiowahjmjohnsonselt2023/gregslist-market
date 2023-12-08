When("I complete the edit form") do
  @first_name="sprint second"
  @last_name="sp2-1"
  @address="secret"
  @payment_method="sp2-1@gmail.com"

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
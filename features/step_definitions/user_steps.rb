Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(
      name: user['name'],
      username: user['username'],
      password: user['password'],
      email: user['email'],
      activated: user['activated']
    )
  end
end

Then /(.*) users should exist/ do | n_seeds |
  expect(User.count).to eq n_seeds.to_i
end

When /^(?:|I )log in with email "([^"]*)" and password "([^"]*)"$/  do |email, password|
  @email=email.gsub(/@/, '%40')
  @user=User.find_by(email:email)
  @user_id=@user.id
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Log in"
end

When /^(?:|I )log in with email "([^"]*)" and forget my password$/  do |email|
  click_link 'forgot password'
  puts('current=',current_path)
  @user=User.find_by(email:email)
  @user_id=@user.id
  puts('user=',@user_id)
  User.all.each do |user|
    puts "Email: #{user.email}"
  end
  fill_in "Email", with: email
  click_button "Submit"
  expect(page).to have_content('Email address not found')
end

When "I log out"  do
  click_link "Log out"
end

When /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )should be on (.+)$/ do |page_name|
  expect(current_path).to eq(path_to(page_name))
end

Then /^(?:|I )should not be on (.+)$/ do |page_name|
  expect(current_path).not_to eq(page_name)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

And /^(?:|I )fill in "([^"]*)"$/ do |field|
  fill_in(field)
end

When("I complete the signup form") do
  @name="sprint second"
  @username="sp2-1"
  @password="secret"
  @password_confirmation="secret"
  @email="sp2-1@gmail.com"
  fill_in "user_name", with: @name
  fill_in "user_username", with: @username
  fill_in "user_password", with: @password
  fill_in "user_password_confirmation", with: @password_confirmation
  fill_in "user_email", with: @email
  click_button "Create my account"
  User.create(
    name: @name,
    username: @username,
    password: @password,
    email: @email
  )
end

And 'I check out the email' do
  save_and_open_page
  click_link("Reset password")

end

Then 'I should see my profile' do
  the_user=User.find_by(email:@email)
  the_id=the_user.id
  expect(current_path).to eq('/users/'+the_id.to_s)
end

Then /^(?:|I )should see my name "([^"]*)"$/ do |name|
  expect(page).to have_content(name)
end

Then 'I should see my name includes in the welcome message' do
  except_content="Welcome, "+@name+"!"
  expect(page).to have_content(except_content)
end

Then("I should see my new address") do
  expect(page).to have_content(@new_address)
end

Then("I should see the field for {string}") do |field_name|
  expect(page).to have_field(field_name)
end

# And /^(?:|I )delete the user whose username is "([^"]*)"$/ do |name|
#
# end

And "I activate my account" do
  the_user=User.find_by(email:@email)
  the_user.activated=true
  the_user.save!
  visit path_to('the homepage')
end

And "I log in with the information" do
  visit path_to('the login page')
  @user=User.find_by(email:@email)
  @user_id=@user.id
  fill_in "Email", with: @email
  fill_in "Password", with: @password
  click_button "Log in"
end

Then 'I should see my orders in the history' do
  orders=Purchase.where(user_id:@user_id)
  last_order=Purchase.where(user_id:@user_id).last
  order_number=orders.count
  order_total_price = sprintf('%.2f', last_order.total_price)

  expect(page).to have_content("Total Orders: #{order_number}")
  expect(page).to have_content("Total Spent: $#{order_total_price}")
end

And 'I delete my account' do
  User.destroy(id:@user_id)
end
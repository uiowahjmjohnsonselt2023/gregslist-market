
Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(
      name: user['name'],
      username: user['username'],
      password: user['password'],
      email: user['email']
    )
  end
end


When /^(?:|I )log in with email "([^"]*)" and password "([^"]*)"$/  do |email, password|
  @login_email = email
  @login_password = password
  fill_in "Email", with: @login_email
  fill_in "Password", with: @login_password
  click_button "Log in"
end
When "I log out"  do
  click_button "Log out"
end

When /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )should be on (.+)$/ do |page_name|
  expect(current_path).to eq(page_name)
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
  @signup_name="t5name"
  @signup_username="t5user"
  @signup_password="t5555556"
  @signup_password_confirmation="t5555556"
  @signup_email="t5@gmail.com"
  fill_in "user_name", with: @signup_name
  fill_in "user_username", with: @signup_username
  fill_in "user_password", with: @signup_password
  fill_in "user_password_confirmation", with: @signup_password_confirmation
  fill_in "user_email", with: @signup_email
  click_button "Create my account"
end

When "I sign in" do
  @login_email = "t5@gmail.com"
  @login_password = "t5555556"
  fill_in "Email", with: @login_email
  fill_in "Password", with: @login_password
  click_button "Log in"
end

Then /^(?:|I )should see my name "([^"]*)"$/ do |name|
  expect(page).to have_content(name)
end

Then("I should see my new address") do
  expect(page).to have_content(@new_address)
end

Then("I should see the field for {string}") do |field_name|
  expect(page).to have_field(field_name)
end
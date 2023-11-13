
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
  @email = email
  @password = password
  fill_in "Email", with: @email
  fill_in "Password", with: @password
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

Then 'I should see my profile' do
  the_user=User.find_by(email:@email)
  the_id=the_user.id
  expect(current_path).to eq('/users/'+the_id.to_s)
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
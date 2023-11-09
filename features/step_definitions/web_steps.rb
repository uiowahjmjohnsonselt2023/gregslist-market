require 'uri'
require 'cgi'

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)


Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(
      username: user['username'],
      password: user['password'],
      email: user['email'],
      address:""
    )
  end
end

When /^(?:|I )log in as "([^"]*)"$/  do |username|
  @logged_in_user = username
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
  @signup_username=fill_in "username", with: "cucum1"
  @signup_password=fill_in "password", with: "ck1231KIas"
  @signup_email=fill_in "email address", with: "ccumt9899@gmail.com"
  click_button "Sign up"
  User.create!(
    username: @signup_username,
    password: @signup_password,
    email: @signup_email
  )
end

Then("I should be registered as a new user") do
  user = User.find_by(@signup_username)
end

Then("I should see my user information") do
  expect(page).to have_content(User.username)
  expect(page).to have_content(User.password)
  expect(page).to have_content(User.email)
end

Then("I should see my new address") do
  expect(page).to have_content(@new_address)
end

And "I edit my address" do
  user = User.find_by(@logged_in_user)
  @new_address="456 Updated St, Iowa City, USA"
  if user
    user.update(address: @new_address)
    user.save
  end
end

Then("I should see the field for {string}") do |field_name|
  expect(page).to have_field(field_name)
end
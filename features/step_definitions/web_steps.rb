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
      name: user['name'],
      username: user['username'],
      password_digest: user['password_digest'],
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
  @signup_name="coconaceas"
  @signup_username="cucum123"
  @signup_password="ck1231KIas1"
  @signup_password_confirmation="ck1231KIas1"
  @signup_email="ccumt98@gmail.com"
  fill_in "user_name", with: @signup_name
  fill_in "user_username", with: @signup_username
  fill_in "user_password", with: @signup_password
  fill_in "user_password_confirmation", with: @signup_password_confirmation
  fill_in "user_email", with: @signup_email
  click_button "Create my account"


end

When "I sign in" do
  @login_email = "ccumt98@gmail.com"
  @login_password = "ck1231KIas1"
  fill_in "Email", with: @login_email
  fill_in "Password", with: @login_password
  click_button "Log in"
end

Then("I should be a valid user") do
  user=User.new(
    name: @signup_name,
    username: @signup_username,
    email: @signup_email,
    password: @signup_password
  )
  expect(user.valid?).to be true
  user.save
  expect(User.find_by(email: @signup_email)).not_to be_nil
end

Then("I should be a valid seller") do
  seller=Seller.new(
    name: @signup_name,
    username: @signup_username,
    email: @signup_email,
    password: @signup_password,
    password_confirmation: @signup_password_confirmation
  )
  expect(seller.valid?).to be true
  seller.save
  expect(Seller.find_by(email: @signup_email)).not_to be_nil
end

Then("I should see my user information") do
  expect(page).to have_content(User.username)
  expect(page).to have_content(User.password)
  expect(page).to have_content(User.email)
end

Then /^(?:|I )should see my name "([^"]*)"$/ do |name|
  expect(page).to have_content(name)
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
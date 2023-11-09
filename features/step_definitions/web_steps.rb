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
  @signup_name="coconace"
  @signup_username="cucum1"
  @signup_password=@signup_password_confirmation="ck1231KIas"
  @signup_email="ccumt98901@gmail.com"
  fill_in "user_name", with: @signup_name
  fill_in "user_username", with: @signup_username
  fill_in "user_password", with: @signup_password
  fill_in "user_password_confirmation", with: @signup_password_confirmation
  fill_in "user_email", with: @signup_email
  click_button "Create my account"


end

Then("I should be registered as a new user") do
  user=User.new(
    name: @signup_name,
    username: @signup_username,
    email: @signup_email,
    password: @signup_password,
    password_confirmation: @signup_password_confirmation
  )
  expect(user.valid?).to be true
  user.save
  expect(User.find_by(email: @signup_email)).not_to be_nil

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
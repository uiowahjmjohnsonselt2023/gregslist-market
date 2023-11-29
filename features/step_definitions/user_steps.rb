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
  @user=User.find_by(email:email)
  @user_id=@user.id
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Log in"
end

And /^(?:|I )should be on (.+)$/ do |page_name|
  expect(current_path).to eq(path_to(page_name))
end
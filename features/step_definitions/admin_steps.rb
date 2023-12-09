When "I log in as an admin"  do
  @user=User.find_by(email:'admin@example.com')
  @user_id=@user.id
  fill_in "Email", with: 'admin@example.com'
  fill_in "Password", with: 'password'
  click_button "Log in"
end

And /^(?:|I )delete the user whose username is "([^"]*)"$/  do |username|
  click_button "Destroy"

end

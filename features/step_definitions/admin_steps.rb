When "I log in as an admin"  do
  @user=User.find_by(email:'admin@example.com')
  @user_id=@user.id
  visit path_to('the login page')
  fill_in "Email", with: @user.email
  fill_in "Password", with: 'password'
  click_button "Log in"
end

When 'I want to delete unqualified users' do
  save_and_open_page
  click_link 'Manage User Accounts'
end

# And /^(?:|I )delete the user whose name is "([^"]*)" and username is "([^"]*)"$/  do |name,username|
#   user_lis = page.all('ul.users li').select do |li|
#     li.has_text?("Name: #{name}") && li.has_text?("Username: #{username}")  end
#   user_li = user_lis.first
#   delete_button = user_li.find('a', text: 'Delete User')
#   delete_button.click
#   @deleted_user=User.find_by(name:name,username:username)
#   @deleted_user.destroy
# end
#
# Then 'I should see all the users without the deleted user' do
#   User.all.each do |user|
#     if user!=@deleted_user
#     expect(page).to have_content(user.name)
#     expect(page).to have_content(user.username)
#     end
#   end
# end
# And I should not see "kevin_pjk" on the users list

# Then 'I should see all my existing seller accounts' do
#   user = @user
#   seller_accounts = user.seller
#
#   seller_accounts.each do |seller|
#     expect(page).to have_content(seller.name)
#   end
#
# end
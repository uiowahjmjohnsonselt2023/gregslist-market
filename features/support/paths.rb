# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by user_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in user_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /^the (gregslist )?home\s?page$/ then ''
    when /^the user signup page$/ then '/signup'
    #when /^my profile page$/ then '/users/1'
    when /^my profile page$/ then "/users/#{@user_id}"
    when /^select store page$/ then '/select_seller'

    #when /^the store page$/ then "/sellers/#{@store_id}"
    when /^the login page$/ then '/login'
    when /^the buyer edit page$/ then "/buyers/new?id=#{@user_id}"
    when /^the admin page$/ then '/users/1'
    when /^the users list page$/ then '/users'
    when /^the reset password page$/ then password_reset_path(@user_id)

    # when /^the reset password page$/ then "/password_resets/ceK0DoAvzR5b46jCVteL7g/edit?email=#{@email}"
    when /^the search result page$/ then "/items?search%5Bq%5D=#{@search_name}&commit=Search%21"
    when /^the cart page$/ then "/carts/#{@user_id}"
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
class HelpRequestsController < ApplicationController

  def create


  # Handle the form submission logic here
  # Access form parameters using params[:name], params[:email], params[:description]

  # For example, you might want to save the help request to a database
  # and notify the admin or perform any other necessary actions.

  flash[:success] = "Your help request has been submitted. We will get back to you soon!"
  redirect_to root_path
end
end

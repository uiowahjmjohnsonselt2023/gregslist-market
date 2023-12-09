# require './spec/rails_helper'
#
# RSpec.describe HelpRequestsController, type: :controller do
#   describe 'POST #create' do
#     it 'redirects to the root path with a success flash message' do
#       # Simulate a form submission
#       post :create, params: { name: 'John Doe', email: 'john@example.com', description: 'Help me!' }
#
#       # Check if the flash message is set
#       expect(flash[:success]).to eq("Your help request has been submitted. We will get back to you soon!")
#
#       # Check if the redirection to the root path is successful
#       expect(response).to redirect_to(root_path)
#     end
#   end
# end
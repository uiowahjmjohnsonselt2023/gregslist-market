require './spec/rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'DELETE #destroy' do
    it 'clears the session and logs the user out' do
      # Simulate a user being logged in by creating a session token
      session[:session_token] = 'example_session_token'

      delete :destroy

      expect(session[:session_token]).to be_nil
      expect(assigns(:current_user)).to be_nil
      expect(flash[:notice]).to eq('You have been logged out.')
      expect(response).to redirect_to(root_path)
    end
  end
end
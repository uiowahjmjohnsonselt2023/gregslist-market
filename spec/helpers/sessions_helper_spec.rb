# spec/helpers/session_helper_spec.rb

require './spec/rails_helper'
# Include the SessionHelper module for testing
include SessionsHelper

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) } # You can use FactoryBot for test data

  describe '#log_in' do
    it 'logs in the user' do
      log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe '#log_out' do
    it 'logs out the user' do
      session[:user_id] = user.id
      log_out
      expect(session[:user_id]).to be_nil
    end
  end

  describe '#current_user' do
    it 'returns the current user' do
      session[:user_id] = user.id
      expect(current_user).to eq(user)
    end
  end

  describe '#logged_in?' do
    context 'when a user is logged in' do
      it 'returns true' do
        session[:user_id] = user.id
        expect(logged_in?).to be true
      end
    end

    context 'when no user is logged in' do
      it 'returns false' do
        session[:user_id] = nil
        expect(logged_in?).to be false
      end
    end
  end
end
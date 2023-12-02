require './spec/rails_helper'


RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when the user is already logged in' do
      let(:logged_in_user) { User.create(
        name: 'Mike',
        username: 'mike_doe',
        password: 'passwordisSerect',
        email: 'mike@gmail.com'
      ) }

      before do
        allow(controller).to receive(:logged_in?).and_return(true)
        get :new
      end

      it 'sets a flash message' do
        expect(flash[:info]).to eq('You are already logged in.')
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user is not logged in' do
      before { get :new }

      it 'does not set a flash message' do
        expect(flash[:info]).to be_nil
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end


end
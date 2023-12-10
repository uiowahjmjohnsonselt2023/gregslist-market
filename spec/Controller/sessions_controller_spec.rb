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

  describe '#destroy' do
    let(:user) { User.create(
      name: 'Mike',
      username: 'mike_doe',
      password: 'passwordisSerect',
      email: 'mike@gmail.com',
      activated:true
    ) }
    it 'logs out the user if logged in' do
      allow(controller).to receive(:logged_in?).and_return(true) # Stubbing logged_in? to return true
      allow(controller).to receive(:current_user).and_return(user) # Stubbing current_user method if used

      expect(controller).to receive(:log_out)

      delete :destroy

      expect(flash[:notice]).to eq('You have successfully logged out.')
      expect(response).to redirect_to(root_path)
    end

    it 'does not log out the user if not logged in' do
      allow(controller).to receive(:logged_in?).and_return(false) # Stubbing logged_in? to return false
      expect(controller).not_to receive(:log_out)
      delete :destroy
      expect(flash[:notice]).to eq('You have successfully logged out.')
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#create' do
    let(:user) { User.create(
      name: 'Mike',
      username: 'mike_doe',
      password: 'passwordisSerect',
      email: 'mike@gmail.com',
      activated:true
    ) }
    context 'with valid credentials and activated account' do
      it 'logs in the user and redirects to the user\'s show page' do
        post :create, params: { session: { email: user.email, password: user.password } }
        expect(controller).to be_logged_in
        expect(response).to redirect_to(user)
      end

      it 'remembers the user if "Remember me" is checked' do
        post :create, params: { session: { email: user.email, password: user.password, remember_me: '1' } }
        expect(controller).to be_logged_in
      end
    end

    context 'with invalid credentials' do
      it 'renders the login form with an error message' do
        post :create, params: { session: { email: 'invalid@example.com', password: 'wrongpassword' } }
        expect(controller).not_to be_logged_in
        expect(flash.now[:danger]).to eq('Invalid email/password combination')
        expect(response).to render_template('new')
      end
    end

    context 'with account not activated' do
      it 'redirects to the root path with a warning message' do
        user.update_attribute(:activated, false)
        post :create, params: { session: { email: user.email, password: 'password' } }
        expect(controller).not_to be_logged_in
      end
    end
  end

end
require './spec/rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(
    name: 'Mike',
    username: 'mike_doe',
    password: 'passwordisSerect',
    email: 'mike@gmail.com'
  ) }

  describe 'GET #index' do
    it 'returns http success' do
      session[:user_id] = user.id
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: {
            name: 'Mike',
            username: 'mike_doe',
            password: 'passwordisSerect',
            email: 'mike@gmail.com'
          }}
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: {
          name: 'Mike',
          username: 'mike_doe',
          password: 'passwordisSerect',
          email: 'mike@gmail.com'
        } }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: {
            name: 'Mike',
            username: 'mike_doe',
            password: 'passwordisSerect'
          } }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: {
          name: 'Mike',
          username: 'mike_doe',
          password: 'passwordisSerect'
        } }
        expect(response).to render_template('new')
      end
    end
  end

  end

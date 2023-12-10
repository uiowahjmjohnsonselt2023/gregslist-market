require './spec/rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(
    name: 'Mike',
    username: 'mike_doe',
    password: 'passwordisSerect',
    email: 'mike@gmail.com',
    activated:true
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



    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: {
            name: 'Mike',
            username: 'mike_doe',
            password: 'passwordisSerect',
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

  describe 'PATCH #update' do
    it 'updates the user profile' do
      # Assuming user is logged in, or you can handle authentication in your test
      allow(controller).to receive(:current_user).and_return(user)

      new_name = 'Updated Mike'
      patch :update, params: { id: user.id, user: { name: new_name } }

      user.reload # Reload the user from the database to get the updated attributes

      expect(user.name).to eq(new_name)
      expect(flash[:success]).to eq('Profile updated')
      expect(response).to redirect_to(user)
    end

    it 'handles failed user profile update' do
      # Assuming user is logged in, or you can handle authentication in your test
      allow(controller).to receive(:current_user).and_return(user)

      # Simulate a failure to update the user
      allow(user).to receive(:update).and_return(false)

      patch :update, params: { id: user.id, user: { name: 'Invalid Name' } }
      expect(response).to have_http_status(:redirect)
      # expect(response).to render_template('edit')
    end
  end


  end



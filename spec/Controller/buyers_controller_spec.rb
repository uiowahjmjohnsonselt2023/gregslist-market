require './spec/rails_helper'

RSpec.describe BuyersController, type: :controller do
  let(:user) { User.create(
    name: 'Mike',
    username: 'mike_doe',
    password: 'passwordisSerect',
    email: 'mike@gmail.com',
    activated: true
  ) }
  let(:buyer) { Buyer.create(
    first_name: 'Mike',
    last_name: 'Doe',
    payment_method: 'VISA',
    address: '112 Queen, NY',
    user_id: 1
  ) }

  describe 'GET #show' do
    it 'renders the show template' do
      user
      get :show, params: { id: buyer.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    context 'when buyer is not present' do
      it 'redirects to new_buyer_path' do
        # Assuming there is no buyer associated with the user
        get :edit, params: { id: user.id }
        expect(response).to redirect_to(new_buyer_path(id: user.id))
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new buyer and redirects to user' do
        buyer_params = {
          first_name: 'John',
          last_name: 'Doe',
          payment_method: 'VISA',
          address: '123 Main St',
          user_id: user.id
        }

        expect do
          post :create, params: { buyer: buyer_params }
        end.to change(Buyer, :count).by(1)

        expect(response).to redirect_to(user_path(user))
        expect(flash[:error]).to be_nil
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new buyer and renders new template' do
        invalid_buyer_params = {
          first_name: 'John',
          last_name: 'Doe'
        }

        expect do
          post :create, params: { buyer: invalid_buyer_params }
        end.to_not change(Buyer, :count)

        expect(response).to render_template(:new)
        expect(flash[:error]).to eq('Invalid purchase info')
      end
    end
  end

end

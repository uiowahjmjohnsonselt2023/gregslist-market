require './spec/rails_helper'

RSpec.describe BuyersController, type: :controller do
  let(:user) { User.create(
    name: 'Mike',
    username: 'mike_doe',
    password: 'passwordisSerect',
    email: 'mike@gmail.com'
  ) }
  let(:buyer) { Buyer.create(
    first_name: 'Mike',
    last_name: 'Doe',
    payment_method: 'VISA',
    address: '112 Queen, NY'
  ) }

  describe 'GET #show' do
    it 'renders the show template' do
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


end

require './spec/rails_helper'

RSpec.describe SellersController, type: :controller do
  let(:user) { User.create(name: 'John Doe', username: 'john_doe', email: 'john@example.com', password: 'password') }
  let(:seller) { Seller.create(name: 'Test Seller', description: 'Test Description', address: '123 Main St') }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:seller)).to be_a_new(Seller)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new seller' do
        expect {
          post :create, params: { seller: { name: 'New Seller', description: 'New Description', address: '456 Side St' } }
        }.to change(Seller, :count).by(1)
        expect(response).to redirect_to(seller_path(assigns(:seller)))
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested seller and its items to @seller and @items' do
      get :show, params: { id: seller.id }

      expect(assigns(:seller)).to eq(seller)
      expect(assigns(:items)).to eq(seller.items)
    end

    it 'renders the show template' do
      get :show, params: { id: seller.id }

      expect(response).to render_template(:show)
    end
  end

  describe 'GET #select' do


    it 'renders the select template' do
      get :select

      expect(response).to render_template(:select)
    end
  end

end

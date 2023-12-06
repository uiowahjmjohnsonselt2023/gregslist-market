require './spec/rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:seller) { Seller.create(name: 'Test Seller', address: '123 Main St') }
  let(:item) { Item.create(
    name: 'Test Item',
    description: 'Description',
    listing_date: '2023-12-01',
    listed_price: '10',
    seller_id: seller.id
  ) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { seller_id: seller.id }
      expect(response).to render_template(:new)
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new item' do
        expect {
          post :create, params: { item: {
            name: 'Nike shoes',
            description: 'The limited version',
            listing_date: '2023-12-01',
            listed_price: '17',
            seller_id: seller.id
          }}
        }.to change(Item, :count).by(1)
        expect(response).to redirect_to(seller_path(seller))
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        post :create, params: { item: { name: '', listed_price: -5 }, seller_id: seller.id }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: item.id }
      expect(response).to render_template(:edit)
      expect(assigns(:item)).to eq(item)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the item' do
        patch :update, params: { id: item.id, item: { name: 'Updated Item', listed_price: 20 } }
        item.reload
        expect(item.name).to eq('Updated Item')
        expect(flash[:notice]).to eq('Item updated')
        expect(response).to redirect_to(item_path(item))
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders the edit template' do
    #     patch :update, params: { id: item.id, item: { name: '', listed_price: -5 } }
    #     expect(response).to render_template(:edit)
    #   end
    # end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: item.id }
      expect(response).to render_template(:show)
      expect(assigns(:item)).to eq(item)
    end
  end
end

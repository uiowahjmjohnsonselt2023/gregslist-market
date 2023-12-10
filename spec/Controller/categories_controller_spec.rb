require './spec/rails_helper'

RSpec.describe CategoriesController, type: :controller do
  # let(:valid_seller_id) { 1 }
  # let(:valid_category_params) { { category: { name: 'Test Category' } } }
  let(:valid_seller) { Seller.create(
    name: "Mike's store",
    description: "Mike's store sells all you need",
    address: '123 King St, IA'
  ) }
  let(:category1) { Category.create(
    name: 'shoes'
  )}
  let(:category2) { Category.create(
    name: ''
  )}

  describe 'GET #index' do
    it 'renders the index template' do
      get :index, params: { seller_id: valid_seller.id }
      expect(response).to render_template(:index)
    end

    it 'assigns @categories' do
      get :index, params: { seller_id: valid_seller.id }
      expect(assigns(:categories)).to eq([category1])
    end


  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { seller_id: valid_seller.id }
      expect(response).to render_template(:new)
    end

  end



end

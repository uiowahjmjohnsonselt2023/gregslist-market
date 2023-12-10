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

  describe '#category_params' do
    it 'permits the required attributes' do
      permitted_params = { category: { name: 'Test Category' } }
      controller.params = ActionController::Parameters.new(permitted_params)
      expected_params = permitted_params[:category].transform_keys(&:to_s)
      expect(controller.send(:category_params).to_h).to eq(expected_params)
    end

    it 'raises an error if required attributes are missing' do
      expect {
        controller.params = ActionController::Parameters.new({})
        controller.send(:category_params)
      }.to raise_error(ActionController::ParameterMissing)
    end

    it 'permits only the specified attributes' do
      permitted_params = { category: { name: 'Test Category', description: 'Description' } }
      controller.params = ActionController::Parameters.new(permitted_params)

      expected_params = permitted_params[:category].slice(:name).to_h.with_indifferent_access
      expect(controller.send(:category_params).to_h).to eq(expected_params)
    end
  end

  describe '#create' do
    before { session[:seller_id] = valid_seller.id }

    context 'with valid parameters' do
      let(:valid_params) { { category: { name: 'Test Category' } } }

      it 'creates a new category' do
        expect {
          post :create, params: valid_params
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the categories path with a notice' do
        post :create, params: valid_params
        expect(response).to redirect_to(categories_path)
        expect(flash[:notice]).to eq('Category was successfully created.')
      end
    end

    end
end

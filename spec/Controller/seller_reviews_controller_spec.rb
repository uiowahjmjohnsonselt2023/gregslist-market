require './spec/rails_helper'

RSpec.describe SellerReviewsController, type: :controller do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  let(:seller_review) { SellerReview.create(rating: 4, text: 'Great experience') }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:review)).to be_a_new(SellerReview)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new seller review' do
        expect {
          post :create, params: { review: { rating: 5, text: 'Excellent experience' } }
        }.to change(SellerReview, :count).by(1)

        expect(response).to redirect_to(assigns(:review))
        expect(flash[:notice]).to eq('Review updated')
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template and sets flash[:error]' do
        post :create, params: { review: { rating: 6, text: '' } }

        expect(response).to render_template(:new)
        expect(flash[:error]).to eq('NEW')
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: seller_review.id }
      expect(response).to render_template(:edit)
      expect(assigns(:review)).to eq(seller_review)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the seller review and redirects to the review page' do
        patch :update, params: { review: { id: seller_review.id, rating: 3, text: 'Average experience' } }
        seller_review.reload

        expect(seller_review.rating).to eq(3)
        expect(seller_review.text).to eq('Average experience')
        expect(flash[:notice]).to eq('Review updated')
        expect(response).to redirect_to(assigns(:review))
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template and sets flash[:error]' do
        patch :update, params: { review: { id: seller_review.id, rating: 6, text: '' } }

        expect(response).to render_template(:edit)
        expect(flash[:error]).to eq('NEW')
      end
    end
  end
end

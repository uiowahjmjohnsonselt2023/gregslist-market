require './spec/rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:seller) { Seller.create(name: 'Test Seller', description: 'Test Description', address: '123 Main St') }
  let(:cart) { Cart.create }
  describe '#current_seller' do
    context 'when session[:seller_id] is set' do
      before { session[:seller_id] = seller.id }

      it 'returns the current seller' do
        expect(controller.send(:current_seller)).to eq(seller)
      end

      it 'memorizes the result' do
        expect(controller.send(:current_seller)).to eq(seller)
        end
    end

    context 'when session[:seller_id] is not set' do
      before { session[:seller_id] = nil }
      it 'returns nil' do
        expect(controller.send(:current_seller)).to be_nil
      end
    end
  end

  describe '#current_cart' do
    context 'when session[:cart_id] is set' do
      before { session[:cart_id] = cart.id }
      it 'returns the existing cart' do
        expect(controller.send(:current_cart)).to eq(cart)
      end
    end

    context 'when session[:cart_id] is not set' do
      before { session[:cart_id] = nil }

      it 'creates a new cart and sets session[:cart_id]' do
        expect { controller.send(:current_cart)}.to change { Cart.count }.by(1)
        expect(session[:cart_id]).not_to be_nil
      end

      it 'returns the newly created cart' do
        expect(controller.send(:current_cart)).to be_a(Cart)
      end
    end
  end
end
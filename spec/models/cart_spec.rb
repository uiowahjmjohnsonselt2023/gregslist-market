require './spec/rails_helper'

RSpec.describe Cart, type: :model do
  # let(:cart) { Cart.new }
  # let(:item) { Item.create(
  #   name: 'Nike shoes',
  #   description: 'The limited version',
  #   seller_id: '2',
  #   listing_date: '2023-12-01',
  #   listed_price: '17'
  # ) }
  #
  # describe '#add_item' do
  #   it 'adds an item to the cart if it is not already present' do
  #     puts('id=',item.id)
  #     puts('name=',item.name)
  #     cart.save
  #     cart.add_item(item)
  #     expect(cart.items).to include(item)
  #   end
  #
  #   it 'does not add an item if it is already in the cart' do
  #     item = create(:item)
  #     cart.add_item(item)
  #     cart.add_item(item)
  #     expect(cart.items.count).to eq(1)
  #   end
  # end
  #
  # describe '#remove_item' do
  #   it 'removes an item from the cart' do
  #     item = create(:item)
  #     cart.add_item(item)
  #     cart.remove_item(item)
  #     expect(cart.items).to be_empty
  #   end
  #
  #   it 'does nothing if the item is not in the cart' do
  #     item = create(:item)
  #     cart.remove_item(item)
  #     expect(cart.items).to be_empty
  #   end
  # end
  #
  # describe '#total_price' do
  #   it 'calculates the total price of items in the cart' do
  #     item1 = create(:item, listed_price: 10)
  #     item2 = create(:item, listed_price: 20)
  #     cart.add_item(item1)
  #     cart.add_item(item2)
  #     expect(cart.total_price).to eq(30)
  #   end
  #
  #   it 'returns 0 if the cart is empty' do
  #     expect(cart.total_price).to eq(0)
  #   end
  # end
end

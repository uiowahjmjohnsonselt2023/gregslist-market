require './spec/rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.create(
    name: 'Nike shoes',
    description: 'The limited version',
    seller_id: '2',
    listing_date: '2023-12-01',
    listed_price: '17'
  )}
  let(:category1) { Category.create(
    name: 'shoes'
  )}
  let(:category2) { Category.create(
    name: 'music'
  )}
  describe 'associations' do
    it { should belong_to(:seller) }
    it { should have_many(:item_categories) }
    it { should have_many(:categories).through(:item_categories) }
  end
  describe 'category_names' do
    it 'returns category names' do
      item.categories << [category1, category2]
      expect(item.category_names).to match_array(['shoes', 'music'])
    end
  end

end


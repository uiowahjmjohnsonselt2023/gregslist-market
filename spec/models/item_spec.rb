require './spec/rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.create(
    name: 'Nike shoes',
    description: 'The limited version',
    seller_id: '1',
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
    it { should belong_to(:category) }
    it { should have_one_attached(:image) }
  end


  describe '#owned_by?' do
    let(:user) { User.create(
      name: 'Mike',
      username: 'mike_doe',
      password: 'passwordisSerect',
      email: 'mike@gmail.com'
    ) }
    let(:other_user) { User.create(
      name: 'Jane Doe',
      username: 'jane_doe',
      password: 'SSerecttest',
      email: 'jjane@gmail.com'
    ) }
    let(:seller) { Seller.create(
      name: "Mike's store",
      description: "Mike's store sells all you need",
      address: '123 King St, IA'
    ) }

    it 'returns true if the user owns the seller' do
      seller.users << user
      expect(item.owned_by?(user)).to be_truthy
    end

    it 'returns false if the user does not own the seller' do
      seller
      expect(item.owned_by?(other_user)).to be_falsey
    end
  end

end


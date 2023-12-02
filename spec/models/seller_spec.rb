require './spec/rails_helper'

RSpec.describe Seller, type: :model do
  let(:seller) { Seller.create(
    name: "Mike's store",
    description: "Mike's store sells all you need",
    address: '123 King St, IA'
  ) }
  describe 'associations' do
    it { should have_many(:items) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
  end


end
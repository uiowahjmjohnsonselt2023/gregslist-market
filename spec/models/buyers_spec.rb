require './spec/rails_helper'

RSpec.describe Buyer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(255) }

    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_most(255) }

    it { should validate_presence_of(:address) }
    it { should validate_length_of(:address).is_at_most(255) }

    it { should validate_presence_of(:payment_method) }
    it { should validate_length_of(:payment_method).is_at_most(16) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

end

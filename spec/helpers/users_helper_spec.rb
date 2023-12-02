require './spec/rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#gravatar_for' do
    it 'generates the correct gravatar URL' do
      user = double('User', email: 'user@example.com', name: 'John Doe')
      expected_gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      expected_gravatar_url = "https://secure.gravatar.com/avatar/#{expected_gravatar_id}"

      result = helper.gravatar_for(user)

      expect(result).to include(expected_gravatar_url)
      expect(result).to include("alt=\"#{user.name}\"")
      expect(result).to include('class="gravatar"')
    end
  end
end

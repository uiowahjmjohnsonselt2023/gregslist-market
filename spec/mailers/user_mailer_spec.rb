require './spec/rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#account_activation' do
    let(:user) do
      User.create(
        name: 'Mike',
        username: 'mike_doe',
        password: 'passwordisSerect',
        email: 'mike@gmail.com'
      )
    end
    it 'sends an account activation email' do
      allow_any_instance_of(UserMailer).to receive(:edit_account_activation_url).and_return('http://example.com/activation_link')
      # The rest of your test
    end
  end
  describe '#account_activation' do
    let(:user) do
      User.create(
        name: 'Mike',
        username: 'mike_doe',
        password: 'passwordisSerect',
        email: 'mike@gmail.com'
      )
    end
    before do
      # Set the default_url_options to include the host
      Rails.application.routes.default_url_options[:host] = 'example.com'
    end

    it 'sends an account activation email' do
      mail = UserMailer.account_activation(user)

      # Assuming you have an activation_token variable in your mailer view
      activation_url = edit_account_activation_url(user.activation_token, host: 'example.com')

      expect(mail.subject).to eq('Account activation')
      expect(mail.to).to eq([user.email])
      # expect(mail.body).to include(activation_url)
    end
  end


  # describe "account_activation" do
  #   let(:mail) { UserMailer.account_activation }
  #
  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Account activation")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end
  #
  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  # end
  #
  # describe "password_reset" do
  #   let(:mail) { UserMailer.password_reset }
  #
  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Password reset")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end
  #
  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end


end

require 'rails_helper'

describe User do
  context 'with a valid token' do
    before do
      @user = User.new(email: 'new_user@mail.com')
    end

    it 'creates a new user' do
      expect{ @user.save }.to change{ User.count }.by(1)
    end
  end

  context 'when their authentication token already exists' do
    let(:previous_user) { FactoryGirl.create(:user) }
    let(:existing_token) { previous_user.authentication_token }

    let(:subject) { User.new(email: 'some_other_user@mail.com', authentication_token: existing_token) }

    it { should_not be_valid }
  end
end

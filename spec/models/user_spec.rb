require 'rails_helper'
require 'pry'

describe User do
  context 'when their authentication token already exists' do
    let(:previous_user) { FactoryGirl.create(:user) }
    let(:existing_token) { previous_user.authentication_token }

    let(:subject) { User.new(email: 'some_other_user@mail.com', authentication_token: existing_token) }

    it { should_not be_valid }
  end
end

require 'rails_helper'
require 'pry'

describe Api::V1::StatusMessagesController do
  describe 'POST #create' do
    context 'when it\'s the first status and status is empty' do
      let(:status) { FactoryGirl.attributes_for(:status_message_without_status) }

      it 'does not save the new status' do
        expect {
          post :create, status_message: status
        }.not_to change{ StatusMessage.count }
      end
    end

    context 'when it\'s the first status and status is not empty' do
      let(:status) { FactoryGirl.attributes_for(:status_message) }

      it 'creates a new status' do
        expect {
          post :create, status_message: status
        }.to change{ StatusMessage.count }.by(1)
      end
    end

    context 'when it\'s not the first status and attributes are valid' do
      let!(:stored_status) { FactoryGirl.create(:status_message) }
      let(:status) { FactoryGirl.attributes_for(:status_message) }

      it 'creates a new status' do
        expect {
          post :create, status_message: status
        }.to change{ StatusMessage.count }.by(1)
      end
    end

    context 'when it\'s not the first status and attributes are malformed' do
      let!(:stored_status) { FactoryGirl.create(:status_message) }
      let(:status) { FactoryGirl.create(:status_message) }

      it 'does not save the new status' do
        expect {
          post :create, invalid_object: status
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context 'with empty message' do
      let(:status) { FactoryGirl.attributes_for(:status_message_without_message) }

      it 'creates a new status' do
        expect {
          post :create, status_message: status
        }.to change{ StatusMessage.count }.by(1)
      end
    end
  end
end

require 'rails_helper'

describe Api::V1::StatusMessagesController do
  describe 'GET #current' do
    context 'service has a status' do
      before do
        @status_message = FactoryGirl.create(:status_message)
        get :current
      end

      it 'returns the service current status' do
        status_response = JSON.parse(response.body, symbolize_names: true)
        expect(status_response[:message]).to eql(@status_message.message)
      end
    end

    context 'service has no status' do
      before do
        get :current
      end

      it 'returns a No Content status' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'POST #create' do

    context 'with an invalid token' do
      before do
        @user = FactoryGirl.create(:user)
        request.env['HTTP_AUTHORIZATION'] = "Token token=XYZ"
      end

      context 'it\'s the first status and it\'s not empty' do
        let(:status) { FactoryGirl.attributes_for(:status_message) }

        it 'does not sav the new status' do
          expect {
            post :create, status_message: status
          }.not_to change{ StatusMessage.count }
        end
      end
    end

    context 'a valid token is present' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @api_key = @user.authentication_token
        request.env['HTTP_AUTHORIZATION'] = "Token token=#{ @api_key }"
      end

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
        let(:params) { { invalid_object: { status: 'UP' } } }

        it 'does not save the new status' do
          expect {
            post :create, params
          }.not_to change{ StatusMessage.count }
        end
      end

      context 'with empty message' do
        let(:params) { { status_message: { status: 'UP' } } }

        it 'creates a new status' do
          expect {
            post :create, params
          }.to change{ StatusMessage.count }.by(1)
        end
      end

      context 'with invalid status' do
        let(:unknown_status) { FactoryGirl.attributes_for(:status_not_allowed) }

        it 'does not save the new status' do
          expect {
            post :create, status_message: :unknown_status
          }.not_to change{ StatusMessage.count }
        end
      end
    end
  end
end

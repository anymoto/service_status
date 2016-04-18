require 'rails_helper'

describe Api::V1::HomeController do
   describe 'GET Index' do
    specify do
      get :index
      expect(response).to be_success
    end
  end
end

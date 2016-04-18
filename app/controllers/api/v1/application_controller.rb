class Api::V1::ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { exception.param => 'is required' }, status: :unprocessable_entity
  end
end

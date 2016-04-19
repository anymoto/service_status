class Api::V1::ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { exception.param => 'is required' }, status: :unprocessable_entity
  end

  rescue_from StandardError do |exception|
    render json: { message: 'Internal Server Error' }, status: :internal_server_error
  end
end

class Api::V1::ApplicationController < ActionController::Base
  rescue_from StandardError do
    render json: { message: 'Internal Server Error' }, status: :internal_server_error
  end

  rescue_from Apipie::ParamInvalid do
    render json: { error: 'Not a valid status' }, status: :unprocessable_entity
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { exception.param => 'is required' }, status: :unprocessable_entity
  end
end

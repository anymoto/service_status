class Api::V1::ApplicationController < ActionController::Base
  rescue_from StandardError do |exception|
    render json: { message: 'Internal Server Error' }, status: :internal_server_error
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { exception.param => 'is required' }, status: :unprocessable_entity
  end

  rescue_from ArgumentError do |exception|
    render json: { error: 'Not a valid status' }, status: :unprocessable_entity
  end
end

class Api::V1::StatusMessagesController < Api::V1::ApplicationController
  before_action :authenticate, only: [:create]

  ##############################################################
  api :POST, '/v1/status_messages', 'Create a status'
  description 'Create status with specifed status params'

  param :status_message, Hash, desc: 'Status information', required: true do
    param :status, ['UP', 'DOWN'],
      desc: 'Service status. First status sent to the endpoint shouldn\'t be empty. Otherwise, an Unprocessable Entry exception will be thrown.'
    param :message, String, desc: 'Status message. It can be empty anytime.'
  end

  example "{'status_message': {'status': 'UP', 'message': 'Everything is ok'}}"
  example "{'status_message': {'status': 'DOWN', 'message': 'Something is wrong'}}"
  example "{'status_message': {'status': 'DOWN', 'message': ''}}"
  example "{'status_message': {'status': '', 'message': 'No changes'}}"

  error code: 422, desc: 'Unprocessable Entity: it happens when params are malformed or status is not a valid.'
  error code: 500, desc: 'Internal Server Error: something is wrong on the server side.'
  ##############################################################

  def create
    status_message = StatusMessage.new(status_params)
    if status_message.save
      render json: status_message, status: :created
    else
      render json: status_message.errors, status: :unprocessable_entity
    end
  end

  ##############################################################
  api :GET, '/v1/status_message/current', 'Get the service current status'
  description 'Get the service current status'
  error code: 500, desc: 'Internal Server Error: something is wrong on the server side.'
  ##############################################################

  def current
    status = StatusMessage.current
    if status.present?
      render json: status, status: :ok
    else
      render json: 'not found', status: :not_found
    end
  end

  private

  def status_params
    params.require(:status_message).permit(:status, :message)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(authentication_token: token)
    end
  end
end

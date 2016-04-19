class Api::V1::StatusMessagesController < Api::V1::ApplicationController
  api :POST, '/v1/status_messages', 'Create a status'
  description 'Create status with specifed status params'
  param :status_message, Hash, desc: 'Status information', required: true do
    param :status, ['UP', 'DOWN'], desc: 'Service status'
    param :message, String, desc: 'Status message'
  end
  error code: 422, desc: 'Unprocessable Entity: it happens when params are malformed or status is not a valid.'
  error code: 500, desc: 'Internal Server Error: something is wrong on the server side.'

  def create
    status_message = StatusMessage.new(status_params)
    if status_message.save
      render json: status_message, status: :created
    else
      render json: status_message.errors, status: :unprocessable_entity
    end
  end

  private

  def status_params
    params.require(:status_message).permit(:status, :message)
  end
end

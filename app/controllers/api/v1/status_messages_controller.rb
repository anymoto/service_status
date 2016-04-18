class Api::V1::StatusMessagesController < Api::V1::ApplicationController
  def create
    status_message = StatusMessage.new(status_params)
    if status_message.save
      render json: 'Success!', status: :ok
    else
      render json: status_message.errors, status: :internal_server_error
    end
  end

  private

  def status_params
    params.require(:status_message).permit(:status, :message)
  end
end

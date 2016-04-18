class Api::V1::StatusMessagesController < ApplicationController
  def create
    status_message = StatusMessage.new(status_params)
    if status_message.save
      render json: status_message, status: :ok
    else
      render text: status_message.errors.full_messages, status: :bad_request
    end
  end

  private

  def status_params
    params.require(:status_message).permit(:status, :message)
  end
end

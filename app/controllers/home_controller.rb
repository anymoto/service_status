class HomeController < ApplicationController
  def index
    @status_messages = StatusMessage.latest
  end
end

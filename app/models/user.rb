class User < ActiveRecord::Base
  before_create :set_auth_token

  private

  def set_auth_token
    return if self.authentication_token.present?
    self.authentication_token = new_token
  end

  def new_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end

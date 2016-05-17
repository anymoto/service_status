class User < ActiveRecord::Base
  before_save :set_auth_token
  validates_uniqueness_of :authentication_token

  private

  def set_auth_token
    return if read_attribute(:authentication_token).present?
    write_attribute(:authentication_token, new_token)
  end

  def new_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end

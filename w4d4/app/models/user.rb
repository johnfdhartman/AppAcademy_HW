require 'bcrypt'
class User < ApplicationRecord
  validates :username, :session_token, presence: true

  def find_by_credentials(username, password)
    User.where(username: username)
    .where(BCrypt::Password.new(password == password_digest))
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end


  def reset_session_token!
    @session_token = User.generate_session_token
    self.save!
    @session_token
  end

  def ensure_session_token
    @session_token ||= User.generate_session_token
  end

end

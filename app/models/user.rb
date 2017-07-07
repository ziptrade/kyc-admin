class User < ApplicationRecord
  include Clearance::User

  validates :email, :encrypted_password, :auth_token, presence: true
  validates :email, :auth_token, uniqueness: true

  before_create :set_auth_token

  def reset_auth_token!
    self.auth_token = nil
    set_auth_token
    save!
  end

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.delete('-')
  end
end

# frozen_string_literal: true
require 'bcrypt'
class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, length: { in: 2..50 }, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def auth_with_password_digest(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end

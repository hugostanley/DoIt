# frozen_string_literal: true
require 'bcrypt'
# user class
class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :username, presence: true, length: { in: 2..50 }, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def auth_with_password_digest(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def all_friends
    self.friends 
  end
end

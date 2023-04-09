# frozen_string_literal: true
class User < ApplicationRecord
  validates :username, presence: true, length: { in: 2..50 }, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
end

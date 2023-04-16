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

  def self.get_friends_by_status(id, status)
    friendship_by_status = Friendship.where(user_id: id, status: status)
    friendship_by_status.map { |f| User.find(f.friend_id) }
  end

  def self.get_non_friend_users(current_user)
    User.where.not(id: current_user.id).reject { |user| current_user.friends.include?(user) }
  end

  def self.get_all_users_non_friend_and_rejected_friendship_users(id)
    current_user = User.find(id)
    non_friend_users = User.get_non_friend_users current_user
    rejected_friends = User.get_friends_by_status(id, 'rejected')
    non_friend_users + rejected_friends
  end

end

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, :friend_id , presence: true, numericality: { only_integer: true }
  validates :status, inclusion: { in: %w(accepted rejected pending), message: "%{value} is not a valid status" }

  def friend_id_should_not_be_equal_to_current_user_id
    if friend_id == session[:user_id]
      errors.add(:friend_id, "cannot be yourself")
    end
  end
end

class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 2..20 }
  validates :description, allow_blank: true, length: { maximum: 200 }
  validates :deadline, allow_blank: true, inclusion: { in: (Time.zone.now..Float::INFINITY), message: 'Deadline must be in the future' }
end

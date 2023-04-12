class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 2..20 }
  validates :description, allow_blank: true, length: { maximum: 200 }
  validates :deadline, allow_blank: true, inclusion: { in: (Time.zone.now..Float::INFINITY), message: 'Deadline must be in the future' }, on: :create
  validates :is_completed, inclusion: { in: [true, false] }, allow_blank: true
  validate :date_completed_cannot_be_future

  private 

  def date_completed_cannot_be_future
    if date_completed.present? && date_completed > Time.now
      errors.add(:date_completed, 'completion date cannot be in the future')
    end
  end
end

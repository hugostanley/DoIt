class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 2..20 }
  validates :description, allow_blank: true, length: { maximum: 200 }
  validates :deadline, inclusion: {
    in: (Date.today..Float::INFINITY), message: "Deadline must be today or in the future" }, allow_blank: true, on: :create
  validates :is_completed, inclusion: { in: [true, false] }, allow_blank: true
  validate :date_completed_cannot_be_future

  def self.sort_tasks_by_latest_update(id)
    Task.where(user_id: id).sort_by { |task| task.updated_at }.reverse
  end

  private 

  def date_completed_cannot_be_future
    if date_completed.present? && date_completed > Time.now
      errors.add(:date_completed, 'completion date cannot be in the future')
    end
  end

end

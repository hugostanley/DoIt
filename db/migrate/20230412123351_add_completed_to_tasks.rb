class AddCompletedToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :is_completed, :boolean
    add_column :tasks, :date_completed, :datetime
  end
end

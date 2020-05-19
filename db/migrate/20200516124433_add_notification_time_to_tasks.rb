class AddNotificationTimeToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :notification_time, :time
  end
end

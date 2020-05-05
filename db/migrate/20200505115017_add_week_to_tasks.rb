class AddWeekToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :week, :string
  end
end

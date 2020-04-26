class AddIsDoneToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :is_done, from: true, to: false
  end
end

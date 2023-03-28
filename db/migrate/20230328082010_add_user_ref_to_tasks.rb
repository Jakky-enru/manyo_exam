class AddUserRefToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :user, null: false, default: 1, foreign_key: true
  end
end

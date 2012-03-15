class ChangeTableWorkLogs < ActiveRecord::Migration
  def change
    rename_column :work_logs, :int, :logged_on
    change_column :work_logs, :logged_on, :datetime
    remove_column :work_logs, :inode
  end
end

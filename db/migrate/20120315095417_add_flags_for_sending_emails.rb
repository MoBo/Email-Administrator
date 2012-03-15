class AddFlagsForSendingEmails < ActiveRecord::Migration
  def change
    rename_column :emails, :receive, :can_receive
    add_column :emails, :can_send, :boolean, :default => true
  end
end

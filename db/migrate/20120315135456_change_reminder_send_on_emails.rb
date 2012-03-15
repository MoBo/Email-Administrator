class ChangeReminderSendOnEmails < ActiveRecord::Migration
  def change
    rename_column :emails, :reminder_send, :reminder_sent
  end
end

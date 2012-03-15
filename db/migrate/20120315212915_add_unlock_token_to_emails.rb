class AddUnlockTokenToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :unlock_token, :string
    add_column :emails, :locked_at, :datetime
    add_index :emails, :unlock_token, :unique => true
  end
end

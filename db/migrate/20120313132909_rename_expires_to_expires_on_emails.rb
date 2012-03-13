class RenameExpiresToExpiresOnEmails < ActiveRecord::Migration
  def up
    rename_column :emails, :expires, :expires_on
  end

  def down
    rename_column :emails, :expires_on, :expires
  end
end

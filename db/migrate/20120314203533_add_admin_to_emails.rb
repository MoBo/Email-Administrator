class AddAdminToEmails < ActiveRecord::Migration
  def change
    drop_table :admins
    add_column :emails, :admin, :boolean, :default => false
  end
end

class RemovingEmailPath < ActiveRecord::Migration
  def up
    drop_table :email_paths
    rename_column :emails, :email_path_id, :email_path
    change_column :emails, :email_path, :string
  end

  def down
     create_table "email_paths", :force => true do |t|
        t.string   "path_type",  :default => "default"
        t.string   "path",       :default => "var/logs"
        t.datetime "created_at",                         :null => false
        t.datetime "updated_at",                         :null => false
      end
     rename_column :emails, :email_path, :email_path_id
     change_column :emails, :email_path, :integer
  end
end

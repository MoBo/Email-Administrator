class AddEmailPathStringToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :email_path_string, :string
  end
end

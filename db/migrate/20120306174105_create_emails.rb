class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.string :encrypted_password, :null => false, :default => ""
      t.text :comment
      t.date :expires
      t.integer :email_path_id
      t.integer :domain_id
      t.string :forward_email
      t.boolean :receive
      t.string :alt_email
      t.boolean :reminder_send, :default => false
      t.boolean :active , :default => true

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps
    end
    
    add_index :emails, :email,                :unique => true
    add_index :emails, :reset_password_token, :unique => true
    add_index :emails, :expires, :unique => true
  end
end

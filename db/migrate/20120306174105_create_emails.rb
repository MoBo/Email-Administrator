class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.string :password
      t.text :comment
      t.date :expires
      t.string :path
      t.string :forward_email
      t.boolean :receive
      t.string :alt_email

      t.timestamps
    end
  end
end

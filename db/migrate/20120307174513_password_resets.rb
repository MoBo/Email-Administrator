class PasswordResets < ActiveRecord::Migration
 def change
    create_table :password_resets do |t|
      t.string :reset_token
      
      t.timestamps
    end
  end
end

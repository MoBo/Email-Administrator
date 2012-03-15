class AddIndexes < ActiveRecord::Migration
  def change
    add_index :emails, :active
    add_index :emails, :admin
    add_index :emails, :can_send
    add_index :emails, :can_receive
    add_index :emails, :reminder_sent
    add_index :domains, :name
    
  end
end

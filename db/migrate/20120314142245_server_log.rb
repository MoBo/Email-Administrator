class ServerLog < ActiveRecord::Migration
  def change
    create_table :incoming_logs do |t|
        t.string :server
        t.string :queue_id 
        t.string :message_id 
        t.datetime :arrive_time
        t.string :hostname 
        t.string :ipaddr
        t.integer :uid
        t.string :user
        t.string :sender
        t.string :sdomain
        t.integer :size 
        t.boolean :old
    end  
    
    add_index :incoming_logs, :queue_id
    add_index :incoming_logs, :sender
    add_index :incoming_logs, :sdomain
    
    create_table :outgoing_logs do |t|
        t.datetime :action_time
        t.string :recipient
        t.string :rdomain 
        t.string :status 
        t.string :relay 
        t.integer :delay
        t.text :info
    end
    
    add_index :outgoing_logs, :recipient
    add_index :outgoing_logs, :rdomain
    add_index :outgoing_logs, :action_time
    
    create_table :work_logs do |t|
        t.string :filename
        t.integer :inode
        t.integer :int
    end  
  end
end

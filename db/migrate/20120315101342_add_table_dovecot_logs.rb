class AddTableDovecotLogs < ActiveRecord::Migration
  def change
    create_table :dovecot_logs do |t|
        t.datetime  :logged_on
        t.string    :email
        t.string    :method
    end 
  end
end

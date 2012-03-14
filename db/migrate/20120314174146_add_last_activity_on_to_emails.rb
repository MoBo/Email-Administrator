class AddLastActivityOnToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :last_activity_on, :datetime, :default => Date.today
  end
end

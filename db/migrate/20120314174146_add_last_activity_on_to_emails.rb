class AddLastActivityOnToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :last_activity_on, :datetime
  end
end

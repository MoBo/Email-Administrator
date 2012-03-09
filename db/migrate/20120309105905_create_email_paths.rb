class CreateEmailPaths < ActiveRecord::Migration
  def change
    create_table :email_paths do |t|
      t.string :path_type, :default => 'default'
      t.string :path, :default => 'var/logs'
      t.timestamps
    end
  end
end

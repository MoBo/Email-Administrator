class CreateEmailPaths < ActiveRecord::Migration
  def change
    create_table :email_paths do |t|
      t.string :type
      t.string :path

      t.timestamps
    end
  end
end

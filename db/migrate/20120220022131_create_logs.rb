class CreateLogs < ActiveRecord::Migration
  def change
    create_table :application_logs do |t|

      t.timestamps
      t.string  :message
      t.integer :user_id
      t.integer :level
    end
  end
end

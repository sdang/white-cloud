class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :mrn
      t.string :reminder
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :remind_time
      t.integer :reminder_list_id
      t.integer :user_id
      t.boolean :completed

      t.timestamps
    end
  end
end

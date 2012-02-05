class CreateReminderLists < ActiveRecord::Migration
  def change
    create_table :reminder_lists do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end

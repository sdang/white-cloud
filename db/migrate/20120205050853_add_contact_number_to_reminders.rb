class AddContactNumberToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :contact_number, :string
  end
end

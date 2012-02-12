class FixReminderTable < ActiveRecord::Migration
  def up
    
    # update reminders table
    add_column :reminders, :last_notification, :datetime
    change_column :reminders, :completed, :boolean, :default => false
    
    Reminder.find_all_by_completed(nil).each do |r|
      r.completed = false
      r.save
    end
    
    Reminder.find(:all).each do |r|
      r.last_notification = Time.now - 1.year
    end
    
    # users need a way to be notified
    add_column :users, :sms_number, :string
    add_column :users, :preferences, :string
    
  end

  def down
    remove_column :reminders, :last_notification
    remove_column :users, :sms_number
    remove_column :users, :preferences
    
  end
end

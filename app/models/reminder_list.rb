class ReminderList < ActiveRecord::Base
  has_many :reminders
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name
  
  def overdue_reminders
    ReminderList.reminders.where(:remind_time < Time.now, :order => ["remind_time DESC"])
  end
  
  def open_reminders
    ReminderList.reminders.where(["completed = ?", false], :order => ["remind_time DESC"])
  end
  
end

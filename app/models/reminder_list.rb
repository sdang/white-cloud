class ReminderList < ActiveRecord::Base
  has_many :reminders
  belongs_to :user
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name
  
  def overdue_reminders
    self.reminders.find(:all, :conditions => ["remind_time < ? and completed = ?", Time.now, false], :order => "remind_time DESC")
  end
  
  def open_reminders
    self.reminders.find(:all, :conditions => ["completed = ?", false], :order => "remind_time DESC")
  end
  
  def critical_overdue_reminders
    self.reminders.find(:all, :conditions => ["remind_time < ? and completed = ?", Time.now-3.days, false], :order => "remind_time DESC")
  end  
  
  # handle sending the reminders to all the supervisors
  def self.send_supervisor_reminders
    ReminderList.find(:all).each do |rl|
      NotificationMailer.send_supervisor_reminders(rl).deliver if rl.critical_overdue_reminders.size > 0
    end
  end
  
end

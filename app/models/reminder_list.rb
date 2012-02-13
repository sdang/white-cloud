class ReminderList < ActiveRecord::Base
  has_many :reminders
  
  validates_uniqueness_of :name
end

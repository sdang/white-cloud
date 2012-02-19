class ReminderList < ActiveRecord::Base
  has_many :reminders
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name
end

class Reminder < ActiveRecord::Base
  attr_accessor :time_value, :time_units
  before_save :convert_relative_to_absolute_time
  
  def convert_relative_to_absolute_time
    self.remind_time = Time.now + (self.time_value.to_i*self.time_units.to_i).hour
  end
  
end

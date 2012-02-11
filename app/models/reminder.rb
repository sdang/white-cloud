class Reminder < ActiveRecord::Base
  attr_accessor :time_value, :time_units
  before_save :convert_relative_to_absolute_time
  
  def convert_relative_to_absolute_time
    self.remind_time = Time.now + (self.time_value.to_i*self.time_units.to_i).hour
  end
  
  def self.create_from_string(str, user_id)
    # define the pattern matching
    mrn_match = /[0-9]{7}/
    time_match = /in (?<time_val>[0-9]{1,}) (?<time_unit>hours?|days?|weeks?)/i
    
    # extract meaningful info from message
    mrn = str.match(mrn_match).to_s rescue ""
    md = str.match(time_match) rescue nil
    time_val = md[:time_val].to_i rescue 0
    time_unit = md[:time_unit] rescue ""
    
    # perform error checking
    if mrn == "" or time_val == 0 or time_unit == ""
      return false
    end
    
    time_unit_multiplier = 0
    if /days?/i.match(time_unit)
      time_unit_multiplier = 24
    elsif /hours?/i.match(time_unit)
      time_unit_multiplier = 1
    elsif /weeks?/i.match(time_unit)
      time_unit_multiplier = 24*7
    else
      return false
    end
    
    # strip out matched patterns from message
    msg = str.gsub(mrn_match, '')
    msg = msg.gsub(time_match, '')
    
    # create the reminder
    reminder = Reminder.new(:mrn => mrn, :reminder => msg, :user_id => 1, :time_value => time_val, :time_units => time_unit_multiplier, :user_id => 1)
  
    # return error if we can't save the reminder
    if reminder.save
      return reminder
    else
      return false
    end
    
  end
  
  
end

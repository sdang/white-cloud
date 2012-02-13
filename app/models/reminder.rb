class Reminder < ActiveRecord::Base
  belongs_to :user
  belongs_to :reminder_list
  before_create :set_last_notification

  attr_accessor :time_value, :time_units
  before_validation :convert_relative_to_absolute_time
  
  validates_presence_of :reminder, :mrn, :remind_time, :user_id
  validates_numericality_of :mrn
  
  def convert_relative_to_absolute_time
    # don't do anything if a remind time has already been set
    return true if self.remind_time
    
    # make sure we have valid remind time data
    if self.time_value.to_i > 0 and self.time_units.to_i > 0
      self.remind_time = Time.now + (self.time_value.to_i*self.time_units.to_i).hour
    else
      self.remind_time = nil
    end
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
    reminder = Reminder.new(:mrn => mrn, :reminder => msg, :user_id => 1, :time_value => time_val, :time_units => time_unit_multiplier, :user_id => user_id)
  
    # return error if we can't save the reminder
    if reminder.save
      return reminder
    else
      return false
    end
    
  end
  
  def send_reminder
    puts "id: #{self.id} #{self.remind_time} #{ENV['DEFAULT_FROM_EMAIL']}"
    
    # TODO: Send Page
    
    if self.user.remind_by_sms
      @twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN']
      @twilio_client.account.sms.messages.create(
        :from => "+1#{ENV['TWILIO_PHONE_NUMBER']}",
        :to => self.user.sms_number,
        :body => "Reminder: #{self.reminder}, pt: #{self.mrn} sent by #{ENV['APPLICATION_NAME']}"
      )
    end
    
    # send the email reminder
    NotificationMailer.send_notification_for_reminder(self).deliver if self.user.remind_by_email
    self.update_attribute(:last_notification, Time.now)
  end
  
  def self.send_reminders
    puts "Sending reminders..."
    # find all reminders, not completed, who are due for a reminder, and who haven't been notified in 24 hours
    reminders = Reminder.where("completed = ? AND remind_time < ? AND last_notification < ?", false, Time.now, Time.now-24.hours)
    
    reminders.each do |r|
      if r.user
        r.send_reminder 
      else
        logger.info "Unable to send email reminder for #{r.id}"
      end
    end
    
  end
  
  private
  def set_last_notification
    self.last_notification = Time.now - 1.year
  end
  
end

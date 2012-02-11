class SmsController < ApplicationController
  
  def index
    error = false
    message_body = params["Body"] || ""
    from_number = params["From"] || ""
    
    # define the pattern matching
    mrn_match = /[0-9]{7}/
    time_match = /in (?<time_val>[0-9]{1,}) (?<time_unit>hours?|days?|weeks?)/i
    
    # extract meaningful info from message
    mrn = message_body.match(mrn_match).to_s rescue ""
    md = message_body.match(time_match) rescue nil
    time_val = md[:time_val].to_i rescue 0
    time_unit = md[:time_unit] rescue ""
    
    # perform error checking
    if mrn == "" or time_val == 0 or time_unit == ""
      error = true
    end
    
    if /days?/i.match(time_unit)
      time_unit_multiplier = 24
    elsif /hours?/i.match(time_unit)
      time_unit_multipler = 1
    elsif /weeks?/i.match(time_unit)
      time_unit_multipler = 24*7
    else
      error = true
    end
    
    # strip out matched patterns from message
    msg = message_body.gsub(mrn_match, '')
    msg = msg.gsub(time_match, '')
    
    # create the reminder
    unless error
      reminder = Reminder.new(:mrn => mrn, :reminder => msg, :user_id => 1, :time_value => time_val, :time_units => time_unit_multipler)
  
      # return error if we can't save the reminder
      error = true unless reminder.save
    end
    
    # define the txt message to send
    if error
      txt = "I couldn't understand your message. Please include a 7 digit MRN and tell me when to remind you (eg: in 5 days)"
    elsif
      txt = "Got it, thanks! I'll remind you to check pt #{mrn} on #{reminder.remind_time.strftime('%m-%d-%Y')}"
    end
    
    # send the txt message using twilio
    response = Twilio::TwiML::Response.new do |r|
      r.sms txt
    end

    render :xml => response.text
  end

end

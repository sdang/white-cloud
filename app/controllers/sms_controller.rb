class SmsController < ApplicationController
  
  def index
    message_body = params["Body"] || ""
    from_number = params["From"] || ""
    
    reminder = Reminder.create_from_string(message_body, 1)
    
    # define the txt message to send
    if reminder
      txt = "Got it! I'll remind you to check pt #{reminder.mrn}"
      if r.remind_time - Time.now < 24.hours
        txt += " at #{reminder.remind_time.strftime("%l:%M%P")}"
      else
        txt += " on #{reminder.remind_time.strftime('%m-%d-%Y')}"
      end
    elsif
      txt = "I couldn't understand your message. Please include a 7 digit MRN and tell me when to remind you (eg: in 5 days)"
    end
    
    # send the txt message using twilio
    response = Twilio::TwiML::Response.new do |r|
      r.sms txt
    end

    render :xml => response.text
  end

end

class NotificationMailer < ActionMailer::Base
  default :from => ENV['DEFAULT_FROM_EMAIL']
  def send_notification_for_reminder(reminder)
    @reminder = reminder
    mail(:to => reminder.user.email, :subject => "#{ENV['APPLICATION_NAME']} Reminder Due #{@reminder.remind_time.strftime('%m-%d-%Y @ %I:%M%P')}")
  end
  
end

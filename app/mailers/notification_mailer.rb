class NotificationMailer < ActionMailer::Base
  default :from => ENV['DEFAULT_FROM_EMAIL']
  layout "email"
    
  def send_notification_for_reminder(reminder)
    @reminder = reminder
    mail(:to => reminder.user.email, :subject => "[#{ENV['APPLICATION_NAME']}] Reminder Notification")
  end
  
end

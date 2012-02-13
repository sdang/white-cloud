class NotificationMailer < ActionMailer::Base
  default :from => ENV['DEFAULT_FROM_EMAIL']
  def send_notification_for_reminder(reminder)
    @reminder = reminder
    mail(:to => reminder.user.email, :subject => reminder.reminder)
  end
  
end

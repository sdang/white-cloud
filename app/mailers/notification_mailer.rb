class NotificationMailer < ActionMailer::Base
  default :from => ENV['DEFAULT_FROM_EMAIL']
  layout "email"
    
  def send_notification_for_reminder(reminder)
    @reminder = reminder
    mail(:to => reminder.user.email, :subject => "[#{ENV['APPLICATION_NAME']}] Reminder Notification")
  end
  
  def send_supervisor_reminders(reminder_list)
    @reminder_list = reminder_list
    @user = reminder_list.user
    @reminders = reminder_list.critical_overdue_reminders
    mail(:to => @user.email, :subject => "[#{ENV['APPLICATION_NAME']}] Overdue reminders for #{reminder_list.name}") 
  end
end

class AdminMailer < ActionMailer::Base
  default :from => ENV['DEFAULT_FROM_EMAIL']
  
  def send_new_user_notification(user_id)
    @user = User.find(user_id)
    mail(:to => ENV['ADMIN_NOTIFY_EMAIL'], :subject => "[#{ENV['APPLICATION_NAME']}] New User Registration")
  end
  
  
end

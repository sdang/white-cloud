class UserMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_EMAIL']
  layout "email"
  
  def sign_up_email(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to #{ENV['APPLICATION_NAME']}")
  end
  
  def authorized(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "[#{ENV['APPLICATION_NAME']}] access granted")
  end
  
end

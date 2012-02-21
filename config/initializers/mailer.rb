OliveViewTools::Application.configure do
  
  # set URL Path
  config.action_mailer.default_url_options = { :host => ENV['DEFAULT_HOST'] }
  config.action_mailer.delivery_method = :smtp
  
  if Rails.env == "production"
    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.smtp_settings = { 
      :address   => "smtp.sendgrid.net",
      :port      => 587,
      :domain    => ENV['SEND_GRID_DOMAIN'],
      :user_name => ENV['SEND_GRID_USER'],
      :password  => ENV['SEND_GRID_PW'],
      :authentication => 'plain',
      :enable_starttls_auto => true }
  else
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      :address              => "localhost",
      :port                 => 1025,
      :domain               => ENV['SEND_GRID_DOMAIN']
    }
  end
  
end

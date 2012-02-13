OliveViewTools::Application.configure do
  # set URL Path
  config.action_mailer.default_url_options = { :host => ENV['DEFAULT_HOST'] }
  
  # email configuration
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
    :address              => "localhost",
    :port                 => 1025,
    :domain               => ENV['SEND_GRID_DOMAIN']
  }
  
end

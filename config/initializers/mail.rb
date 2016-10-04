ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :user_name => APP_CONFIG['MANDRILL_USERNAME'],
    :password  => APP_CONFIG['MANDRILL_API_KEY'],
    :domain    => 'gas-e.com',
    :authentication => :plain
  }
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = APP_CONFIG['MANDRILL_API_KEY']
  config.deliver_later_queue_name = :default
end
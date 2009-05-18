require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.action_controller.session = {
    :session_key => '_morty_session',
    :secret      => '350e4f0acbbf3686adf3e18815d2b484eb93a7e63a287c159ed45ea92d0e2b7aada84589c7b0c49c3f9deca8712cee34e0065e1352abf8e95f95c057365a0850'
  }

end

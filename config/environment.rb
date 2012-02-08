# Load the rails application
require File.expand_path('../application', __FILE__)

APP_VERSION = `git describe --always` unless defined? APP_VERSION

# Initialize the rails application
OliveViewTools::Application.initialize!

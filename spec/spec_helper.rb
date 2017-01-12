# Added by ChefSpec
require 'chefspec'
require 'chefspec/berkshelf'
#
# Include all our libraries
Dir['libraries/*.rb'].each { |f| require File.expand_path(f) }

SPEC_ROOT = File.expand_path('../', __FILE__) unless defined?(SPEC_ROOT)

Dir[File.join(SPEC_ROOT, 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Specify the operating platform to mock Ohai data from
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from
  config.version = '14.04'
end

def http_fixture(*names)
  File.join(SPEC_ROOT, "fixtures.http", *names)
end

def read_http_fixture(*names)
  File.read(http_fixture(*names))
end

# Added by ChefSpec
require 'chefspec'
require 'chefspec/berkshelf'
require './libraries/matchers'

RSpec.configure do |config|
  # Specify the operating platform to mock Ohai data from
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from
  config.version = '14.04'
end

unless defined?(SPEC_ROOT)
  SPEC_ROOT = File.expand_path("../", __FILE__)
end

Dir[File.join(SPEC_ROOT, "support/**/*.rb")].each { |f| require f }

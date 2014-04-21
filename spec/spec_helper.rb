# Added by ChefSpec
require 'chefspec'

# Uncomment to use ChefSpec's Berkshelf extension
require 'chefspec/berkshelf'
require_relative 'support/shared_context'

RSpec.configure do |config|
  config.expect_with :rspec do |spec|
    spec.syntax = :expect
  end

  # Specify the operating platform to mock Ohai data from
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from
  config.version = '12.04'

  # Specify examples order
  config.order = :random
end

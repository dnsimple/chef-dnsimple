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

# Added by ChefSpec
require 'chefspec'
require 'chefspec/berkshelf'

# require files in spec/support/ directory
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Specify the operating platform to mock Ohai data from
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from
  config.version = '14.04'

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end
end

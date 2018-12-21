require 'rspec/core/rake_task'

namespace :unit do
  # Rspec and ChefSpec
  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:chefspec) do |t|
    t.rspec_opts = %w(
      --color
      --format progress
    ).join(' ')
  end
end

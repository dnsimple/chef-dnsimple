require 'foodcritic'
require 'kitchen'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'cookstyle'
require 'stove/rake_task'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options << '--display-cop-names'
  end

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
    t.options = {
      fail_tags: ['any']
    }
  end
end

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

# Integration tests. Kitchen.ci
desc 'Run Test Kitchen integration tests'
namespace :integration do
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
end

desc 'Travis and CI'
namespace :cloud do
  desc 'Run integration tests with kitchen-digitalocean via Travis-CI'
  task :travis do
    if ENV['TRAVIS'] == 'true'
      sh "kitchen test #{ENV['KITCHEN_ARGS']} #{ENV['KITCHEN_REGEXP']}"
    end
  end
end

# For releasing into the Supermarket. See RELEASE.md for details
Stove::RakeTask.new

task style: %w( style:rubocop style:foodcritic )
task unit: %w( unit:chefspec )
task kitchen: %w( integration:kitchen:all )

desc 'Run just the quick tests'
task quick: %w( style unit )

desc 'Run all tests on Travis'
task travis: %w( style unit cloud:travis )

desc 'All the tests, coffee time'
task all: %w( style unit kitchen )

# Default
task default: 'all'

task default: %w(test)
task test: %w(delivery kitchen)
task quick: :delivery

require 'cookstyle'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:cookstyle) do |task|
  task.options = ['--display-cop-names', '--extra-details']
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format progress']
end

desc 'Run linter and specs'
task :delivery do
  g = 'Policyfile.lock.json'
  File.delete(g) if File.exist?(g)

  Rake::Task['cookstyle'].invoke
  Rake::Task['spec'].invoke
end

desc 'Run test kitchen with optional KITCHEN_ARGS if that env is present. Defaults suite test to "all" if no KITCHEN_REGEXP env var is present'
task :kitchen do
  sh 'kitchen test ' << %W(#{ENV['KITCHEN_REGEXP'] || 'all'} #{ENV['KITCHEN_ARGS']}).reject(&:empty?).join(' ')
end

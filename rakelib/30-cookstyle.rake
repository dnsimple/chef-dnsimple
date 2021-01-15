require 'cookstyle'
require 'rubocop/rake_task'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options << '--display-cop-names'
  end

  desc 'Run Chef cookstyle checks'
  RuboCop::RakeTask.new(:cookstyle) do |task|
    task.options << '--display-cop-names'
  end
end

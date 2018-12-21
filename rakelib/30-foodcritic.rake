require 'cookstyle'
require 'foodcritic'
require 'rubocop/rake_task'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options << '--display-cop-names'
  end

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
    t.options = { fail_tags: ['any'] }
  end
end

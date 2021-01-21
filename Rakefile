task default: %w(test)
task test: %w(delivery kitchen)
task quick: :delivery

desc 'Run delivery local'
task :delivery do
  g = 'Policyfile.lock.json'
  File.delete(g) if File.exist?(g)
  sh 'delivery local all'
end

desc 'Run test kitchen with optional KITCHEN_ARGS if that env is present. Defaults suite test to "all" if no KITCHEN_REGEXP env var is present'
task :kitchen do
  sh 'kitchen test ' << %W(#{ENV['KITCHEN_REGEXP'] || 'all'} #{ENV['KITCHEN_ARGS']}).reject(&:empty?).join(' ')
end

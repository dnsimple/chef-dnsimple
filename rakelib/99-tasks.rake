task style: %w( style:rubocop style:cookstyle )
task unit: %w( unit:chefspec )
task kitchen: %w( integration:dokken )

desc 'Run just the quick tests'
task quick: %w( style unit )

desc 'Run all tests on Travis'
task travis: %w( style unit kitchen )

desc 'All the tests, coffee time'
task all: %w( style unit kitchen )

# Default
task default: 'all'

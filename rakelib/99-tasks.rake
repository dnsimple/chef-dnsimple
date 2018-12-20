task style: %w( style:rubocop style:foodcritic )
task unit: %w( unit:chefspec )
task kitchen: %w( integration:kitchen:all )

desc 'Run just the quick tests'
task quick: %w( style unit )

desc 'Run all tests on Travis'
task travis: %w( style unit integration:dokken )

desc 'All the tests, coffee time'
task all: %w( style unit kitchen )

# Default
task default: 'all'

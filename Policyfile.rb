# A name that describes what the system you're building with Chef does.
name 'dnsimple'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'test::default'
named_run_list :create_test_records, %w(test::default test::reset_test_environment test::create_record)
named_run_list :update_test_records, %w(test::default test::reset_test_environment test::update_record)

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'dnsimple', path: '.'
cookbook 'test', path: 'test/cookbooks/test'

# A name that describes what the system you're building with Chef does.
name 'dnsimple'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'dnsimple_test::default'
named_run_list :create_test_records, %w(dnsimple_test::default dnsimple_test::reset_test_environment dnsimple_test::create_record)
named_run_list :update_test_records, %w(dnsimple_test::default dnsimple_test::reset_test_environment dnsimple_test::update_record)

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'dnsimple', path: '.'
cookbook 'dnsimple_test', path: 'test/cookbooks/dnsimple_test'

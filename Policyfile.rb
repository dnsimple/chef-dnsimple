# A name that describes what the system you're building with Chef does.
name 'dnsimple'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'test::default'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'dnsimple', path: '.'
cookbook 'dnsimple_test', path: 'test/cookbooks/dnsimple_test'

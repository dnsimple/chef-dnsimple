name             'dnsimple'
maintainer       'Aetrion, LLC. dba DNSimple'
maintainer_email 'ops@dnsimple.com'
license          'Apache-2.0'
description      'Provides Chef Resource for automating DNS configuration with DNSimple'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url       'https://github.com/dnsimple/chef-dnsimple/issues'
source_url       'https://github.com/dnsimple/chef-dnsimple'
version          '2.1.1'

chef_version '>= 12.8'

gem 'dnsimple', '>= 4.0'

%w(amazon centos debian fedora freebsd redhat ubuntu).each do |os|
  supports os
end

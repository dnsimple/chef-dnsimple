name             'dnsimple'
maintainer       'DNSimple Corp'
maintainer_email 'ops@dnsimple.com'
license          'Apache-2.0'
description      'Provides Chef Resource for automating DNS configuration with DNSimple'
issues_url       'https://github.com/dnsimple/chef-dnsimple/issues'
source_url       'https://github.com/dnsimple/chef-dnsimple'
version          '3.3.0'

chef_version '>= 16'

gem 'dnsimple', '>= 6.0'

%w(amazon centos debian fedora freebsd redhat ubuntu).each do |os|
  supports os
end

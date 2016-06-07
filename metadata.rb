name             'dnsimple'
maintainer       'Aetrion, LLC.'
maintainer_email 'ops@dnsimple.com'
license          'Apache 2.0'
description      'Provides Chef LWRP for automating DNS configuration with DNSimple'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'
issues_url       'https://github.com/dnsimple/chef-dnsimple/issues'
source_url       'https://github.com/dnsimple/chef-dnsimple'

recipe   'dnsimple', 'Installs fog gem to use w/ the dnsimple_record'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'rhel'
supports 'ubuntu'

depends 'build-essential', '>= 2.0.0'

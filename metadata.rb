maintainer       "DNSimple"
maintainer_email "ops@dnsimple.com"
license          "Apache 2.0"
description      "Installs/Configures dnsimple"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5.1"

recipe   "dnsimple", "Installs dnsimple-ruby gem to use w/ the dnsimple_record"
supports "ubuntu"
supports "debian"

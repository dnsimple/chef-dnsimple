maintainer       "DNSimple"
maintainer_email "ops@dnsimple.com"
license          "Apache 2.0"
description      "Installs/Configures dnsimple"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.3.1"

recipe   "dnsimple", "Installs DNSimple gem"
supports "ubuntu"

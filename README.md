## Description

A Light-weight Resource and Provider (LWRP) supporting
automatic DNS configuration via DNSimple's API.

[![Build Status](https://travis-ci.org/dnsimple/chef-dnsimple.png?branch=master)](https://travis-ci.org/dnsimple/chef-dnsimple)

## Requirements

* A DNSimple account at https://dnsimple.com
* Chef 11 or newer (Feel free to send a pull request for Chef 10.x support)

## Known issues

* This cookbook currently cannot work with Chef 12.1.0 due to a dependency
  conflict with the 'net-scp' and 'net-ssh' dependnecies of the fog gem.
  If you have a solution for this, please send a Pull Request.

## Attributes

All attributes are `nil`, or `false` by default.

- `node[:dnsimple][:username]`: Your DNSimple login username.
- `node[:dnsimple][:password]`: Your DNSimple login password.
- `node[:dnsimple][:domain]`: The domain that this node should use.
- `node[:dnsimple][:test]`: Unused at this time.

## Resources/Providers

dnsimple\_record
----------------

Manage a DNS resource record through the DNSimple API. This LWRP uses
the [fog Ruby library](http://rubygems.org/gems/fog) to connect and
use the API.

### Actions:

    | Action    | Description          | Default |
    |-----------|----------------------|---------|
    | *create*  | Create the record.   | Yes     |
    | *destroy* | Destroy the record.  |         |

### Parameter Attributes:

The type of record can be one of the following: A, CNAME, ALIAS, MX,
SPF, URL, TXT, NS, SRV, NAPTR, PTR, AAA, SSHFP, or HFINO.

    | Parameter  | Description                     | Default |
    |------------|---------------------------------|---------|
    | *domain*   | Domain to manage                |         |
    | *name*     | _Name_: Name of the record      |         |
    | *type*     | Type of DNS record              |         |
    | *content*  | String/Array content of records |         |
    | *ttl*      | Time to live.                   | 3600    |
    | *priority* | Priorty of update               |         |
    | *username* | DNSimple username               |         |
    | *password* | DNSimple password               |         |
    | *test*     | Unused at this time             | false   |

### Examples

    dnsimple_record "create an A record" do
      name     "test"
      content  "16.8.4.2"
      type     "A"
      domain   node[:dnsimple][:domain]
      username node[:dnsimple][:username]
      password node[:dnsimple][:password]
      action   :create
    end

    dnsimple_record "create a CNAME record for a Google Apps site calendar" do
      name     "calendar"
      content  "ghs.google.com"
      type     "CNAME"
      domain   node[:dnsimple][:domain]
      username node[:dnsimple][:username]
      password node[:dnsimple][:password]
      action   :create
    end

    dnsimple_record "create a A record with multiple content values" do
      name     "multiple"
      content  ["1.1.1.1", "2.2.2.2"]
      type     "A"
      domain   node[:dnsimple][:domain]
      username node[:dnsimple][:username]
      password node[:dnsimple][:password]
      action   :create
    end

## Usage

Add the the `dnsimple` recipe to a node's run list, or with
`include_recipe` to install the [fog](http://rubygems.org/gems/fog)
gem, which is used to interact with the DNSimple API. See
examples of the LWRP usage above.

## Testing

To run the tests across all platforms, you want to grab the latest [ChefDK][]
install [VirtualBox][], and [Vagrant][] then run `kitchen test`. If you want to
get a cache speed boost, run `vagrant plugin install vagrant-cachier` and your
chef runs will speed up _dramatically_ thanks to local caching.

## License and Author

* Author:: [Darrin Eden](https://github.com/dje)
* Author:: [Joshua Timberman](https://github.com/jtimberman)
* Author:: [Jose Luis Salas](https://github.com/josacar)

Copyright:: 2014-2016 Aetrion, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[ChefDK]: https://downloads.chef.io/chef-dk/
[VirtualBox]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: https://www.vagrantup.com/downloads.html

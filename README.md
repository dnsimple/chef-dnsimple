## Description

A Light-weight Resource Provider (LWRP) supporting
automatic DNS configuration via DNSimple's API.

[![Build Status](https://travis-ci.org/dnsimple/chef-dnsimple.png?branch=master)](https://travis-ci.org/dnsimple/chef-dnsimple)

## Requirements

* A DNSimple account at https://dnsimple.com
* Chef 12 or newer

## Deprecation Warning

* The 2.x series of this cookbook will drop support for the Fog gem
  and username/password authentication along with Chef 11 support. Please
  version pin in your metadata or Berksfile to the nearest 1.x minor version
  to maintain backward compatibility like so: `cookbook "dnsimple", "~> 1.3.0"`

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

    | Parameter    | Description                        | Default   |
    | ------------ | ---------------------------------  | --------- |
    | *domain*     | Domain to manage                   |           |
    | *name*       | _Name_: Name of the record         |           |
    | *type*       | Type of DNS record                 |           |
    | *content*    | String/Array content of records    |           |
    | *ttl*        | Time to live.                      | 3600      |
    | *priority*   | Priorty of update                  |           |
    | *username*   | DNSimple username                  |           |
    | *password*   | DNSimple password (**DEPRECATED**) |           |
    | *token*      | DNSimple API token                 |           |
    | *test*       | Unused at this time                | false     |

**Note**: For token based authentication you must provide an [api token][] for
the account with access to the domain you are providing in the resource. User
access tokens are also not supported at this time.  Domain based tokens will be
supported in a future release.

### Examples

```ruby
    dnsimple_record "create an A record using the DEPRECATED username/password authentication" do
      name     "test"
      content  "16.8.4.2"
      type     "A"
      domain   "example.com"
      username chef_vault_item("secrets", "dnsimple_username")
      password chef_vault_item("secrets", "dnsimple_password")
      action   :create
    end

    dnsimple_record "create an A record" do
      name     "test"
      content  "16.8.4.2"
      type     "A"
      domain   "example.com"
      username chef_vault_item("secrets", "dnsimple_username")
      token    chef_vault_item("secrets", "dnsimple_token")
      action   :create
    end

    dnsimple_record "create a CNAME record for a Google Apps site calendar" do
      name     "calendar"
      content  "ghs.google.com"
      type     "CNAME"
      domain   "example.com"
      username chef_vault_item("secrets", "dnsimple_username")
      token    chef_vault_item("secrets", "dnsimple_token")
      action   :create
    end

    dnsimple_record "create a A record with multiple content values" do
      name     "multiple"
      content  ["1.1.1.1", "2.2.2.2"]
      type     "A"
      domain   "example.com"
      username chef_vault_item("secrets", "dnsimple_username")
      token    chef_vault_item("secrets", "dnsimple_token")
      action   :create
    end
```

## Usage

Add the the `dnsimple` recipe to a node's run list, or with
`include_recipe` to install the [fog](http://rubygems.org/gems/fog)
gem, which is used to interact with the DNSimple API. See
examples of the LWRP usage above.

## Testing

To run the tests across all platforms you want to grab the latest [ChefDK][]
install [VirtualBox][], [Vagrant][],  and then run the following;

* `chef exec berks install`
* `chef exec rake all`

While this should work on ubuntu-16.04 we removed it from kitchen because of
issues with the bento. If you have a resolution for this or would like more
OSes added Pull Requests are appreciated.

## License and Authors

* Author:: [Aaron Kalin](https://github.com/martinisoft)
* Author:: [David Aronsohn](https://github.com/tbunnyman)
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
[api token]: https://developer.dnsimple.com/v1/authentication/#api-token

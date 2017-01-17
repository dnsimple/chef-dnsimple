## Description

A Light-weight Resource Provider (LWRP) supporting
automatic DNS configuration via DNSimple's API.

[![Build Status](https://travis-ci.org/dnsimple/chef-dnsimple.png?branch=master)](https://travis-ci.org/dnsimple/chef-dnsimple)
[![Build Status](https://jenkins-01.eastus.cloudapp.azure.com/job/dnsimple-cookbook/badge/icon)](https://jenkins-01.eastus.cloudapp.azure.com/job/dnsimple-cookbook/)

## Requirements

* A DNSimple account at https://dnsimple.com
* Chef 12 or newer

## Attributes

- `default["dnsimple"]["version"]`: The version of the DNSimple gem to install

## Resources/Providers

dnsimple\_record
----------------

Manage a DNS resource record through the DNSimple API. This resource uses
the [dnsimple Ruby library](http://rubygems.org/gems/dnsimple) to connect and
use the DNSimple API.

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

Note that these examples assume you have the username, domain, and token
attributes set as they are implied in these examples. You can always specify
those attributes directly if you want to use other domains or access contexts.

```ruby
    # dnsimple_record 'fooserver' do
    #   zone 'foo.com'
    #   type 'a'
    #   content '1.2.3.4'
    #   ttl 3600
    #   configuration 'foo'
    #   action :create
    # end

    # dnsimple_configuration 'foocompany' do
    #   access_token ''
    # end

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

Add the dnsimple cookbook to your cookbook's metadata and it will automatically
install the dnsimple gem and make the dnsimple\_record resource available.

## Testing

To run the tests across all platforms, you want to grab the latest [ChefDK][]
install [VirtualBox][], [Vagrant][], and the following gems into your ChefDK:

* [dnsimple][dnsimple-gem]

Then run `chef exec rake quick` for unit and style tests.

## License and Authors

* Author:: [Aaron Kalin](https://github.com/martinisoft)
* Author:: [David Aronsohn](https://github.com/tbunnyman)
* Author:: [Jacobo Garcia](https://github.com/therobot)

Copyright:: 2014-2017 Aetrion, LLC dba DNSimple

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
[Chefstyle]: https://github.com/chef/chefstyle
[api token]: https://developer.dnsimple.com/v1/authentication/#api-token
[dnsimple-gem]: https://rubygems.org/gems/dnsimple
[webmock]: https://rubygems.org/gems/webmock

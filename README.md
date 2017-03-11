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
the [dnsimple Ruby library](https://rubygems.org/gems/dnsimple) to connect and
use the DNSimple API.

### Actions:

    | Action    | Description          | Default |
    |-----------|----------------------|---------|
    | *create*  | Create the record.   | Yes     |
    | *destroy* | Destroy the record.  |         |

### Parameter Attributes:

The type of record can be one of the following: A, CNAME, ALIAS, MX,
SPF, URL, TXT, NS, SRV, NAPTR, PTR, AAA, SSHFP, or HFINO.

    | Parameter    | Description                        | Required | Default   |
    | ------------ | ---------------------------------  | -------- | --------- |
    | *domain*     | Domain to manage                   | true     |           |
    | *name*       | Name of the record                 |          | Apex of the domain |
    | *type*       | Type of DNS record                 | true     |           |
    | *content*    | String/Array content of records    | true     |           |
    | *ttl*        | Time to live                       |          | 3600      |
    | *priority*   | Priorty of record                  |          |           |
    | *regions*    | Specific regions for this record   |          |           |
    | *token*      | DNSimple API token                 |          |           |

**Note**: If you do not provide the name parameter, it will be assumed from the
resource name, which cannot be blank. If you want to create multiple record
types on the apex then you need to name each resource separately, but keep the
name an empty string.

**Regional Records**: Only certain plan types have regional records so it is
blank by default. If you do not have this feature available it will return
an error.

### Examples

Note that these examples assume you have the username, domain, and token
attributes set as they are implied in these examples. You can always specify
those attributes directly if you want to use other domains or access contexts.

```ruby
    dnsimple_record 'fooserver' do
      zone 'foo.com'
      type 'A'
      content '1.2.3.4'
      ttl 3600
      access_token chef_vault_item('secrets', 'dnsimple_token')
      action :create
    end

    dnsimple_record 'create a CNAME record for a Google Apps site calendar' do
      name 'calendar'
      content 'ghs.google.com'
      type 'CNAME'
      domain 'example.com'
      access_token chef_vault_item('secrets', 'dnsimple_token')
      action :create
    end

    dnsimple_record "create a A record with multiple content values" do
      name     'servers'
      content  ['1.1.1.1', '2.2.2.2']
      type     'A'
      domain   'example.com'
      access_token chef_vault_item('secrets', 'dnsimple_token')
      action   :create
    end

    dnsimple_record "create a A record in Tokyo only" do
      name     'myserverinjapan'
      content  '2.2.2.2'
      type     'A'
      domain   'example.com'
      regions  ['tko']
      access_token chef_vault_item('secrets', 'dnsimple_token')
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
* Author:: [David Aronsohn](https://github.com/onlyhavecans)
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
[dnsimple-gem]: https://rubygems.org/gems/dnsimple

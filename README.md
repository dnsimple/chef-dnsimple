
Description
===========

A Light-weight Resource and Provider (LWRP) supporting
automatic DNS configuration via DNSimple's API.

Changes
=======

* Convert README to markdown so it is displayed nice on Community
  site.
* Add default action `:create` for `dnsimple_record`.
* Set values that `type` can be equal to in `dnsimple_record` resource.

Requirements
============

A DNSimple account at http://dnsimple.com

Attributes
==========

All attributes are `nil`, or `false` by default.

- `node[:dnsimple][:username]`: Your DNSimple login username.
- `node[:dnsimple][:password]`: Your DNSimple login password.
- `node[:dnsimple][:domain]`: The domain that this node should use.
- `node[:dnsimple][:test]`: Unused at this time.

Resources/Providers
===================

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

    | Parameter  | Description                | Default |
    |------------|----------------------------|---------|
    | *domain*   | Domain to manage           |         |
    | *name*     | _Name_: Name of the record |         |
    | *type*     | Type of DNS record         |         |
    | *content*  | String content of record   |         |
    | *ttl*      | Time to live.              | 3600    |
    | *priority* | Priorty of update          |         |
    | *username* | DNSimple username          |         |
    | *password* | DNSimple password          |         |
    | *test*     | Unused at this time        | false   |

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

Usage
=====

Add the the `dnsimple` recipe to a node's run list, or with
`include_recipe` to install the [fog](http://rubygems.org/gems/fog)
gem, which is used to interact with the DNSimple API. See
examples of the LWRP usage above.

License and Author
==================

Author:: Darrin Eden (<darrin@heavywater.ca>)
Author:: Joshua Timberman (<opensource@housepub.org>)

Copyright:: 2010-2011 Heavy Water Software

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

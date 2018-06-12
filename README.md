## Description

A chef resource for automated DNS configuration via the [dnsimple](https://dnsimple.com/) API.

[![Build Status](https://travis-ci.org/dnsimple/chef-dnsimple.png?branch=master)](https://travis-ci.org/dnsimple/chef-dnsimple)
[![Build Status](https://jenkins-01.eastus.cloudapp.azure.com/job/dnsimple-cookbook/badge/icon)](https://jenkins-01.eastus.cloudapp.azure.com/job/dnsimple-cookbook/)

## DEPRECATION WARNING

If you use the 'name' property on the `dnsimple_record` resource, you will need to change this to `record_name` instead. The 'name' property is reserved in Chef and we needed to rename it to preserve future compatibility.

## Requirements

* A [dnsimple](https://dnsimple.com/) account
* An [account access token](https://developer.dnsimple.com/v2/#account-tokens-vs-user-tokens) from said dnsimple account
* Chef 13.9 or newer

## Attributes

- None

## Resources/Providers

### dnsimple\_record

Manage a DNS record through the dnsimple API. This resource uses the
[dnsimple Ruby library](https://rubygems.org/gems/dnsimple) to connect and use
the dnsimple API. This resource also exposes a ChefSpec matcher for you to do
unit testing as well.

#### Actions:

| Action    | Description          | Default |
|-----------|----------------------|---------|
| *create*  | Create the record.   | Yes     |
| *update*  | Update the record.   |         |
| *destroy* | Destroy the record.  |         |

#### Resource Properties:

| Property  	| Description                      | Required | Default              |
|---------------|----------------------------------|----------|----------------------|
| *domain*      | Domain to manage                 | true     |                      |
| *record_name* | Name of the record               |          | ''                   |
| *type*        | Type of DNS record (see note)    | true     |                      |
| *content*     | String/Array content of records  | true     |                      |
| *ttl*         | Time to live                     |          | 3600                 |
| *priority*    | Priorty of record                |          |                      |
| *regions*     | Specific regions for this record |          |                      |
| *token*       | DNSimple API token               |          |                      |

**Record Types**: The type of record can be one of the following: A, AAAA,
CAA, CNAME, MX, NS, TXT, SPF, SRV, NAPTR, HINFO, SSHFP, ALIAS, URL or POOL.
Some of these record types such as POOL require special account access which
you can [contact support](https://dnsimple.com/contact) for access and
assistance.

**Note**: If you do not provide the record_name parameter, it will be blank
and thus will be assumed to be the domain apex. The apex is the domain name
without a subdomain. For example `bar.com` is the apex of `foo.bar.com`.

**Regional Records**: Only certain plan types have regional records so it is
blank by default. If you do not have this feature available it will return
an error.

#### Examples

Note that these examples assume you have obtained an account level access token
which is documented above (see Requirements). We're also assuming you're securely
storing your API keys in [Chef Vault](https://docs.chef.io/chef_vault.html) but
it is not a requirement.

```ruby
dnsimple_record 'foo.com main server' do
  domain 'foo.com'
  type 'A'
  content '1.2.3.4'
  ttl 3600
  access_token chef_vault_item('secrets', 'dnsimple_token')
  action :create
end

dnsimple_record 'create a CNAME record for a Google Apps site calendar at calendar.example.com' do
  record_name    'calendar'
  content        'ghs.google.com'
  type           'CNAME'
  domain         'example.com'
  access_token   chef_vault_item('secrets',   'dnsimple_token')
  action         :create
end

dnsimple_record 'create an A record with multiple content values at servers.example.com' do
  record_name   'servers'
  content       ['1.1.1.1', '2.2.2.2']
  type          'A'
  domain        'example.com'
  access_token  chef_vault_item('secrets', 'dnsimple_token')
  action        :create
end

# Note: This only works with certain accounts, see the note above for
# regional records! The Chef run will fail otherwise.
dnsimple_record "create an A record in Tokyo only" do
  record_name   'myserverinjapan'
  content       '2.2.2.2'
  type          'A'
  domain        'example.com'
  regions       ['tko']
  access_token  chef_vault_item('secrets', 'dnsimple_token')
  action        :create
end
```

### dnsimple\_certificate

Download and install a certificate. Currently this only supports basic matched
.crt & .key files. We would like to expand this to support all formats
including java keystores. *PRs are welcome*!

This resource uses the [dnsimple Ruby
library](https://rubygems.org/gems/dnsimple) to connect and use the dnsimple
API. This resource also exposes a ChefSpec matcher for you to do unit testing
as well.


#### Actions:

| Action    | Description           | Default |
|-----------|-----------------------|---------|
| *install* | Install the crt & key | Yes     |


#### Resource Properties:

| Property                | Description                       | Required | Default |
|-------------------------|-----------------------------------|----------|---------|
| install_path            | where the crt & key are installed | yes      |         |
| certificate_common_name | name of the files                 | yes      |         |
| domain                  | the main domain name on the crt   | yes      |         |
| mode                    | files mode                        | no       | 0600    |
| owner                   | files owner                       | no       | root    |
| group                   | files group                       | no       | root    |


#### Examples

```ruby
dnsimple_certificate '/etc/apache2/ssl' do
  certificate_common_name 'www.dnsimple.xyz'
  domain 'dnsimple.xyz'
  access_token chef_vault_item('secrets', 'dnsimple_token')
  mode '0755'
  owner 'web_admin'
  group 'web_admin'
end
```

## Usage

Add the dnsimple cookbook to your cookbook's metadata and it will automatically
install the dnsimple gem and make the dnsimple\_record resource available.

## Testing

See TESTING.md

## Contributing

See CONTRIBUTING.md

## License and Authors

* Author:: [Aaron Kalin](https://github.com/martinisoft)
* Author:: [David Aronsohn](https://github.com/onlyhavecans)
* Author:: [Jacobo Garcia](https://github.com/therobot)
* Author:: [Anthony Eden](https://github.com/aeden)

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

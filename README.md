## Description

A chef resource for automated DNS configuration via the [dnsimple](https://dnsimple.com/) API.

[![Build Status](https://travis-ci.org/dnsimple/chef-dnsimple.png?branch=master)](https://travis-ci.org/dnsimple/chef-dnsimple)
[![Build Status](https://jenkins-01.eastus.cloudapp.azure.com/job/dnsimple-cookbook/badge/icon)](https://jenkins-01.eastus.cloudapp.azure.com/job/dnsimple-cookbook/)

## DEPRECATION WARNING

If you used the 1.x series of this cookbook please carefully review your usage of the resource and create a new account access token. The access token you used previously _will not work_ with this version of the cookbook. You will also not need a username and password for this version either. Please refer to the examples below for more details, but the majority of the changes are around authentication.

## Requirements

* A [dnsimple](https://dnsimple.com/) account
* An [account access token](https://developer.dnsimple.com/v2/#account-tokens-vs-user-tokens) from said dnsimple account
* Chef 12.8 or newer

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

#### Parameter Attributes:

The type of record can be one of the following: A, CNAME, ALIAS, MX,
SPF, URL, TXT, NS, SRV, NAPTR, PTR, AAA, SSHFP, or HFINO.

| Parameter  | Description                      | Required | Default            |
|------------|----------------------------------|----------|--------------------|
| *domain*   | Domain to manage                 | true     |                    |
| *name*     | Name of the record               |          | Apex of the domain |
| *type*     | Type of DNS record               | true     |                    |
| *content*  | String/Array content of records  | true     |                    |
| *ttl*      | Time to live                     |          | 3600               |
| *priority* | Priorty of record                |          |                    |
| *regions*  | Specific regions for this record |          |                    |
| *token*    | DNSimple API token               |          |                    |

**Note**: If you do not provide the name parameter, it will be assumed from the
resource name, which cannot be blank. If you want to create multiple record
types on the apex then you need to name each resource separately, but keep the
name an empty string.

**Regional Records**: Only certain plan types have regional records so it is
blank by default. If you do not have this feature available it will return
an error.

#### Examples

Note that these examples assume you have obtained an account level access token
which is documented above (see Requirements). We're also assuming you're securely
storing your API keys in [Chef Vault](https://docs.chef.io/chef_vault.html) but
it is not a requirement.

```ruby
dnsimple_record 'fooserver' do
  domain 'foo.com'
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

# Note: This only works with certain accounts, see the note above for
# regional records! The Chef run will fail otherwise.
dnsimple_record "create an A record in Tokyo only" do
  name     'myserverinjapan'
  content  '2.2.2.2'
  type     'A'
  domain   'example.com'
  regions  ['tko']
  access_token chef_vault_item('secrets', 'dnsimple_token')
  action   :create
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


#### Parameter Attributes:

| Parameter               | Description                       | Required | Default |
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

#
# Cookbook Name:: dnsimple
# Resource:: record
#
# Copyright 2014-2017 Aetrion, LLC dba DNSimple
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :record_name,   kind_of: String, name_property: true
property :domain,        kind_of: String
property :name,          kind_of: String, required: true
property :type,          kind_of: String, equal_to: %w(A CNAME ALIAS MX SPF URL TXT NS SRV NAPTR PTR AAA SSHFP HFINO), required: true
property :content,       kind_of: [String, Array]
property :ttl,           kind_of: Integer, default: 3600
property :priority,      kind_of: Integer
property :access_token,  kind_of: String
property :regions,       kind_of: Array, default: ['global']

default_action :create

action :create do
  create_record
end

action_class do
  include DNSimpleCookbook::Helpers

  def create_record
    client = dnsimple_client
    account_id = dnsimple_client_account_id

    values = Array(new_resource.content)
    values.each do |value|
      client.zones.create_record(account_id, new_resource.name,
        type, value, ttl, priority, regions)
    end
  end
end

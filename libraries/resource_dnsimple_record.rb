#
# Cookbook Name:: dnsimple
# Library:: resource_dnsimple_record
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

require_relative 'dnsimple_resource'

class Chef
  class Resource
    class DnsimpleRecord < DnsimpleResource
      resource_name :dnsimple_record

      allowed_actions :create, :delete, :update
      default_action :create

      property :record_name,   kind_of: String, name_property: true
      property :domain,        kind_of: String
      property :name,          kind_of: String, required: true
      property :type,          kind_of: String, equal_to: %w(A CNAME ALIAS MX SPF URL TXT NS SRV NAPTR PTR AAAA SSHFP HFINO), required: true
      property :content,       kind_of: [String, Array]
      property :ttl,           kind_of: Integer, default: 3600
      property :priority,      kind_of: Integer
      property :regions,       kind_of: [NilClass, Array], default: nil
    end
  end
end

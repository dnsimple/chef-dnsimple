#
# Cookbook:: dnsimple
# Library:: resource_dnsimple_record
#
# Copyright:: 2021, DNSimple Corp, All Rights Reserved.
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
      provides :dnsimple_record

      allowed_actions :create, :delete, :update
      default_action :create

      property :record_name,   String, default: ''
      property :domain,        String
      property :type,          String, equal_to: %w(A AAAA CAA CNAME MX NS TXT SPF SRV NAPTR HINFO SSHFP ALIAS URL POOL), required: true
      property :content,       [String, Array]
      property :ttl,           Integer, default: 3600
      property :priority,      Integer
      property :regions,       Array
    end
  end
end

#
# Cookbook Name:: dnsimple
# Library:: resource_dnsimple_certificate
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
    class DnsimpleCertificate < DnsimpleResource
      resource_name :dnsimple_certificate

      allowed_actions :install
      default_action :install

      property :install_path,             kind_of: String, name_property: true
      property :certificate_common_name,  kind_of: String, required: true
      property :domain,                   kind_of: String, required: true
      property :expires_on,               kind_of: Date
      property :server_pem,               kind_of: String
      property :chain_pem,                kind_of: Array
      property :private_key_pem,          kind_of: String

      property :mode,                     kind_of: String, default: '0600'
      property :owner,                    kind_of: String, default: 'root'
      property :group,                    kind_of: String, default: 'root'
    end
  end
end

#
# Cookbook Name:: dnsimple
# Library:: provider_dnsimple_record
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

require_relative 'dnsimple_provider'

class Chef
  class Provider
    class DnsimpleRecord < DnsimpleProvider
      use_inline_resources

      action :create do
        create_record
      end

      def create_record
        dnsimple_client.zones.create_record(
          dnsimple_client_account_id, new_resource.domain,
          name: new_resource.record_name, type: new_resource.type,
          content: new_resource.content, ttl: new_resource.ttl,
          priority: new_resource.priority, regions: new_resource.regions
        )
      end
    end
  end
end

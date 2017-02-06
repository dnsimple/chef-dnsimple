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
        # TO-DO assuming that chef assings values to record_name
        # when not using it as property
        client = dnsimple_client
        account_id = dnsimple_client_account_id

        # TO-DO we are using the underlying ruby library to
        # handle multiple content as an Array
        client.zones.create_record(
          account_id, domain,
          name: record_name, type: type, content: content,
          ttl: ttl, priority: priority, regions: regions
        )
      end
    end
  end
end

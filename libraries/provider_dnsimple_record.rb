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

      provides :dnsimple_record

      def load_current_resource
        @current_resource = Chef::Resource::DnsimpleRecord.new(@new_resource.name)
        @current_resource.name(@new_resource.name)
        @current_resource.domain(@new_resource.domain)

        @current_resource.exists = check_for_record
      end

      action :create do
        case @current_resource.exists
        when :same
          Chef::Log.info "#{@new_resource} already exists - nothing to do."
        when :none
          create_record
        end
      end

      def create_record
        record_options = {
          name: new_resource.record_name, type: new_resource.type,
          content: new_resource.content, ttl: new_resource.ttl,
          priority: new_resource.priority
        }
        record_options.merge(regions: new_resource.regions) if new_resource.regions
        dnsimple_client.zones.create_record(
          dnsimple_client_account_id, new_resource.domain, **record_options
        )
        new_resource.updated_by_last_action(true)
        Chef::Log.info "DNSimple: created #{new_resource.type} record for #{new_resource.name}.#{new_resource.domain}"
      rescue Dnsimple::RequestError => e
        raise "Unable to complete create record request. Error: #{e.message}"
      end

      def check_for_record
        found_content = []
        all_records_in_zone do |r|
          if (r.name == new_resource.name) && (r.type == new_resource.type) && (r.ttl == new_resource.ttl)
            found_content << r.content
          end
        end
        new_content = Array(new_resource.content)
        changes = found_content - new_content
        existing_records(found_content, changes)
      end

      def existing_records(found_content, changes)
        if found_content.empty?
          :none
        elsif changes.empty?
          :same
        else
          :different
        end
      end

      def all_records_in_zone
        records = dnsimple_client.zones.all_records(dnsimple_client_account_id, new_resource.domain)

        records.data.each do |r|
          yield r if block_given?
        end
      end
    end
  end
end

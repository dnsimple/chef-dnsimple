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
        @current_resource.type(@new_resource.type)

        records = dnsimple_client.zones.all_records(dnsimple_client_account_id,
                                                    @new_resource.domain)
        @existing_record = records.data.detect do |record|
          (record.name == @new_resource.record_name) && (record.type == @new_resource.type)
        end

        @current_resource.exists = !@existing_record.nil?
      end

      action :create do
        if @current_resource.exists
          Chef::Log.info "DNSimple: #{@new_resource} already exists - nothing to do."
        else
          create_record
        end
      end

      action :delete do
        if @current_resource.exists
          delete_record
        else
          Chef::Log.info "DNSimple: no record found #{new_resource.name}.#{new_resource.domain}" \
            " with type #{new_resource.type}"
        end
      end

      action :update do
        if @current_resource.exists
          update_record
        else
          Chef::Log.info "DNSimple: no record found #{new_resource.name}.#{new_resource.domain}" \
            " with type #{new_resource.type}"
        end
      end

      def create_record
        converge_by("create record #{new_resource.record_name} for domain #{new_resource.domain}") do
          dnsimple_client.zones.create_record(
            dnsimple_client_account_id, new_resource.domain, **record_options
          )
          Chef::Log.info "DNSimple: created #{new_resource.type} record for #{new_resource.name}.#{new_resource.domain}"
        end
      rescue Dnsimple::RequestError => e
        raise "DNSimple: Unable to complete create record request. Error: #{e.message}"
      end

      def delete_record
        converge_by("delete record #{@new_resource.record_name} from domain #{@new_resource.domain}") do
          dnsimple_client.zones.delete_record(dnsimple_client_account_id,
                                              @current_resource.domain,
                                              existing_record_id)
          Chef::Log.info "DNSimple: destroyed #{@new_resource.type} record " \
            "for #{@new_resource.name}.#{@new_resource.domain}"
        end
      rescue Dnsimple::RequestError => e
        raise "DNSimple: Unable to complete create record request. Error: #{e.message}"
      end

      def update_record
        return unless changed_record?
        converge_by("update record #{new_resource.record_name} for domain #{new_resource.domain}") do
          dnsimple_client.zones.update_record(dnsimple_client_account_id,
                                              new_resource.domain,
                                              existing_record_id,
                                              **record_options)
          Chef::Log.info "DNSimple: updated #{new_resource.type} record for #{new_resource.name}.#{new_resource.domain}"
        end
      end

      def record_options
        options = {
          name: new_resource.record_name, type: new_resource.type,
          content: new_resource.content, ttl: new_resource.ttl,
          priority: new_resource.priority
        }
        options.merge(regions: new_resource.regions) if new_resource.regions
        options
      end

      def changed_record?
        (@existing_record.ttl != new_resource.ttl) ||
          (@existing_record.content != new_resource.content) ||
          (@existing_record.priority != new_resource.priority) ||
          ((@existing_record.regions != new_resource.regions) if new_resource.regions)
      end

      def existing_record_id
        @existing_record.id
      end
    end
  end
end

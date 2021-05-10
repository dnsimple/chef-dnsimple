#
# Cookbook:: dnsimple
# Library:: provider_dnsimple_certificate
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

require_relative 'dnsimple_provider'

class Chef
  class Provider
    class DnsimpleCertificate < DnsimpleProvider
      provides :dnsimple_certificate

      def load_current_resource
        @current_resource = Chef::Resource::DnsimpleCertificate.new(@new_resource.name)
        @current_resource.common_name(@new_resource.common_name)
        @current_resource.domain(@new_resource.domain)
        @current_resource.install_path(@new_resource.install_path)

        certificates = dnsimple_client.certificates.all_certificates(dnsimple_client_account_id, @new_resource.domain)
        @existing_certificate = certificates.data.detect do |certificate|
          (certificate.common_name == @new_resource.common_name) && (certificate.state == 'issued') && (Time.parse(certificate.expires_at) > Time.now)
        end

        @current_resource.exists = !@existing_certificate.nil?
        if @current_resource.exists
          @current_resource.expires_at = @existing_certificate.expires_at
          @existing_certificate_bundle = dnsimple_client.certificates.download_certificate(dnsimple_client_account_id, @new_resource.domain, @existing_certificate.id).data
          @current_resource.server_pem = @existing_certificate_bundle.server
          @current_resource.chain_pem = @existing_certificate_bundle.chain
          # Allow override with custom private key
          if @new_resource.private_key_pem
            @current_resource.private_key_pem = @new_resource.private_key_pem
          else
            @existing_private_key = dnsimple_client.certificates.certificate_private_key(dnsimple_client_account_id, @new_resource.domain, @existing_certificate.id).data
            @current_resource.private_key_pem = @existing_private_key.private_key
          end
        end
      end

      action :install do
        if @current_resource.exists
          install_certificate
        else
          Chef::Log.info "DNSimple: no certificate found #{new_resource.common_name}"
        end
      end

      def install_certificate
        converge_by("install certificate #{current_resource.common_name} expiring #{current_resource.expires_at}") do
          declare_resource(:file, "#{current_resource.name}/#{current_resource.domain}.crt") do
            content "#{current_resource.server_pem}#{current_resource.chain_pem.join("\n")}"
            mode current_resource.mode
            owner current_resource.owner
            group current_resource.group
          end
          declare_resource(:file, "#{current_resource.name}/#{current_resource.domain}.key") do
            content current_resource.private_key_pem
            mode current_resource.mode
            owner current_resource.owner
            group current_resource.group
            sensitive true
          end
        end
      end
    end
  end
end

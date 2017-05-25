#
# Cookbook Name:: dnsimple
# Library:: provider_dnsimple_certificate
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
    class DnsimpleCertificate < DnsimpleProvider
      use_inline_resources

      provides :dnsimple_certificate

      def load_current_resource
        @current_resource = Chef::Resource::DnsimpleCertificate.new(@new_resource.name)
      end

      action :install do
        # do something
      end
    end
  end
end

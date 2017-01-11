#
# Cookbook Name:: dnsimple
# Library:: dnsimple
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

module DNSimpleCookbook
  module Helpers
    def dnsimple_client
      dnsimple_gem_require
      Dnsimple::Client.new(access_token: dnsimple_access_token)
    rescue Dnsimple::AuthenticationFailed
      Chef::Log.error("Could not authenticate, see the README for more details on authentication tokens.")
    end

    def dnsimple_gem_require
      retried = false
      begin
        gem 'dnsimple', version: dnsimple_gem_version
        require 'dnsimple'
        Chef::Log.debug("Node had dnsimple #{dnsimple_gem_version} installed. No need to install the gem.")
      rescue LoadError
        Chef::Log.debug("Did not find dnsimple version #{dnsimple_gem_version} installed. Installing now.")

        install_dnsimple_gem(dnsimple_gem_version)

        raise if retried
        retried = true
        retry
      end

      # dnsimple_record 'fooserver' do
      #   zone 'foo.com'
      #   type 'a'
      #   content '1.2.3.4'
      #   ttl 3600
      #   configuration 'foo'
      #   action :create
      # end

      # dnsimple_configuration 'foocompany' do
      #   access_token ''
      # end
    end


    def dnsimple_gem_version
      node['dnsimple']['version']
    end

    def install_dnsimple_gem(gem_version)
      chef_gem 'dnsimple' do
        version gem_version
        compile_time true
        action :install
      end
    end

    def dnsimple_access_token
      new_resource.access_token
    end
  end
end

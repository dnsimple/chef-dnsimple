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
    def require_dnsimple_library
      gem 'dnsimple', node['dnsimple']['version']
      require 'dnsimple'
      Chef::Log.debug("Node had dnsimple #{node['dnsimple']['version']} installed. No need to install the gem.")
    rescue LoadError
      Chef::Log.debug("Did not find dnsimple version #{node['dnsimple']['version']} installed. Installing now.")

      chef_gem 'dnsimple' do
        version node['dnsimple']['version']
        compile_time true if Chef::Resource::ChefGem.method_defined?(:compile_time)
        action :install
      end

      require 'dnsimple'
    end

    def dnsimple
      require_dnsimple_library

      @dnsimple ||= Dnsimple::Client.new(username: new_resource.username || node['dnsimple']['username'],
                                         api_token: new_resource.token || node['dnsimple']['token'])
    end
  end
end

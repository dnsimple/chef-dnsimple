
class Chef
  class Provider
    class DnsimpleProvider < Chef::Provider
      attr_writer :dnsimple_client

      def dnsimple_client_account_id
        data = dnsimple_client_account.data
        if data.account.nil?
          raise 'Cannot find account id, please make sure you provide an account
          token and not a user token. See README for more information.'
        end
        data.account.id
      end

      def dnsimple_client_account
        dnsimple_client.identity.whoami
      rescue Dnsimple::AuthenticationFailed
        raise 'Authentication failed. Please check your access token'
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
      end

      def dnsimple_gem_version
        node['dnsimple']['version']
      end

      def install_dnsimple_gem(gem_version)
        chef_gem 'dnsimple' do
          version gem_version || dnsimple_gem_version
          compile_time true
          action :install
        end
      end

      def dnsimple_client
        dnsimple_gem_require
        @dnsimple_client ||= Dnsimple::Client.new(
          access_token: new_resource.access_token
        )
      end
    end
  end
end

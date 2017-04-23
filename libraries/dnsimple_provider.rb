
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

      def dnsimple_client
        require 'dnsimple'
        @dnsimple_client ||= Dnsimple::Client.new(
          access_token: new_resource.access_token,
          base_url: new_resource.base_url,
          user_agent: "chef-dnsimple #{run_context.cookbook_collection['dnsimple'].metadata.version}"
        )
      end
    end
  end
end

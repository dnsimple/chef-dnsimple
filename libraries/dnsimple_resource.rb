class Chef
  class Resource
    class DnsimpleResource < Chef::Resource
      provides :dnsimple_resource
      unified_mode true

      attr_accessor :exists

      def after_created
        sensitive(true)
      end

      property :access_token, String, required: true, sensitive: true
      property :base_url, String, default: 'https://api.dnsimple.com'
    end
  end
end

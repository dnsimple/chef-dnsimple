
class Chef
  class Resource
    class DnsimpleResource < Chef::Resource
      attr_accessor :exists

      def after_created
        sensitive(true)
      end

      property :access_token, kind_of: String, required: true
      property :base_url, kind_of: String, default: 'https://api.dnsimple.com'
    end
  end
end

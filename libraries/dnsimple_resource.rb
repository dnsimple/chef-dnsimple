
class Chef
  class Resource
    class DnsimpleResource < Chef::Resource
      attr_accessor :exists

      property :access_token, kind_of: String, required: true
      property :base_uri, kind_of: String, default: 'https://api.dnsimple.com'
    end
  end
end

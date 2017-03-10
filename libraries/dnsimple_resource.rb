
class Chef
  class Resource
    class DnsimpleResource < Chef::Resource
      attr_accessor :exists

      property :access_token, kind_of: String, required: true
    end
  end
end

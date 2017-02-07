
class Chef
  class Resource
    class DnsimpleResource < Chef::Resource
      property :access_token, kind_of: String, required: true
    end
  end
end

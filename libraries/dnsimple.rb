begin
  require "fog"
  Excon.defaults[:ssl_verify_peer] = false
rescue LoadError
  Chef::Log.warn("Missing gem 'fog'")
end

module DNSimple
  module Connection
    def dnsimple
      @@dnsimple ||= Fog::DNS.new( :provider => "DNSimple",
                                   :dnsimple_email => new_resource.username,
                                   :dnsimple_password => new_resource.password )
    end
  end
end

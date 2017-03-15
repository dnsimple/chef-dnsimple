require 'dnsimple'

class DnsimpleZone < Inspec.resource(1)
  name 'dnsimple_zone'
  desc 'Use the dnsimple_zone InSpec audit resource to verify zone data via the dnsimple API.'
  example "
      describe dnsimple_zone('example.com', name: 'server', token: 'abc321') do
        its('value') { should eq '1.2.3.4' }
        its('ttl') { should eq '3600' }
      end
  "

  def initialize(zone, name: nil, token: nil, type: nil)
    @zone = zone
    @name = name
    @token = token
    @type = type
  end

  def value
    response.value if response.respond_to?(:value)
  end

  def ttl
    response.ttl if response.respond_to?(:ttl)
  end

  def to_s
    "zone record lookup on #{@zone} for #{@name}"
  end

  private

  def response
    sandbox_url = 'https://api.sandbox.dnsimple.com'
    client = Dnsimple::Client.new(base_url: sandbox_url, access_token: @token)

    whoami = client.identity.whoami.data
    account_id = whoami.account.id

    filter = {}
    filter = { type: @type } if @type
    client.zones.records(account_id, @zone, filter: filter).data.select do |record|
      record.name == @name
    end.first
  end
end

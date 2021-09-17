token = input('dnsimple_token', description: 'The dnsimple API token')
test_domain = input('test_domain', description: 'The domain to test against the API')

describe dnsimple_zone(test_domain, 'cnamerecord', token, 'CNAME') do
  its('content') { should eq "testing.#{test_domain}" }
  its('ttl') { should eq 60 }
end

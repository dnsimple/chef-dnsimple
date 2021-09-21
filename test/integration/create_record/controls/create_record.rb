token = input('dnsimple_token', description: 'The dnsimple API token')
test_domain = input('test_domain', description: 'The domain to test against the API')

describe dnsimple_zone(test_domain, 'arecord', token, 'A') do
  its('content') { should eq '1.2.3.4' }
  its('ttl') { should eq 3600 }
end

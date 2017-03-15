token = attribute('dnsimple_token', description: 'The dnsimple API token')
test_domain = attribute('test_domain', description: 'The domain to test against the API')
describe dnsimple_zone(test_domain, name: 'arecord', token: token, type: 'A') do
  its('value') { should eq '1.2.3.4' }
  its('ttl') { should eq 3600 }
end

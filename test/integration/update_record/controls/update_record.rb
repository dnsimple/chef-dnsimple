token = attribute('dnsimple_token', description: 'The dnsimple API token')
test_domain = attribute('test_domain', description: 'The domain to test against the API')
describe dnsimple_zone(test_domain, name: 'cnamerecord', token: token, type: 'CNAME') do
  its('content') { should eq "testing.#{test_domain}" }
  its('ttl') { should eq 60 }
end

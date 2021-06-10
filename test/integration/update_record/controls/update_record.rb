token = input('dnsimple_token')
test_domain = input('test_domain')
describe dnsimple_zone(test_domain, name: 'cnamerecord', token: token, type: 'CNAME') do
  its('content') { should eq "testing.#{test_domain}" }
  its('ttl') { should eq 60 }
end

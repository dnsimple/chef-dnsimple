token = attribute('dnsimple_token')
describe dnsimple_zone('dnsimple.net', name: 'arecord', token: token, type: 'A') do
  its('value') { should eq '1.2.3.4' }
  its('ttl') { should eq '3600' }
end

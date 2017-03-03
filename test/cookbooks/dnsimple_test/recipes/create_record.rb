dnsimple_record 'arecord' do
  type 'A'
  content '1.2.3.4'
  ttl 3600
  domain 'dnsimple.net'
  access_token node['dnsimple']['access_token']
end

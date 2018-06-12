dnsimple_record 'arecord' do
  record_name 'arecord'
  type 'A'
  content '1.2.3.4'
  ttl 3600
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
end

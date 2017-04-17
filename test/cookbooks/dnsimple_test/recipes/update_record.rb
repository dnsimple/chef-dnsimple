dnsimple_record 'cname_test' do
  name 'cnamerecord'
  type 'CNAME'
  ttl 60
  content 'testing.dnsimple.net'
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :update
end

dnsimple_record 'cname_test' do
  record_name 'cnamerecord'
  type 'CNAME'
  ttl 60
  content "testing.#{node['dnsimple']['test_domain']}"
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :update
end

dnsimple_record 'cname2_test' do
  record_name 'cnamerecord2'
  type 'CNAME'
  ttl 60
  content "testing2.#{node['dnsimple']['test_domain']}"
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :update
end

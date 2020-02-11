dnsimple_record 'arecord_destroy' do
  record_name 'arecord'
  type 'A'
  content '1.2.3.4'
  ttl 3600
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :delete
end

dnsimple_record 'arecord2_destroy' do
  record_name 'arecord'
  type 'A'
  content '1.2.3.4'
  ttl 3600
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :delete
end

dnsimple_record 'cname_destroy' do
  record_name 'cnamerecord'
  type 'CNAME'
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :delete
end

dnsimple_record 'cname2_destroy' do
  record_name 'cnamerecord2'
  type 'CNAME'
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :delete
end

dnsimple_record 'cname_recreate' do
  record_name 'cnamerecord'
  type 'CNAME'
  ttl 3600
  content 'test.dnsimple.com'
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  action :create
end

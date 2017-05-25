dnsimple_certificate '/etc/apache2/ssl' do
  certificate_common_name 'www.example.com'
  domain node['dnsimple']['test_domain']
  access_token node['dnsimple']['access_token']
  base_url node['dnsimple']['base_url']
  mode '0755'
  owner 'web_admin'
  group 'web_admin'
end

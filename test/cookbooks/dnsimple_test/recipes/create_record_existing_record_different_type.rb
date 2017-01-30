dnsimple_record 'a_record' do
  name ''
  type 'A'
  content '1.1.1.1'
  domain 'example.com'
  access_token 'ABC123'
end

dnsimple_record 'ns_record' do
  name ''
  type 'NS'
  content '1.2.3.4'
  domain 'example.com'
  access_token 'ABC123'
end

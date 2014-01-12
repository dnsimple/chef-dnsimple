dnsimple_record 'name' do
  type 'A'
  content '1.1.1.1'
  domain 'example.com'
  username 'user@email.com'
  password 'my123password'
end

dnsimple_record '' do
  type 'A'
  content '1.1.1.1'
  domain 'example.com'
  username 'user@email.com'
  password 'my123password'
end

dnsimple_record 'existing' do
  type 'A'
  content '1.1.1.1'
  domain 'example.com'
  username 'user@email.com'
  password 'my123password'
end
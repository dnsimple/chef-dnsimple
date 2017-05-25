# TODO: verify with x509_certificate
describe file('/etc/apache2/ssl/dnsimple.xyz.crt') do
  its('content') { should match /-----BEGIN CERTIFICATE-----/ }
end
# TODO: verify with key_rsa
describe file('/etc/apache2/ssl/dnsimple.xyz.key') do
  its('content') { should match /-----BEGIN RSA PRIVATE KEY-----/ }
end

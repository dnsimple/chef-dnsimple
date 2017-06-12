describe x509_certificate('/etc/apache2/ssl/dnsimple.xyz.crt') do
  its('key_length') { should be 2048 }
  its('subject.CN') { should eq 'www.dnsimple.xyz' }
end

describe key_rsa('/etc/apache2/ssl/dnsimple.xyz.key') do
  it { should be_private }
  it { should be_public }
  its('key_length') { should be 2048 }
end

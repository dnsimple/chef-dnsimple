dnsimple_record "existing" do
  type "NS"
  content "2.2.2.2"
  domain "example.com"
  username "user@email.com"
  password "my123password"
  action :destroy
end

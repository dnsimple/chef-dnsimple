build_essential 'install tools' do
  compile_time true
end

chef_gem 'dnsimple' do
  version '~> 9'
  action :upgrade
end

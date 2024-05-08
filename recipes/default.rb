build_essential 'install tools' do
  compile_time true
end

gem_package 'dnsimple' do
  version '~> 9'
  action :upgrade
end

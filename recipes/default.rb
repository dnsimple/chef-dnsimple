build_essential 'install tools' do
  compile_time true
end

gem_package 'dnsimple' do
  # gem_binary('/usr/bin/gem')
  version '~> 9'
  action :upgrade
end

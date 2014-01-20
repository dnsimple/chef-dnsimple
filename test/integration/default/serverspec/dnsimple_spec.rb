require 'spec_helper'

case backend.check_os[:family]
when 'RedHat'
  packages = %w(libxml2-devel libxslt-devel)
else
  packages = %w(libxml2-dev libxslt1-dev)
end

packages.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe file('/opt/chef/embedded/bin/fog') do
  it { should be_file }
end

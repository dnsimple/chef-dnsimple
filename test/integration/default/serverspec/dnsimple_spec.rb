require 'spec_helper'

describe package('zlib1g-dev'), if: os[:family] == 'debian' do
  it { should be_installed }
end

describe file('/opt/chef/embedded/bin/fog') do
  it { should be_file }
end

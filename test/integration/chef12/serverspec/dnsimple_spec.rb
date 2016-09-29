require 'spec_helper'

describe 'dnsimple fog gem dependencies', if: ['debian', 'ubuntu'].include?(os[:family]) do
  it 'must be present' do
    expect(package('zlib1g-dev')).to be_installed
  end
end

describe 'dnsimple fog gem' do
  it 'must be installed in the embedded chef rubygems' do
    expect(command('/opt/chef/embedded/bin/gem list | grep dnsimple').stdout).to \
      match(/^fog-dnsimple/)
  end
end

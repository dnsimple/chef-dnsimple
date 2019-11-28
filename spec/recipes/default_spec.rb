require 'spec_helper'

describe 'default recipe on ubuntu 18.04' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '18.04') }
  let(:chef_run) { runner.converge('dnsimple::default') }

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end

require 'spec_helper'

describe 'dnsimple_test::create_record' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04', step_into: ['dnsimple_record']) }
  let(:chef_run) { runner.converge(described_recipe) }

  xit 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  xit 'creates a record called "name" type A' do
    expect(:chef_run).to create_dnsimple_record('name')
      .with(type: 'A', content: '1.1.1.1', domain: 'example.com', token: 'ABC')
  end
end

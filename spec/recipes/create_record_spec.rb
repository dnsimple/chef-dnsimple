require 'spec_helper'

describe 'dnsimple_test::create_record' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04', step_into: ['dnsimple_record']) }
  let(:chef_run) { runner.converge(described_recipe) }

  let(:dnsimple_record) { instance_double('dnsimple_record', name: name, content: '1.1.1.1', domain: 'example.com', access_token: 'ABC') }

  before do
    stub_authentication

    stub_request(:post, %r{/v2/1/zones/example.com/records$}).
      to_return(read_http_fixture("createZoneRecord/created.http"))
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'creates a record called "name" type A' do
    expect(chef_run).to create_dnsimple_record('name')
      .with(type: 'A', content: '1.1.1.1', domain: 'example.com', access_token: 'ABC123')
  end
end

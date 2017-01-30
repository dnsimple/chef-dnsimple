require 'spec_helper'

describe 'dnsimple_test::create_record' do
  include_context 'dnsimple'

  before do
    stub_request(:post, %r{/v2/1/zones/example.com/records$})
      .to_return(read_http_fixture('createZoneRecord/created.http'))
  end

  context 'with a no existing record with the same name' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a record called "name" type A' do
      expect(chef_run).to create_dnsimple_record('name')
        .with(type: 'A', content: '1.1.1.1', domain: 'example.com', access_token: 'ABC123')
    end
  end
end

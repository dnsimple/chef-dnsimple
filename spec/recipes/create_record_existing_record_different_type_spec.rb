require 'spec_helper'
require './libraries/helpers'

describe 'dnsimple_test::create_record_existing_record_different_type' do
  include_context 'dnsimple'

  let(:a_record_attributes) { { type: 'A', content: '1.1.1.1', domain: 'example.com' } }
  let(:ns_record_attributes) { { type: 'NS', content: '1.2.3.4', domain: 'example.com' } }

  before do
    stub_request(:post, %r{/v2/1/zones/example.com/records$})
      .to_return(read_http_fixture('createZoneRecord/created.http'))
  end

  context 'it calls dnsimple_record resource' do
    it 'creates an A record under the apex' do
      expect(chef_run).to create_dnsimple_record('a_record')
        .with(a_record_attributes.merge(access_token: 'ABC123'))
    end

    it 'creates a NS record called under the apex' do
      expect(chef_run).to create_dnsimple_record('ns_record')
        .with(ns_record_attributes.merge(access_token: 'ABC123'))
    end
  end

  context 'the dnsimple API' do
    it 'creates an A record under the apex' do
      expect(a_request(:post, 'dnsimple.com').with(body: a_record_attributes)).to have_been_made.once
    end

    it 'creates a NS record under the apex' do
      expect(a_request(:post, 'dnsimple.com').with(body: ns_record_attributes)).to have_been_made.once
    end
  end
end

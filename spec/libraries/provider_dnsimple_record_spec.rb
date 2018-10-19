require 'spec_helper'
require 'dnsimple'
require_relative '../../libraries/provider_dnsimple_record'
require_relative '../../libraries/resource_dnsimple_record'

describe Chef::Provider::DnsimpleRecord do
  before(:each) do
    @node = stub_node(platform: 'ubuntu', version: '14.04')
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)
    @new_resource = Chef::Resource::DnsimpleRecord.new('record_name')
    @current_resource = Chef::Resource::DnsimpleRecord.new('record_name')
    @provider = Chef::Provider::DnsimpleRecord.new(@new_resource, @run_context)
  end

  describe '#create_record' do
    before(:each) do
      @new_resource.access_token('this_is_a_token')
      @provider.dnsimple_client = client
      @new_resource.record_name = dns_record[:name]
      @new_resource.type = dns_record[:type]
      @new_resource.content = dns_record[:content]
      @new_resource.domain = dns_record[:domain]
      @provider.current_resource = @current_resource
    end

    let(:client) { instance_double(Dnsimple::Client, identity: identity, zones: zones) }
    let(:identity) { instance_double(Dnsimple::Client::Identity, whoami: response) }
    let(:response) { instance_double(Dnsimple::Response, data: data) }
    let(:data) { instance_double(Dnsimple::Struct::Whoami, account: account) }
    let(:account) { instance_double(Dnsimple::Struct::Account, id: 1) }
    let(:zones) { instance_double(Dnsimple::Client::ZonesService, all_zone_records: zone_records, create_zone_record: zone_record) }
    let(:zone_records) { instance_double(Dnsimple::CollectionResponse, data: [zone_record]) }
    let(:zone_record) { instance_double(Dnsimple::Struct::ZoneRecord, name: 'example_record') }
    let(:dns_record) do
      {
        name: 'test_record',
        domain: 'example.com',
        type: 'A',
        content: '1.2.3.4',
        ttl: 60,
      }
    end

    it 'updates the resource if the record does not exist' do
      @provider.run_action(:create)
      expect(@new_resource).to be_updated
    end

    it 'implements the load_current_resource interface' do
      expect { @provider.load_current_resource }.to_not raise_exception
    end

    context 'when it fails type validation' do
      it 'raises an exception' do
        expect { @new_resource.type = 'AA' }.to \
          raise_exception(Chef::Exceptions::ValidationFailed, /Option type must be equal to one of:/)
      end
    end

    context 'when it fails request validation' do
      before do
        allow(zones).to receive(:create_zone_record)
          .and_raise(Dnsimple::RequestError, request_error)
      end

      let(:zones) { instance_double(Dnsimple::Client::ZonesService) }
      let(:request_error) do
        double('request_error', headers: '', response: request_error_response)
      end
      let(:request_error_response) do
        double('response', code: '405', message: 'Method Not Allowed')
      end

      it 'raises exception which fails the chef run' do
        expect { @provider.create_record }.to \
          raise_exception(RuntimeError,
                          'DNSimple: Unable to complete create record request. Error: 405 Method Not Allowed')
      end
    end
  end

  describe '#delete_record' do
    before(:each) do
      @new_resource.access_token('this_is_a_token')
      @provider.dnsimple_client = client
      @new_resource.record_name = dns_record[:name]
      @new_resource.type = dns_record[:type]
      @new_resource.content = dns_record[:content]
      @new_resource.ttl = dns_record[:ttl]
      @new_resource.domain = dns_record_domain
      @provider.current_resource = @new_resource
      allow(zones).to receive(:delete_zone_record)
    end

    let(:client) { instance_double(Dnsimple::Client, identity: identity, zones: zones) }
    let(:identity) { instance_double(Dnsimple::Client::Identity, whoami: response) }
    let(:response) { instance_double(Dnsimple::Response, data: data) }
    let(:data) { instance_double(Dnsimple::Struct::Whoami, account: account) }
    let(:account) { instance_double(Dnsimple::Struct::Account, id: 1) }
    let(:zones) { instance_double(Dnsimple::Client::ZonesService, all_zone_records: zone_records) }
    let(:zone_records) { instance_double(Dnsimple::CollectionResponse, data: [zone_record]) }
    let(:zone_record) { instance_double(Dnsimple::Struct::ZoneRecord, **dns_record) }
    let(:dns_record_domain) { 'example.com' }
    let(:dns_record) do
      {
        id: 1234,
        name: 'test_record',
        type: 'A',
        content: '1.2.3.4',
        ttl: 60,
      }
    end

    context 'if the record exists' do
      it 'updates the resource' do
        @provider.run_action(:delete)
        expect(@new_resource).to be_updated
      end
    end

    context 'if the record does not exist' do
      before(:each) do
        @new_resource.record_name = 'not_this_record'
      end

      it 'does not update the resource' do
        @provider.run_action(:delete)
        expect(@new_resource).to_not be_updated
      end
    end

    context 'when it fails validation' do
      before do
        allow(zones).to receive(:delete_zone_record)
          .and_raise(Dnsimple::RequestError, request_error)
        allow(@provider).to receive(:existing_record_id).and_return(0)
      end

      let(:zones) { instance_double(Dnsimple::Client::ZonesService) }
      let(:request_error) do
        double('request_error', headers: '', response: request_error_response)
      end
      let(:request_error_response) do
        double('response', code: '405', message: 'Method Not Allowed')
      end

      it 'raises exception which fails the chef run' do
        expect { @provider.delete_record }.to \
          raise_exception(RuntimeError,
                          'DNSimple: Unable to complete create record request. Error: 405 Method Not Allowed')
      end
    end
  end

  describe '#update_record' do
    before(:each) do
      @new_resource.access_token('this_is_a_token')
      @provider.dnsimple_client = client
      @new_resource.record_name = dns_record[:name]
      @new_resource.type = dns_record[:type]
      @new_resource.content = dns_record[:content]
      @new_resource.priority = dns_record[:priority]
      @new_resource.ttl = new_ttl
      @new_resource.domain = dns_record_domain
      @provider.current_resource = @current_resource
    end

    let(:client) { instance_double(Dnsimple::Client, identity: identity, zones: zones) }
    let(:identity) { instance_double(Dnsimple::Client::Identity, whoami: response) }
    let(:response) { instance_double(Dnsimple::Response, data: data) }
    let(:data) { instance_double(Dnsimple::Struct::Whoami, account: account) }
    let(:account) { instance_double(Dnsimple::Struct::Account, id: 1) }
    let(:zones) { instance_double(Dnsimple::Client::ZonesService, all_zone_records: zone_records, update_zone_record: zone_record) }
    let(:zone_records) { instance_double(Dnsimple::CollectionResponse, data: [zone_record]) }
    let(:zone_record) { instance_double(Dnsimple::Struct::ZoneRecord, **dns_record) }
    let(:dns_record_domain) { 'example.com' }
    let(:dns_record) do
      {
        id: 1234,
        name: 'test_record',
        type: 'A',
        content: '1.2.3.4',
        priority: 0,
        ttl: 60,
      }
    end

    context 'if the resource exists' do
      context 'and the properites are different' do
        let(:new_ttl) { 120 }
        it 'updates the resource' do
          @provider.run_action(:update)
          expect(@new_resource).to be_updated
        end
      end

      context 'and the properites are the same' do
        let(:new_ttl) { dns_record[:ttl] }
        it 'does not update the resource' do
          @provider.run_action(:update)
          expect(@new_resource).to_not be_updated
        end
      end
    end
  end
end

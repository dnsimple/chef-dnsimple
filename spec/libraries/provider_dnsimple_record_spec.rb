require 'spec_helper'
require_relative '../../libraries/provider_dnsimple_record'
require_relative '../../libraries/resource_dnsimple_record'

describe Chef::Provider::DnsimpleRecord do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)
    @new_resource = Chef::Resource::DnsimpleRecord.new('record_name')
    @current_resource = Chef::Resource::DnsimpleRecord.new('record_name')
    @provider = Chef::Provider::DnsimpleRecord.new(@new_resource, @run_context)
    @provider.current_resource = @current_resource
  end

  describe '#record' do
    before(:each) do
      @new_resource.access_token('this_is_a_token')
      # allow(@provider.dnsimple_client).to receive(:
    end

    it 'returns record object if record name matches' do
      @new_resource.name('example_record')
      expect(@provider.record.name).to eq('example_record')
    end
  end
end

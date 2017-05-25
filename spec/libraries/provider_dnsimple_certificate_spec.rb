require 'spec_helper'
require 'dnsimple'
require_relative '../../libraries/provider_dnsimple_certificate'
require_relative '../../libraries/resource_dnsimple_certificate'

describe Chef::Provider::DnsimpleCertificate do
  before(:each) do
    @node = stub_node(platform: 'ubuntu', version: '14.04')
    @events = Chef::EventDispatch::Dispatcher.new
    @new_resource = Chef::Resource::DnsimpleCertificate.new('certificate_id')
    @run_context = Chef::RunContext.new(@node, {}, @events)
    @provider = Chef::Provider::DnsimpleCertificate.new(@new_resource, @run_context)
  end

  describe '#install' do
    it 'does something' do
      @provider.run_action(:install)
    end

    it 'implements the load_current_resource interface' do
      expect { @provider.load_current_resource }.to_not raise_exception
    end
  end
end

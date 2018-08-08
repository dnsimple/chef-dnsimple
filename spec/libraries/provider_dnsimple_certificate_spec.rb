require 'spec_helper'
require 'dnsimple'
require 'date'
require_relative '../../libraries/provider_dnsimple_certificate'
require_relative '../../libraries/resource_dnsimple_certificate'

describe Chef::Provider::DnsimpleCertificate do
  before(:each) do
    @node = stub_node(platform: 'ubuntu', version: '14.04')
    @events = Chef::EventDispatch::Dispatcher.new
    @new_resource = Chef::Resource::DnsimpleCertificate.new('/path/to/certificate.crt')
    @run_context = Chef::RunContext.new(@node, {}, @events)
    @current_resource = Chef::Resource::DnsimpleCertificate.new('/path/to/certificate.crt')
    @provider = Chef::Provider::DnsimpleCertificate.new(@new_resource, @run_context)
  end

  describe '#install' do
    before(:each) do
      @new_resource.access_token('this_is_a_token')
      @provider.dnsimple_client = client
      @new_resource.common_name = certificate_data[:common_name]
      @new_resource.install_path = '/etc/nginx/ssl'
      @new_resource.domain = 'example.com'
      @provider.current_resource = @current_resource
    end

    let(:client) { instance_double(Dnsimple::Client, identity: identity, certificates: certificates) }
    let(:identity) { instance_double(Dnsimple::Client::Identity, whoami: whoami_response) }
    let(:whoami_response) { instance_double(Dnsimple::Response, data: data) }
    let(:data) { instance_double(Dnsimple::Struct::Whoami, account: account) }
    let(:account) { instance_double(Dnsimple::Struct::Account, id: 1) }
    let(:certificates) { instance_double(Dnsimple::Client::Certificates, all_certificates: certificate_list, download_certificate: certificate_bundle_response, certificate_private_key: private_key_bundle_response) }
    let(:certificate_list) { instance_double(Dnsimple::CollectionResponse, data: [certificate]) }
    let(:certificate) { instance_double(Dnsimple::Struct::Certificate, id: certificate_data[:id], common_name: certificate_data[:common_name], expires_on: certificate_data[:expires_on], state: 'issued') }
    let(:certificate_bundle_response) { instance_double(Dnsimple::Response, data: certificate_bundle) }
    let(:certificate_bundle) { instance_double(Dnsimple::Struct::CertificateBundle, server: 'server-pem', chain: ['chain-pem']) }
    let(:private_key_bundle_response) { instance_double(Dnsimple::Response, data: private_key_bundle) }
    let(:private_key_bundle) { instance_double(Dnsimple::Struct::CertificateBundle, private_key: 'private-key-pem') }
    let(:certificate_data) do
      {
        id: 1,
        common_name: 'www.example.com',
        expires_on: next_year,
      }
    end
    let(:next_year) { Date.today.next_day(365).strftime('%F') }

    context 'if the certificate exists' do
      it 'installs the certificate' do
        @provider.run_action(:install)
        expect(@new_resource).to be_updated
      end
    end

    it 'implements the load_current_resource interface' do
      expect { @provider.load_current_resource }.to_not raise_exception
    end
  end
end

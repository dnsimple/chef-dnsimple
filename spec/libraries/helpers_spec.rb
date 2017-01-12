require 'spec_helper'

RSpec.describe DNSimpleCookbook do
  class DummyClass < Chef::Node
    include DNSimpleCookbook::Helpers
  end
  subject { DummyClass.new }

  describe '#dnsimple_client' do
    before do
      allow(subject).to receive(:dnsimple_gem_version).and_return(:version)
      allow(subject).to receive(:dnsimple_access_token).and_return(:access_token)
    end

    let(:version) { '' }
    let(:access_token) { '' }

    it 'returns a client' do
      expect(subject.dnsimple_client).to be_instance_of(Dnsimple::Client)
    end
  end

  describe '#dnsimple_client_account_id' do
    before do
      allow(subject).to receive(:dnsimple_gem_version).and_return(:version)
      allow(subject).to receive(:dnsimple_access_token).and_return(:access_token)
      allow(subject).to receive(:dnsimple_log_error)
      stub_request(:any, 'https://api.dnsimple.com/v2/whoami').to_return(read_http_fixture('success-account.http'))
    end

    it 'returns an account id' do
      expect(subject.dnsimple_client_account.data).to be_a_kind_of(Fixnum)
    end
  end
end

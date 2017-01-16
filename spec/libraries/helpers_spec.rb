require 'spec_helper'
require './libraries/helpers.rb'

RSpec.describe DNSimpleCookbook::Helpers do
  include described_class

  describe '#dnsimple_client' do
    before do
      allow_any_instance_of(described_class).to receive(:dnsimple_gem_version).and_return(version)
      allow_any_instance_of(described_class).to receive(:dnsimple_access_token).and_return(access_token)
    end

    let(:version) { '' }
    let(:access_token) { '' }

    it 'returns a client' do
      expect(dnsimple_client).to be_instance_of(Dnsimple::Client)
    end
  end

  describe '#dnsimple_client_account' do
    before do
      allow_any_instance_of(described_class).to receive(:dnsimple_client).and_return(client)
      allow(client).to receive(:identity).and_return(identity)
      allow(identity).to receive(:whoami).and_raise(Dnsimple::AuthenticationFailed)
    end

    let(:client) { double('client') }
    let(:identity) { double('identity') }

    context 'when authentication fails' do
      it 'raises a standard error to stop the chef run' do
        expect { dnsimple_client_account }.to \
          raise_error('Authentication failed. Please check your access token')
      end
    end
  end

  describe '#dnsimple_client_account_id' do
    before do
      allow_any_instance_of(described_class).to receive(:dnsimple_client_account).and_return(client_account)
      allow(client_account).to receive(:data).and_return(data)
      allow(data).to receive(:account).and_return(account)
    end

    let(:client_account) { double('client_account') }
    let(:data) { double('data') }

    context 'when account id is present' do
      before do
        allow(account).to receive(:id).and_return(account_id)
      end

      let(:account_id) { 1234 }
      let(:account) { double('account') }

      it 'returns an account id' do
        expect(dnsimple_client_account_id).to be_a_kind_of(Integer)
      end
    end

    context 'when account id is not present' do
      let(:account) { nil }

      it 'raises an error for using a user token and not an account token' do
        expect { dnsimple_client_account_id }.to raise_error('Cannot find account id, please make sure you provide an account token and not a user token. See README for more information.')
      end
    end
  end
end

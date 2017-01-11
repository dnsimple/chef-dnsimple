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
      expect(subject.dnsimple_client.identity.whoami).to_not raise_error
    end
  end
end

require 'spec_helper'

RSpec.describe DNSimpleCookbook do
  class DummyClass < Chef::Node
    include DNSimpleCookbook::Helpers
  end
  subject { DummyClass.new }

  describe '#dnsimple_api' do
    before do
      allow(subject).to receive(:node).and_return(node_data)
    end

    let(:node_data) do
      {
        'dnsimple' => {
          'version' => nil
        }
      }
    end

    it 'returns a client' do
      expect(subject.dnsimple_api.identity.whoami).to_not raise_error
    end
  end
end

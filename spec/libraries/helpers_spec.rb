require 'spec_helper'

RSpec.describe DNSimpleCookbook do
  class DummyClass < Chef::Node
    include DNSimpleCookbook::Helpers
  end
  subject { DummyClass.new }

  describe '#dnsimple_api' do
    it 'returns a client' do
      expect(subject.dnsimple_api).to be_true
    end
  end
end

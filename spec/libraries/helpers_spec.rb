require 'spec_helper'

RSpec.describe DNSimpleCookbook do
  class DummyClass < Chef::Node
    include DNSimpleCookbook::Helpers
  end
  subject { DummyClass.new }

  describe '#dnsimple_data_center' do
    before do
      allow(subject).to receive(:tags).and_return(tags)
    end
  end
end

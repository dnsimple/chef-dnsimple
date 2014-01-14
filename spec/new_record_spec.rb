require 'spec_helper'
require 'fog/dnsimple'

describe 'dnsimple_test::new_record' do
  include_context 'dnsimple'

  context 'with a no existing record with the same name' do
    it 'creates record' do
      chef_run
      record = dnsimple_zone.records.detect { |r| r.name == 'name' }
      expect(record.name).to eq 'name'
      expect(record.type).to eq 'A'
      expect(record.value).to eq '1.1.1.1'
    end
  end
end
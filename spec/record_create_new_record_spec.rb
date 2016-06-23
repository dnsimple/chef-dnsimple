require 'spec_helper'
require 'fog/dnsimple'

describe 'dnsimple_test::create_record' do
  include_context 'dnsimple'

  context 'with a no existing record with the same name' do
    it 'creates record' do
      chef_run

      dnsimple_resource = chef_run.find_resource('dnsimple_record', 'name')
      expect(dnsimple_resource.updated_by_last_action?).to be_truthy

      record = dnsimple_zone.records.detect { |r| r.name == 'name' }
      expect(record.name).to eq 'name'
      expect(record.type).to eq 'A'
      expect(record.value).to eq '1.1.1.1'
    end
  end
end

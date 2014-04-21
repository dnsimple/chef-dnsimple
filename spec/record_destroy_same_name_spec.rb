require 'spec_helper'
require 'fog/dnsimple'

describe 'dnsimple_test::destroy_record_same_name' do
  include_context 'dnsimple'

  context 'with record with same name but different type' do
    it 'does not perform any operation' do
      create_record_to_update

      dnsimple_resource = chef_run.find_resource('dnsimple_record', 'existing')
      expect(dnsimple_resource.updated_by_last_action?).to be_false
      expect(Fog::DNS::DNSimple::Record).not_to receive(:destroy)

      record = dnsimple_zone.records.find { |r| r.name == 'existing' }
      expect(record.value).to eq '2.2.2.2'
    end
  end
end

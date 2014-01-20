require 'spec_helper'
require 'fog/dnsimple'

describe 'dnsimple_test::destroy_record_same_name_and_type' do
  include_context 'dnsimple'

  context 'with record with same name and type' do
    it 'deletes record' do
      create_record_to_update

      dnsimple_resource = chef_run.find_resource('dnsimple_record', 'existing')
      expect(dnsimple_resource.updated_by_last_action?).to be_true

      record = dnsimple_zone.records.detect { |r| r.name == 'existing' }
      expect(record).to be_nil
    end
  end
end
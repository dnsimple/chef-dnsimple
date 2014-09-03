require 'spec_helper'
require 'fog/dnsimple'

describe 'dnsimple_test::create_same_record_with_two_values' do
  include_context 'dnsimple'

  context 'with existing record with the same name and content' do
    it 'keeps the two records untouched' do
      create_record_with_multiple_values
      chef_run
      final_records = ['3.3.3.3', '2.2.2.2']
      records = dnsimple_zone.records.select { |r| r.name == 'multiple' }
      records.each do |record|
        expect(record.name).to be
        expect(record.type).to eq 'A'
        expect(record.value).to eq(final_records.delete(record.value))
        expect(Fog::DNS::DNSimple::Record).not_to receive(:destroy)
      end
      expect(final_records).to be_empty
      dnsimple_resource = chef_run.find_resource('dnsimple_record', 'multiple')
      expect(dnsimple_resource.updated_by_last_action?).to eq(false)
    end
  end
end

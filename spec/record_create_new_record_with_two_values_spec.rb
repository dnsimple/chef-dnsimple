require "spec_helper"
require "fog/dnsimple"

describe "dnsimple_test::create_record_with_two_values" do
  include_context "dnsimple"

  context "with no record with the same name" do
    it "creates two records for the same name" do
      chef_run
      final_records = ["1.1.1.1", "2.2.2.2"]
      records = dnsimple_zone.records.select { |r| r.name == "multiple" }
      records.each do |record|
        expect(record.name).to be
        expect(record.type).to eq "A"
        expect(record.value).to eq(final_records.delete(record.value))
      end
      expect(final_records).to be_empty
      expect(Fog::DNS::DNSimple::Record).not_to receive(:destroy)
    end
  end
end

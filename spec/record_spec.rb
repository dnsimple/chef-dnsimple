require 'spec_helper'

describe 'dnsimple_test::record' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(:step_into => ['dnsimple_record'])
    runner.converge(described_recipe)
  end
  before do
    Fog.mock!
    Fog::Mock.reset
    create_domain_data
  end

  context 'with a no existing record with the same name' do
    it 'creates record' do
      chef_run
      record = dnsimple_zone.records.detect { |r| r.name == 'name' }
      expect(record.name).to eq 'name'
      expect(record.type).to eq 'A'
      expect(record.value).to eq '1.1.1.1'
    end
  end

  context 'with an existing record with the same name and ttl' do
    context 'and different type' do
      it 'does not delete existing record and creates new record' do
        chef_run
        expected_records = {
          'NS' => '1.2.3.4',
          'A' => '1.1.1.1'
        }

        records = dnsimple_zone.records.select { |r| r.name == '' }
        expect(records.size).to eq 2

        records.each do |record|
          expect(record.value).to eq expected_records[record.type]
          expected_records.delete(record.type)
        end
        expect(expected_records).to be_empty
      end
    end

    context 'and same type' do
      it 'deletes existing record and creates new record' do
        chef_run

        record = dnsimple_zone.records.detect { |r| r.name == 'existing' }
        expect(record.value).to eq '1.1.1.1'
      end
    end
  end

  def dnsimple_client
    Fog::DNS.new(provider: "DNSimple", dnsimple_email: 'user@email.com', dnsimple_password: 'my123password')
  end

  def dnsimple_zone
    dnsimple_client.zones.get('example.com')
  end

  def create_domain_data
    dnsimple_client.zones.create({domain: 'example.com'})
    dnsimple_zone.records.create({name: '', type: 'NS', value: '1.2.3.4', ttl: 3600})
    dnsimple_zone.records.create({name: 'existing', type: 'A', value: '2.2.2.2', ttl: 3600})
  end
end
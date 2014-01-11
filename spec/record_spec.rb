require 'spec_helper'

class ChefSpec::Runner
  def append(recipe)
    runner = Chef::Runner.new(recipe.run_context)
    runner.converge
    self
  end
end

describe 'chef-dnsimple::record' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(:step_into => ['chef_dnsimple_record'])
    runner.converge
  end
  before do
    Fog.mock!
    Fog::Mock.reset
    create_domain_data
  end

  context 'with a no existing record with the same name' do
    it 'creates record' do
      chef_run_with_recipe('name', 'A', '1.1.1.1')
      record = dnsimple_zone.records.detect { |r| r.name == 'name' }
      expect(record.name).to eq 'name'
      expect(record.type).to eq 'A'
      expect(record.value).to eq '1.1.1.1'
    end
  end

  context 'with an existing record with the same name and ttl' do
    context 'and different type' do
      it 'does not delete existing record and creates new record' do
        chef_run_with_recipe('', 'A', '1.1.1.1')
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
        chef_run_with_recipe('existing', 'A', '1.1.1.1')

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

  def chef_run_with_recipe(record_name, record_type, record_value)
    recipe = fake_recipe(chef_run, 'dnsimple_spec', 'record') do
      chef_dnsimple_record record_name do
        type record_type
        content record_value
        domain 'example.com'
        username 'user@email.com'
        password 'my123password'
      end
    end
    chef_run.append(recipe)
  end

  def fake_recipe(run, cookbook_name, recipe_name, &block)
    recipe = Chef::Recipe.new(cookbook_name, recipe_name, run.run_context)
    recipe.instance_eval(&block)
  end
end
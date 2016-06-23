shared_context 'dnsimple' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(step_into: ['dnsimple_record'])
    runner.converge(described_recipe)
  end
  before(:all) do
    Fog.mock!
  end
  before do
    create_domain_data
  end
  after do
    Fog::Mock.reset
  end

  def dnsimple_client
    Fog::DNS.new(provider: 'DNSimple', dnsimple_email: 'user@email.com',
                 dnsimple_password: 'my123password', dnsimple_token: 'abc1234')
  end

  def dnsimple_zone
    dnsimple_client.zones.get('example.com')
  end

  def create_record_to_update
    dnsimple_zone.records.create(name: 'existing', type: 'A', value: '2.2.2.2', ttl: 3600)
  end

  def create_record_with_multiple_values
    dnsimple_zone.records.create(name: 'multiple', type: 'A', value: '3.3.3.3', ttl: 3600)
    dnsimple_zone.records.create(name: 'multiple', type: 'A', value: '2.2.2.2', ttl: 3600)
  end

  def create_record_to_do_not_delete
    dnsimple_zone.records.create(name: '', type: 'NS', value: '1.2.3.4', ttl: 3600)
  end

  def create_domain_data
    dnsimple_client.zones.create(domain: 'example.com')
  end
end

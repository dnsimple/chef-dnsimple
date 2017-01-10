shared_context 'dnsimple' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(step_into: ['dnsimple_record'])
    runner.converge(described_recipe)
  end

  before do
    create_domain_data
  end

  def dnsimple_client
    Dnsimple::Client.new(access_token: 'token')
  end

  def dnsimple_account_id
    dnsimple_client.identity.whoami.data.account.id
  end

  def create_record_to_update
    dnsimple_client.zones.create_record(
      dnsimple_account_id, 'example.com',
      name: 'existing', type: 'A', content: '2.2.2.2', ttl: 3600)
  end

  def create_record_with_multiple_values
    dnsimple_client.zones.create_record(
      dnsimple_account_id, 'example.com',
      name: 'multiple', type: 'A', content: '3.3.3.3', ttl: 3600)
    dnsimple_client.zones.create_record(
      dnsimple_account_id, 'example.com',
      name: 'multiple', type: 'A', content: '2.2.2.2', ttl: 3600)
  end

  def create_record_to_do_not_delete
    dnsimple_client.zones.create_record(
      dnsimple_account_id, 'example.com',
      name: '', type: 'NS', content: '1.2.3.4', ttl: 3600)
  end

  def create_domain_data
    dnsimple_client.create_domain(dnsimple_account_id, 'example.com')
  end
end

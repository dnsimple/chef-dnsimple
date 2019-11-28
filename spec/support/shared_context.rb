shared_context 'dnsimple' do
  let(:runner) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '18.04', step_into: ['dnsimple_record']) }
  let(:chef_run) { runner.converge(described_recipe) }
end

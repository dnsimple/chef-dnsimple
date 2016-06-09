require_relative 'spec_helper'

describe 'dnsimple::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it "installs fog chef_gem" do
    expect(chef_run).to install_chef_gem "dnsimple"
  end
end

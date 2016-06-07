require_relative "spec_helper"

describe "dnsimple::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it "installs fog chef_gem" do
    expect(chef_run).to install_chef_gem "fog"
  end

  context "when on the debian platform family" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: "ubuntu").converge(described_recipe)
    end

    it "installs zlib1g-dev package" do
      expect(chef_run).to install_package "zlib1g-dev"
    end
  end
end

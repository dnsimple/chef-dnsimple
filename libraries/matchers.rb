if defined?(ChefSpec)
  def create_dnsimple_record(name)
    ChefSpec::Matchers::ResourceMatcher.new(:dnsimple_record, :create, name)
  end

  def delete_dnsimple_record(name)
    ChefSpec::Matchers::ResourceMatcher.new(:dnsimple_record, :delete, name)
  end
end

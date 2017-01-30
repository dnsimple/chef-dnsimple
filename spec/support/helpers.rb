module RSpecSupportHelpers

  def http_fixture(*names)
    File.join(SPEC_ROOT, "fixtures.http", *names)
  end

  def read_http_fixture(*names)
    File.read(http_fixture(*names))
  end

  def stub_authentication
    stub_request(:get, %r{/v2/whoami$}).
    to_return(read_http_fixture("whoami/success-account.http"))
  end

end

RSpec.configure do |config|
  config.include RSpecSupportHelpers
end
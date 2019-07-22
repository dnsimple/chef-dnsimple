# Testing

## Requirements

You will need the following;

* Docker Desktop
* Chef-Workstation
  * The dnsimple gem installed into Chef-Workstation with `chef gem install dnsimple`
* A [DNSimple Sandbox account](https://developer.dnsimple.com/sandbox/#testing-subscriptions)
  * A test domain created in sandbox set to your environment varible `DNSIMPLE_TEST_DOMAIN=domain.com`
  * Your sandbox API key saved to `DNSIMPLE_ACCESS_TOKEN=token`

### Running tests

* run `chef exec rake quick` for unit and style tests.
* run `chef exec rake kitchen` for kitchen tests
* `chef exec rake` will run all tests

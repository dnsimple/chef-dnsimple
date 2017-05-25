## Testing

To run the tests across all platforms, you want to grab the latest [ChefDK][]
install [VirtualBox][], [Vagrant][], and the following gems into your ChefDK:

* [stove][]
* [dnsimple][dnsimple-gem]

Then run `chef exec rake quick` for unit and style tests.

Use `chef exec rake` for all unit, style, and kitchen tests. Before doing so,
you need to sign up for a [Sandbox API account][sandbox] and generate an account
access token. You'll want to define it as an env var for test kitchen under
`DNSIMPLE_ACCESS_TOKEN`. So you can execute the command like this:

`DNSIMPLE_ACCESS_TOKEN=mytoken chef exec kitchen test`

You will also want to edit the `.kitchen.yml` file to adjust the `test_domain`
attributes to test a domain you create under your sandbox account.

To test regional records, you will want to upgrade the account plan to one that
supports the regional records feature.

To test certificate installation, you will need to issue a certificate in sandbox
first.

[ChefDK]: https://downloads.chef.io/chef-dk/
[VirtualBox]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: https://www.vagrantup.com/downloads.html
[sandbox]: https://developer.dnsimple.com/sandbox/#testing-subscriptions
[stove]: https://rubygems.org/gems/stove
[dnsimple-gem]: https://rubygems.org/gems/dnsimple

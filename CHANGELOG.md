# 1.3.4 / 2016-09-30

## Bug Fixes

* Replaced fog gem with a more specific fog-dnsimple gem. The API was extracted
  from the fog-core to simplify the base fog gem. What does this mean for you?
  There is no fog binary to use and the install is much smaller and faster than
  before, but with the same API signatures so this is a simple patch versus a
  breaking change release.

# 1.3.3 / 2016-06-27

## Bug fixes
* fixed suite names in kitchen

## Enhancement
* update testing documentation
* add kitchen into travis

# 1.3.2 / 2016-06-24

## Enhancement
* use cookstyle instead of chefstyle
* change library to use a class instance var instead of a class var

# 1.3.1 / 2016-06-10

## Bug Fixes

* Clarified the API Token portion of the README because of the upcoming API v2
  changes which have created both User and API tokens.

# 1.3.0 / 2016-06-10

## Enhancement

* Add support for API tokens which are the preferred API authentication method
  per the developer documentation. You must use domain tokens and not account
  based tokens. Support for both will be in the 2.x series of this cookbook.

## Deprecations

* You will get a warning now when using the username/password authentcation
  method with the LWRP as it will no longer be supported in the future release.
  If you have two-factor authentication enabled on your account, this method
  will not work either (which is also why it's going away).

# 1.2.0 / 2016-06-09

This will be the last non-bugfix version to use the fog gem and the v1 API.

## Bug Fixes

* Nokogiri now bundles libxml2 and libxslt making life somewhat easier for us
  and simplifying the default recipe, which was broken at the time. We've
  removed the dependency package installs with exception of zlibg1 for debian
  family platforms.
* Change chef_gem resource usage to not break in chef 12 or chef 11

## Test suite

* Resolved all foodcritic warnings with the newest foodcritic
* Resolved the chefspec and compile\_time warnings
* change to chefstyle
* Clean up and simplify tests with rake
* fix up travis tests

# 1.1.0 / 2015-03-06

## Breaking Changes

* Changed fog version number to nil, which causes it to install the latest
  version. This _will_ cause a conflict with Chef 12.1.0 and is currently
  a known issue. If you are going to set a version, then it is suggested
  to use _at least_ 1.20.0, which contains the updated api endpoint.

## Enhancements

* Added support for multiple content values in a record via arrays
  ([#20][] by [@josacar][])
## Bug Fixes

* Use latest Fog gem release, not the master git branch.
* Unpinned build-essential to resolve version constraint issues
  ([#22][] by [@martinb3][])

## Testing

* Updated and cleaned up test suite to be RSpec 3.0 compatible (truthy and falsy)
* Upgraded to Berkshelf 3.0
* Upgraded to ChefSpec 4.0 which officially makes this cookbook Chef 11.x or higher
  compatible. Noted in the README.

## Legal

* Cleaned up and updated copyrights in the licensing notices

[#22]: https://github.com/aetrion/chef-dnsimple/pull/22
[#20]: https://github.com/aetrion/chef-dnsimple/pull/20
[@martinb3]: https://github.com/martinb3
[@josacar]: https://github.com/josacar

# 1.0.1 / Unreleased

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

# Change Log

## [v2.1.1](https://github.com/dnsimple/chef-dnsimple/tree/v2.1.1) (2018-03-21)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v2.1.0...v2.1.1)

**Fixed bugs:**

- Running integration tests with custom domain fails [\#52](https://github.com/dnsimple/chef-dnsimple/issues/52)

**Merged pull requests:**

- Bugfix: Correctly validate the test domain in Inspec [\#55](https://github.com/dnsimple/chef-dnsimple/pull/55) ([martinisoft](https://github.com/martinisoft))
- Bugfix: AAAA record validation in dnsimple\_record resource [\#54](https://github.com/dnsimple/chef-dnsimple/pull/54) ([martinisoft](https://github.com/martinisoft))
- Add all\_certificates endpoint and fix certificates spec [\#53](https://github.com/dnsimple/chef-dnsimple/pull/53) ([martinisoft](https://github.com/martinisoft))
- Use latest versions of images for testing [\#51](https://github.com/dnsimple/chef-dnsimple/pull/51) ([martinisoft](https://github.com/martinisoft))
- Testing to chef 13 [\#50](https://github.com/dnsimple/chef-dnsimple/pull/50) ([onlyhavecans](https://github.com/onlyhavecans))

## [v2.1.0](https://github.com/dnsimple/chef-dnsimple/tree/v2.1.0) (2017-06-26)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v2.0.1...v2.1.0)

**Merged pull requests:**

- Add Docs for dnsimple\_certificate [\#49](https://github.com/dnsimple/chef-dnsimple/pull/49) ([onlyhavecans](https://github.com/onlyhavecans))
- Feature/install certificate [\#48](https://github.com/dnsimple/chef-dnsimple/pull/48) ([aeden](https://github.com/aeden))

## [v2.0.1](https://github.com/dnsimple/chef-dnsimple/tree/v2.0.1) (2017-05-18)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v2.0.0...v2.0.1)

**Fixed bugs:**

- Re-release 2.0.0 with updated Stove [\#47](https://github.com/dnsimple/chef-dnsimple/issues/47)

## [v2.0.0](https://github.com/dnsimple/chef-dnsimple/tree/v2.0.0) (2017-04-24)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v1.3.4...v2.0.0)

**Fixed bugs:**

- Force apt in the run list for ubuntu platforms [\#41](https://github.com/dnsimple/chef-dnsimple/pull/41) ([martinisoft](https://github.com/martinisoft))

**Closed issues:**

- Chef 11 needs compat resources [\#45](https://github.com/dnsimple/chef-dnsimple/issues/45)

**Merged pull requests:**

- Replace fog with dnsimple and rewrite to Chef 12.5+ resource [\#46](https://github.com/dnsimple/chef-dnsimple/pull/46) ([martinisoft](https://github.com/martinisoft))
- It seems that Chef 11 and Compat resources no go [\#44](https://github.com/dnsimple/chef-dnsimple/pull/44) ([jjasghar](https://github.com/jjasghar))
- Update README.md [\#43](https://github.com/dnsimple/chef-dnsimple/pull/43) ([jjasghar](https://github.com/jjasghar))

## [v1.3.4](https://github.com/dnsimple/chef-dnsimple/tree/v1.3.4) (2016-09-30)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v1.3.3...v1.3.4)

**Merged pull requests:**

- Swap fog gem for fog-dnsimple [\#42](https://github.com/dnsimple/chef-dnsimple/pull/42) ([martinisoft](https://github.com/martinisoft))

## [v1.3.3](https://github.com/dnsimple/chef-dnsimple/tree/v1.3.3) (2016-06-27)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v1.3.2...v1.3.3)

**Fixed bugs:**

- getchef.com isn't our site anymore [\#37](https://github.com/dnsimple/chef-dnsimple/pull/37) ([jjasghar](https://github.com/jjasghar))

**Merged pull requests:**

- Update Travis-CI builds to use Integration [\#40](https://github.com/dnsimple/chef-dnsimple/pull/40) ([martinisoft](https://github.com/martinisoft))
- Fix test suite names for kitchen [\#39](https://github.com/dnsimple/chef-dnsimple/pull/39) ([onlyhavecans](https://github.com/onlyhavecans))
- Remove 16.04 due to bento issues. Update Documents [\#38](https://github.com/dnsimple/chef-dnsimple/pull/38) ([onlyhavecans](https://github.com/onlyhavecans))

## [v1.3.2](https://github.com/dnsimple/chef-dnsimple/tree/v1.3.2) (2016-06-24)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v1.3.1...v1.3.2)

**Merged pull requests:**

- Move to cookstyle over chefstyle [\#36](https://github.com/dnsimple/chef-dnsimple/pull/36) ([onlyhavecans](https://github.com/onlyhavecans))

## [v1.3.1](https://github.com/dnsimple/chef-dnsimple/tree/v1.3.1) (2016-06-10)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v1.3.0...v1.3.1)

**Merged pull requests:**

- Update documentation with a correction for the token usage [\#35](https://github.com/dnsimple/chef-dnsimple/pull/35) ([martinisoft](https://github.com/martinisoft))

## [v1.3.0](https://github.com/dnsimple/chef-dnsimple/tree/v1.3.0) (2016-06-10)
[Full Changelog](https://github.com/dnsimple/chef-dnsimple/compare/v1.2.0...v1.3.0)

**Fixed bugs:**

- DNSimple API authentication [\#24](https://github.com/dnsimple/chef-dnsimple/issues/24)

**Merged pull requests:**

- Support api tokens [\#33](https://github.com/dnsimple/chef-dnsimple/pull/33) ([martinisoft](https://github.com/martinisoft))

## [v1.2.0](https://github.com/dnsimple/chef-dnsimple/tree/v1.2.0) (2016-06-10)
**Fixed bugs:**

- Fix ChefSpec Deprecation Warning [\#25](https://github.com/dnsimple/chef-dnsimple/issues/25)
- centos-65 requires patch utility due to nokogiri, only build-essential ~\> 2.0.4 installs patch [\#21](https://github.com/dnsimple/chef-dnsimple/issues/21)
- Fix converging in modern chef 11 and chef 12 [\#32](https://github.com/dnsimple/chef-dnsimple/pull/32) ([onlyhavecans](https://github.com/onlyhavecans))
- Cleanup testing [\#31](https://github.com/dnsimple/chef-dnsimple/pull/31) ([martinisoft](https://github.com/martinisoft))

**Closed issues:**

- Use Fog DNSimple API Auth [\#27](https://github.com/dnsimple/chef-dnsimple/issues/27)
- Ubuntu 14.04 package requirement [\#23](https://github.com/dnsimple/chef-dnsimple/issues/23)
- Should have option to gracefully handle existing A record for CNAME create [\#18](https://github.com/dnsimple/chef-dnsimple/issues/18)
- Release a new version to Chef Community site [\#11](https://github.com/dnsimple/chef-dnsimple/issues/11)
- Add Test Kitchen [\#10](https://github.com/dnsimple/chef-dnsimple/issues/10)
- Cookbook removes undesired records [\#9](https://github.com/dnsimple/chef-dnsimple/issues/9)
- Should depend on 'build-essential' [\#7](https://github.com/dnsimple/chef-dnsimple/issues/7)
- LWRP should use load\_current\_resource [\#2](https://github.com/dnsimple/chef-dnsimple/issues/2)

**Merged pull requests:**

- Update build status and metadata [\#30](https://github.com/dnsimple/chef-dnsimple/pull/30) ([martinisoft](https://github.com/martinisoft))
- Unpin build-essential, blocks many popular cookbooks from use [\#22](https://github.com/dnsimple/chef-dnsimple/pull/22) ([martinb3](https://github.com/martinb3))
- Support creating record with multiple content values [\#20](https://github.com/dnsimple/chef-dnsimple/pull/20) ([josacar](https://github.com/josacar))
- Use load\_current\_resource in lwrp [\#15](https://github.com/dnsimple/chef-dnsimple/pull/15) ([josacar](https://github.com/josacar))
- Integrate Test Kitchen [\#14](https://github.com/dnsimple/chef-dnsimple/pull/14) ([dje](https://github.com/dje))
- Configure attributes for ohai to workaround empty node.platform\_family [\#13](https://github.com/dnsimple/chef-dnsimple/pull/13) ([josacar](https://github.com/josacar))
- Avoid removing records with different type on create [\#12](https://github.com/dnsimple/chef-dnsimple/pull/12) ([josacar](https://github.com/josacar))
- Build Essential Dependancy [\#8](https://github.com/dnsimple/chef-dnsimple/pull/8) ([ichilton](https://github.com/ichilton))
- add platform support for rhel platforms and expand coverage for more debian platforms [\#6](https://github.com/dnsimple/chef-dnsimple/pull/6) ([mattkasa](https://github.com/mattkasa))
- Fix missing pkg dependencies, update to chef\_gem; add name to metadata. [\#5](https://github.com/dnsimple/chef-dnsimple/pull/5) ([mdxp](https://github.com/mdxp))
- Improvements to LWRP and Documentation [\#1](https://github.com/dnsimple/chef-dnsimple/pull/1) ([jtimberman](https://github.com/jtimberman))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
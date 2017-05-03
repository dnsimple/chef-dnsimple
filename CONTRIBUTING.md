# Contributing to the dnsimple Chef cookbook

We're excited that you'd like to help us with our Chef cookbook project!

## Getting in contact with us

In case you get stuck, feel free to email our helpful support staff at support@dnsimple.com and we'll do our best to get you back up and running.

## Submitting issues

When submitting an issue, please check the Issues section of this repository on Github to make sure it has not already been reported. If it has been reported, then please contribute to the conversation on the issue and provide any additional information you can. If it has not been reported, please be as detailed as possible.

If your issue is in regards to security, please refer to our [security page](https://dnsimple.com/security) on how to submit those more directly to us.

## Contribution process

1. Fork the repository to your own account if you have not yet done do already.
2. Commit changes to a git branch that is named after the changes you wish to contribute.
3. Create a GitHub Pull Request for your change, following the [Pull Request Requirements](#pull-request-requirements)
4. Perform a [Code Review](#code-review-process) with the cookbook maintainers on the pull request.

### Pull Request Requirements

In order to maintain a high standard of compatibility and consistency for the consumers of our cookbook we like to make sure all pull requests meet the following criteria:

1. **Tests:** To ensure high quality code and protect against regressions in the future we require all changes have ample test coverage. This does not mean 100% coverage or even specific types of coverage. See the TESTING.md file for details on how to run the test suite.
2. **Passing Continuous Integration (CI):** Speaking of tests, the contributed code must pass our full suite of tests on [Travis-CI][] and show a green indicator meaning the latest build passes. If for some reason the build is failing before your pull request please raise the issue in the pull request so we may address it.

### Code Review Process

Code review takes place in GitHub pull requests. See [this article](https://help.github.com/articles/about-pull-requests/) if you're not familiar with GitHub Pull Requests.

Once you open a pull request, cookbook maintainers will review your code using the built-in code review process in Github PRs. The process at this point is as follows:

1. A cookbook maintainer will review your code and merge it if no changes are necessary. Your change will be merged into the cookbooks's `master` branch and will be noted in the cookbook's `CHANGELOG.md` at the time of release.
2. If a maintainer has feedback or questions on your changes they they will set `request changes` in the review and provide an explanation.

## Contribution Guidelines

* **DO** include tests in your pull requests where applicable
* **DONT** modify or change the version number in the metadata.rb as we prefer to control the release cycle ourselves and it makes for code merging headaches that make everyone involved pretty sad
* **DONT** modify the CHANGELOG.md in your pull request as well. The maintainers will auto-generate this before a new release.
* **DO** remember that humans are handling your contributions so please be nice and polite when discussing anything in your pull request.

[security page]: https://dnsimple.com/security
[Travis-CI]: https://travis-ci.com

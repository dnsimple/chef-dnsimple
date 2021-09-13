# Releasing the DNSimple cookbook

1. Update the CHANGELOG.md with the upcoming changes. Minor versions are the
   default for any merged branches unless it is a hot fix. Major versions for
   breaking changes.
2. Update the metadata.rb version number and push your changes.
3. Make sure you have 'stove' installed in your ChefDK `chef gem install stove`
4. Double check you are logged in to your Chef Supermarket account like so:
   `chef exec stove login --username <username> --key ~/.chef/<username>.pem`
   If you get an error, double check your `~/.chef/` folder to make sure your
   Supermarket account key is in there.
5. `chef exec rake publish` to push the cookbook up to the Supermarket.

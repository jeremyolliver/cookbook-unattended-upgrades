# unattended-upgrades cookbook

[![Join the chat at https://gitter.im/jeremyolliver/cookbook-unattended-upgrades](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jeremyolliver/cookbook-unattended-upgrades?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This cookbook configures the unattended-upgrades package which performs automatic package updates on debian systems.

Build status:

[![Build Status](https://travis-ci.org/jeremyolliver/cookbook-unattended-upgrades.png?branch=master)](https://travis-ci.org/jeremyolliver/cookbook-unattended-upgrades)

CI automatically runs linting and unit tests. You may also run more thorough integration tests via Vagrant as well. See below for details on how to do that.

# Requirements

Debian or Ubuntu Operating System and the `apt` cookbook

# Usage

Simply include the cookbook "unattended-upgrades". Common config that you may want to change:

`node['unattended-upgrades']['admin_email']` Defaults to `'root@localhost'` Set to nil to disable email notification, or any other external email

`node['unattended-upgrades']['allowed_origins']`

Default value (at default precedence) is:

    {
      'security'  => true,
      'updates'   => false,
      'proposed'  => false,
      'backports' => false
    }

You can change this to enable non-critical updates by setting in a role or environment:

    "default_attributes": {
      "unattended-upgrades": {
        "allowed_origins": {
          "updates": true
        }
      }
    }

Please note that if you set your own changes at an `override` precedence, then the two hashes will not be merged together, and the full list should be specified again. e.g. alternately:

    "override_attributes": {
      "unattended-upgrades": {
        "allowed_origins": {
          "security":  true,
          "updates":   true,
          "proposed":  false,
          "backports": false
        }
      }
    }

TODO: Third party PPA's are not yet supported in the allowed origins section

`node['unattended-upgrades']['mail_only_on_error']` Set this to `true` if you want to skip mails for successful updates, however it can be helpful for troubleshooting to have a record of when packages were updated if you need to correlate when an error started occurring with the time packages were updated.

`node['unattended-upgrades']['minimal_steps']` Set this to `true` if you expect to be able to reboot the server with minimal interruption and the updates might be running at the time. With this left on the default value of false, the server will wait for all updates to complete before shutting down. See the full attributes list and the comments in the template file for more information. This cookbook has strived to provide configurable attributes for as many options as possible to allow maximum flexibility.

# Attributes

* `['unattended-upgrades']['admin_email']`
* `['unattended-upgrades']['package_blacklist']`
* `['unattended-upgrades']['autofix_dpkg']`
* `['unattended-upgrades']['minimal_steps']`
* `['unattended-upgrades']['install_on_shutdown']`
* `['unattended-upgrades']['mail_only_on_error']`
* `['unattended-upgrades']['remove_unused_dependencies']`
* `['unattended-upgrades']['automatic_reboot']`
* `['unattended-upgrades']['download_limit']`
* `['unattended_upgrades']['update_package_lists_interval']`
* `['unattended_upgrades']['upgrade_interval']`
* `['unattended_upgrades']['download_upgradeable_interval']`
* `['unattended_upgrades']['autoclean_interval']`

# Recipes

`unattended-upgrades::default`

# Cookbook Development

Running the tests for this cookbook involves:

Requires:
* ruby 1.9.2+
* bundler (`gem install bundler` and `bundle install`)
* Vagrant 1.2+ (and Virtualbox)
* `vagrant plugin install vagrant-berkshelf`

Run the lint tests via: `bundle exec rake style`. Run the full integration tests via: `bundle exec kitchen converge all` and `bundle exec kitchen verify all`. To remove the VM's `bundle exec kitchen destroy all`

# Author

Author:: Jeremy Olliver (<jeremy.olliver@gmail.com>)

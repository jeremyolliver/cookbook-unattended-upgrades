default['unattended-upgrades']['admin_email']                = 'root@localhost' # Set to nil to disable, or override to another value
default['unattended-upgrades']['package_blacklist']          = []
default['unattended-upgrades']['autofix_dpkg']               = true  # Strongly advised not to change
default['unattended-upgrades']['minimal_steps']              = false # Set to true to split upgrade into steps making it easier to interrupt
default['unattended-upgrades']['install_on_shutdown']        = false
default['unattended-upgrades']['mail_only_on_error']         = false
default['unattended-upgrades']['remove_unused_dependencies'] = false
default['unattended-upgrades']['automatic_reboot']           = false
default['unattended-upgrades']['download_limit']             = nil   # Set to Integer representing kb/sec limit

default['unattended-upgrades']['allowed_origins'] = {
  'security'  => true,
  'updates'   => false,
  'proposed'  => false,
  'backports' => false
}

default['unattended-upgrades']['apt_recipe'] = 'default'

# interval settings in days
default['unattended-upgrades']['update_package_lists_interval'] = 1
default['unattended-upgrades']['upgrade_interval'] = 1 # In order for unattended upgrades to run at all, this must be set to an integer greater than or equal to 1
default['unattended-upgrades']['download_upgradeable_interval'] = nil
default['unattended-upgrades']['autoclean_interval'] = nil

default['unattended-upgrades']['enable'] = 1
default['unattended-upgrades']['update_package_list_interval'] = 1
default['unattended-upgrades']['download_upgradeable_packages_interval'] = 1
default['unattended-upgrades']['autoclean_interval'] = 7
default['unattended-upgrades']['unattended_upgrade_interval'] = 1

default['unattended-upgrades']['admin_email']                = 'root@localhost' # Set to nil to disable, or override to another value
default['unattended-upgrades']['package_blacklist']          = []
default['unattended-upgrades']['autofix_dpkg']               = true  # Strongly advised not to change
default['unattended-upgrades']['minimal_steps']              = false # Set to true to split upgrade into steps making it easier to interrupt
default['unattended-upgrades']['install_on_shutdown']        = false
default['unattended-upgrades']['mail_only_on_error']         = false
default['unattended-upgrades']['remove_unused_dependencies'] = false
default['unattended-upgrades']['automatic_reboot']           = false
default['unattended-upgrades']['download_limit']             = nil   # Set to Integer representing kb/sec limit

case node['platform']
when 'ubuntu'
  default['unattended-upgrades']['allowed_origins'] = {
    'security'  => true,
    'updates'   => false,
    'proposed'  => false,
    'backports' => false
  }
when 'debian'
  if node['platform_version'].to_f < 7
    default['unattended-upgrades']['allowed_origins'] = {
      'oldstable'         => true,
      'security'          => true,
      'backports'         => false
    }
  else
    default['unattended-upgrades']['origins_pattern'] = {
      'o=Debian,a=stable' => false,
      'o=Debian,a=stable-updates' => false,
      'o=Debian,a=proposed-updates' => false,
      'o=Debian,a=stable-backports' => false,
      'o=Debian,a=stable,l=Debian-Security' => true
    }
  end
end


default['unattended-upgrades']['apt_recipe'] = 'default'


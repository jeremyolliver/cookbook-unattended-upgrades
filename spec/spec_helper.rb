require 'chefspec'
ChefSpec::Coverage.start!

require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform:   'ubuntu',
  version:    '12.04',
  log_level:  ::LOG_LEVEL
}
::DEBIAN_OPTS = {
  platform:  'debian',
  version:   '7.4',
  log_level: ::LOG_LEVEL
}
::CHEFSPEC_OPTS = {
  log_level:  ::LOG_LEVEL
}

def stub_resources
end

at_exit { ChefSpec::Coverage.report! }

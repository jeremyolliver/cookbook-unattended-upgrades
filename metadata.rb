name             "unattended-upgrades"
maintainer       "Jeremy Olliver"
maintainer_email "jeremy.olliver@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures unattended-upgrades"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

# supports "debian" # Untested
supports "ubuntu"

depends "apt"

provides "unattended-upgrades::default"

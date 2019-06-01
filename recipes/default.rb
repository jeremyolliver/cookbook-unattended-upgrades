#
# Cookbook Name:: unattended-upgrades
# Recipe:: default
#
# Copyright (C) 2013 Jeremy Olliver
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# include apt::default (or an alternate apt recipe)
include_recipe "apt::#{node['unattended-upgrades']['apt_recipe']}"

package 'unattended-upgrades'

# Stock systems should already have a compatible mail delivery mechanism (e.g. mailx binary) installed - warn if one is not detected
ruby_block 'warn-on-missing-mailer' do
  block do
    Chef::Log.warn("No mail package detected. If you want to be able to mail the output of unattended-upgrades, you should a package provides the `mailx` such as 'mailutils' or 'heirloom-mailx'")
  end
  not_if 'which mailx'
end

template '/etc/apt/apt.conf.d/50unattended-upgrades' do
  source 'unattended-upgrades.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  variables(
    :allowed_origins               => node['unattended-upgrades']['allowed_origins'],
    :package_blacklist             => node['unattended-upgrades']['package_blacklist'],
    :autofix_dpkg                  => node['unattended-upgrades']['autofix_dpkg'],
    :minimal_steps                 => node['unattended-upgrades']['minimal_steps'],
    :install_on_shutdown           => node['unattended-upgrades']['install_on_shutdown'],
    :admin_email                   => node['unattended-upgrades']['admin_email'],
    :mail_only_on_error            => node['unattended-upgrades']['mail_only_on_error'],
    :remove_unused_dependencies    => node['unattended-upgrades']['remove_unused_dependencies'],
    :remove_unused_kernel_packages => node['unattended-upgrades']['remove_unused_kernel_packages'],
    :automatic_reboot              => node['unattended-upgrades']['automatic_reboot'],
    :automatic_reboot_time         => node['unattended-upgrades']['automatic_reboot_time'],
    :download_limit                => node['unattended-upgrades']['download_limit'],
    :syslog_enable                 => node['unattended-upgrades']['syslog_enable'],
    :syslog_facility               => node['unattended-upgrades']['syslog_facility']
  )
end

template '/etc/apt/apt.conf.d/20auto-upgrades' do
  source 'auto-upgrades.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  variables(
    :update_package_lists_interval => node['unattended-upgrades']['update_package_lists_interval'],
    :upgrade_interval              => node['unattended-upgrades']['upgrade_interval'],
    :download_upgradeable_interval => node['unattended-upgrades']['download_upgradeable_interval'],
    :autoclean_interval            => node['unattended-upgrades']['autoclean_interval'],
  )
end

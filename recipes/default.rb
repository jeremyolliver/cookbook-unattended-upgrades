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

if node['unattended-upgrades']['admin_email']
  package 'mailutils' # provides 'mailx' to ensure we can mail notification of any issues
end

template '/etc/apt/apt.conf.d/10periodic' do
  source '10periodic.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

template '/etc/apt/apt.conf.d/50unattended-upgrades' do
  source 'unattended-upgrades.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  variables(
    :allowed_origins            => node['unattended-upgrades']['allowed_origins'],
    :origins_pattern            => node['unattended-upgrades']['origins_pattern'],
    :package_blacklist          => node['unattended-upgrades']['package_blacklist'],
    :autofix_dpkg               => node['unattended-upgrades']['autofix_dpkg'],
    :minimal_steps              => node['unattended-upgrades']['minimal_steps'],
    :install_on_shutdown        => node['unattended-upgrades']['install_on_shutdown'],
    :admin_email                => node['unattended-upgrades']['admin_email'],
    :mail_only_on_error         => node['unattended-upgrades']['mail_only_on_error'],
    :remove_unused_dependencies => node['unattended-upgrades']['remove_unused_dependencies'],
    :automatic_reboot           => node['unattended-upgrades']['automatic_reboot'],
    :download_limit             => node['unattended-upgrades']['download_limit']
  )
end
